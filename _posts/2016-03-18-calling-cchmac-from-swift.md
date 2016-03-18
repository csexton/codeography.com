---
layout: post
title: Calling CCHmac from swift
---

I wanted to keep things minimal. Avoid the added complexity of creating a generic class that could handle all the different digest types and instead just have a small method I could drop into a class if needed. I also prefer to avoid adding categories to core classes, so adding an extension to `NSString` wasn't really what I wanted.

Add the following include to your `-Bridging-Header.h` file:

```objective-c
#import <CommonCrypto/CommonHMAC.h>
```

Then in the class that needs to call CCHmac() add a private method:


```swift
private func hmac(string: NSString, key: NSData) -> NSData {
  let keyBytes = UnsafePointer<CUnsignedChar>(key.bytes)
  let data = string.cStringUsingEncoding(NSUTF8StringEncoding)
  let dataLen = Int(string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
  let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
  let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
  CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes, key.length, data, dataLen, result);
  return NSData(bytes: result, length: digestLen)
}
```

If I need a different `CCHmacAlgorithm` I would just replace the two constants in that method with the appropriate ones.

