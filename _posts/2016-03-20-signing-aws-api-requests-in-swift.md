---
layout: post
title: Signing AWS API Requests in Swift
---

Previously [Captured](http://www.capturedapp.com/) would just post to S3's REST API directly, but Amazon has decided to deprecate the fairly straightforward HTTP signing they had. So unless you are using region that has support granfathered, you need to use the newer V4 Signing process.

Since the [AWS SDK for Objective C](https://github.com/aws/aws-sdk-ios) doesn't support OS X, I set out to do the singing myself. AWS had pretty good documentation for it, so how hard could this be?

It was way more effort than I expected. This became my White Whale. And spent way too much time on it. Spent hours troubleshooting an extra slash in the request, or having the wrong case for a hexdigest. But I had to win. The kids can make their own dinner, HMAC ain't gonna authenticate it self.

So I am posting the code here in case it helps someone.

---

See the [Signature Version 4 Signing Process](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html) for the official documentation. Most of this code was carefully, nay, painstakingly [ported from ruby](https://github.com/aws/aws-sdk-ios/blob/440d3141/AWSCore/Authentication/AWSSignature.m)

A few shortcuts were taken with this (doesn't handle query params, or strip whitespace from headers), but it is working great in my app with S3.

```swift
// S3V4Uploader.swift
import Foundation

class S3V4Signer {
  let accessKey: String
  let secretKey: String
  let regionName: String
  let serviceName: String

  required init(accessKey: String, secretKey: String, regionName: String, serviceName: String = "s3") {
    self.accessKey = accessKey
    self.secretKey = secretKey
    self.regionName = regionName
    self.serviceName = serviceName
  }

  func signedHeaders(url: NSURL, bodyDigest: String, httpMethod: String = "PUT", date: NSDate = NSDate()) -> [String: String] {
    let datetime = timestamp(date)

    var headers = [
      "x-amz-content-sha256": bodyDigest,
      "x-amz-date": datetime,
      "x-amz-acl" : "public-read",
      "Host": url.host!,
    ]
    headers["Authorization"] = authorization(url, headers: headers, datetime: datetime, httpMethod: httpMethod, bodyDigest: bodyDigest)

    return headers
  }

  // MARK: Utilities

  private func pathForURL(url: NSURL) -> String {
    var path = url.path
    if (path ?? "").isEmpty {
      path = "/"
    }
    return path!
  }

  func sha256(str: String) -> String {
    let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
    var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
    CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
    let res = NSData(bytes: hash, length: Int(CC_SHA256_DIGEST_LENGTH))
    return hexdigest(res)
  }

  private func hmac(string: NSString, key: NSData) -> NSData {
    let keyBytes = UnsafePointer<CUnsignedChar>(key.bytes)
    let data = string.cStringUsingEncoding(NSUTF8StringEncoding)
    let dataLen = Int(string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
    let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes, key.length, data, dataLen, result);
    return NSData(bytes: result, length: digestLen)
  }

  private func hexdigest(data: NSData) -> String {
    var hex = String()
    let bytes =  UnsafePointer<CUnsignedChar>(data.bytes)

    for (var i: Int=0; i<data.length; ++i) {
      hex += String(format: "%02x", bytes[i])
    }
    return hex
  }

  private func timestamp(date: NSDate) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
    formatter.timeZone = NSTimeZone(name: "UTC")
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return formatter.stringFromDate(date)
  }

  // MARK: Methods Ported from AWS SDK

  private func authorization(url: NSURL, headers: Dictionary<String, String>, datetime: String, httpMethod: String, bodyDigest: String) -> String {
    let cred = credential(datetime)
    let shead = signedHeaders(headers)
    let sig = signature(url, headers: headers, datetime: datetime, httpMethod: httpMethod, bodyDigest: bodyDigest)

    return [
      "AWS4-HMAC-SHA256 Credential=\(cred)",
      "SignedHeaders=\(shead)",
      "Signature=\(sig)",
      ].joinWithSeparator(", ")
  }

  private func credential(datetime: String) -> String {
    return "\(accessKey)/\(credentialScope(datetime))"
  }

  private func signedHeaders(headers: [String:String]) -> String {
    var list = Array(headers.keys).map { $0.lowercaseString }.sort()
    if let itemIndex = list.indexOf("authorization") {
      list.removeAtIndex(itemIndex)
    }
    return list.joinWithSeparator(";")
  }

  private func canonicalHeaders(headers: [String: String]) -> String {
    var list = [String]()
    let keys = Array(headers.keys).sort {$0.localizedCompare($1) == NSComparisonResult.OrderedAscending}

    for key in keys {
      if key.caseInsensitiveCompare("authorization") != NSComparisonResult.OrderedSame {
        // Note: This does not strip whitespace, but the spec says it should
        list.append("\(key.lowercaseString):\(headers[key]!)")
      }
    }
    return list.joinWithSeparator("\n")
  }

  private func signature(url: NSURL, headers: [String: String], datetime: String, httpMethod: String, bodyDigest: String) -> String {
    let secret = NSString(format: "AWS4%@", secretKey).dataUsingEncoding(NSUTF8StringEncoding)!
    let date = hmac(datetime.substringToIndex(datetime.startIndex.advancedBy(8)), key: secret)
    let region = hmac(regionName, key: date)
    let service = hmac(serviceName, key: region)
    let credentials = hmac("aws4_request", key: service)
    let string = stringToSign(datetime, url: url, headers: headers, httpMethod: httpMethod, bodyDigest: bodyDigest)
    let sig = hmac(string, key: credentials)
    return hexdigest(sig)
  }

  private func credentialScope(datetime: String) -> String {
    return [
      datetime.substringToIndex(datetime.startIndex.advancedBy(8)),
      regionName,
      serviceName,
      "aws4_request"
      ].joinWithSeparator("/")
  }

  private func stringToSign(datetime: String, url: NSURL, headers: [String: String], httpMethod: String, bodyDigest: String) -> String {
    return [
      "AWS4-HMAC-SHA256",
      datetime,
      credentialScope(datetime),
      sha256(canonicalRequest(url, headers: headers, httpMethod: httpMethod, bodyDigest: bodyDigest)),
      ].joinWithSeparator("\n")
  }

  private func canonicalRequest(url: NSURL, headers: [String: String], httpMethod: String, bodyDigest: String) -> String {
    return [
      httpMethod,                       // HTTP Method
      pathForURL(url),                  // Resource Path
      url.query ?? "",                  // Canonicalized Query String
      "\(canonicalHeaders(headers))\n", // Canonicalized Header String (Plus a newline for some reason)
      signedHeaders(headers),           // Signed Headers String
      bodyDigest,                       // Sha265 of Body
      ].joinWithSeparator("\n")
  }
}
```


To use this code:

- You will need a file to upload, and a SHA256 Hash of that file
- Create a `S3V4Signer` with your AWS creds and the file info
- Copy all the headers returned into your request object

```swift
let path = "path/to/file.png"
let bodyDigest = FileHash.sha256HashOfFileAtPath(path)!
let url = NSURL(string: "https://capturedeu.s3-eu-central-1.amazonaws.com/remote-file-name")!
let request = NSMutableURLRequest(URL: url)
let fileStream = NSInputStream(fileAtPath: path)!

request.HTTPMethod = "PUT"
request.HTTPBodyStream = fileStream

let signer = S3V4Signer(accessKey: accessKey!, secretKey: secretKey!, regionName: regionName!)
let headers = signer.signedHeaders(url, bodyDigest: bodyDigest)

for (key, value) in headers {
  request.addValue(value, forHTTPHeaderField: key)
}
request.addValue(sizeForPath(path), forHTTPHeaderField: "Content-Length")
request.addValue("image/png", forHTTPHeaderField: "Content-Type")

var response: NSURLResponse?
do {
  let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
  if let httpResponse = response as? NSHTTPURLResponse {
    let text = NSString(data:data, encoding:NSUTF8StringEncoding) as? String
    NSLog("Response from AWS S3: \(httpResponse.description)\n\(text!)")
  }
} catch (let e) {
  print(e)
}
```

The final integration test for this class. I was able to TDD my way through the while porting things, but wanted to make most of the methods private so wound up deleting many of the intermediate tests. I am confident this will catch any breaking changes for my use.

```swift
import XCTest

class S3V4SignerTests: XCTestCase {
  let accessKey = "AKIAJODU6PESZF6ENZ2A"
  let secretKey = "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" // This key has been deleted, BTW
  let regionName = "eu-central-1"
  let bodyDigest = "96fe862bffd24748621f5e6b1938c3f7a8a18569c82b68dccad1e22b20533440"

  func testAuthorizationHeader() {
    let now = parseDate("20160318T003250Z")
    let url = NSURL(string: "https://capturedeu.s3-eu-central-1.amazonaws.com/xrQ77e9S")!
    let signer = S3V4Signer(accessKey: accessKey, secretKey: secretKey, regionName: regionName)
    let headers = signer.signedHeaders(url, bodyDigest: bodyDigest, httpMethod: "PUT", date: now)
    let expected = "AWS4-HMAC-SHA256 Credential=AKIAJODU6PESZF6ENZ2A/20160318/eu-central-1/s3/aws4_request, SignedHeaders=host;x-amz-acl;x-amz-content-sha256;x-amz-date, Signature=1d83730c0ad27d6b50864f770a6cac8467053d14fb7381cf6f123b2d21f1ae03"

    XCTAssert(expected == headers["Authorization"])
  }

  func parseDate(date: String) -> NSDate {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
    formatter.timeZone = NSTimeZone(name: "UTC")
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return formatter.dateFromString(date)!
  }
}
```

I would love to hear if you found this helpful.

All code in this post covered by the [Apache 2.0 License](https://en.wikipedia.org/wiki/MIT_License), as was the [code from which](https://github.com/aws/aws-sdk-ios/blob/master/LICENSE) it was ported.
