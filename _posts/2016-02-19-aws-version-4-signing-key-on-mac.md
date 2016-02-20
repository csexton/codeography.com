---
layout: post
title: AWS Version 4 Signing Key on Mac
---

# How to Derive a Version 4 Signing Key for a Mac App

I have been working on a major update to [Captured](http://www.capturedapp.com/), and heard back from one of the beta testers that uses S3 in the `eu-central-1` region. Turns out that is one of the newer regions that requires the `AWS4-HMAC-SHA256` Authorization Method. After a bit of research I found Amazon's [Signature Version 4 Signing Process](http://docs.aws.amazon.com/general/latest/gr/signature-version-4.html) which describes how to do the signing. They even provide a [few code examples](http://docs.aws.amazon.com/general/latest/gr/signature-v4-examples.html#signature-v4-examples-other), however they didn't have any that used Swift or Objective-C.

I really wanted to use swift, since the vast majority of Captured is written in swift, but I quicly discovered the pain that is C-interop. So I wrote an Objective-C class that will deal with that. And after a simple line in my bridging header it was very easy to use in swift.

If you want to do this in Objective-C, here's the tl;dr:

## Deriving the Signing Key with Objective C

```objective-c
+ (NSData *)hmacSha256ForString:(NSString *)stringToSign withKey:(NSData *)key {
  NSData *dataToSign = [stringToSign dataUsingEncoding:NSUTF8StringEncoding];
  unsigned char rawDigest[CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, [key bytes], [key length], [dataToSign bytes], [dataToSign length], rawDigest);
  return [[NSData alloc] initWithBytes:rawDigest length:CC_SHA256_DIGEST_LENGTH];
}

+ (NSData *)getSignatureKey:(NSString *)key dateStamp:(NSString *)dateStamp regionName:(NSString *)regionName serviceName:(NSString *)serviceName {
  NSData *kSecret = [[NSString stringWithFormat:@"AWS4%@", key] dataUsingEncoding:NSUTF8StringEncoding];
  NSData *kDate = [self hmacSha256ForString: dateStamp withKey:kSecret];
  NSData *kRegion = [self hmacSha256ForString: regionName withKey:kDate];
  NSData *kService = [self hmacSha256ForString: serviceName withKey:kRegion];
  NSData *kSigning = [self hmacSha256ForString: @"aws4_request" withKey:kService];

  return kSigning;
}
```

## Few more details:

I added a few `NSLog` statements to test thigns along the way. This turned out to be very importatn, because I had a few bugs (mostly around buffer lengths) that would make things look like they were working. The first few steps matched the reference output, but not all of them. I needed all of the steps to work. Here is my test code that I ran to get things working:

```objective-c
#import <CommonCrypto/CommonHMAC.h>
#import "AWS4SigningKey.h"

@implementation AWS4SigningKey

+ (NSData *)hmacSha256ForString:(NSString *)stringToSign withKey:(NSData *)key {
  NSData *dataToSign = [stringToSign dataUsingEncoding:NSUTF8StringEncoding];
  unsigned char rawDigest[CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, [key bytes], [key length], [dataToSign bytes], [dataToSign length], rawDigest);
  return [[NSData alloc] initWithBytes:rawDigest length:CC_SHA256_DIGEST_LENGTH];
}

+ (NSData *)getSignatureKey:(NSString *)key
                     dateStamp:(NSString *)dateStamp
                    regionName:(NSString *)regionName
                   serviceName:(NSString *)serviceName {

  NSData *kSecret = [[NSString stringWithFormat:@"AWS4%@", key] dataUsingEncoding:NSUTF8StringEncoding];
  NSLog(@"%@", [kSecret description]);

  NSData *kDate = [self hmacSha256ForString: dateStamp withKey:kSecret];
  NSLog(@"%@", [kDate description]);

  NSData *kRegion = [self hmacSha256ForString: regionName withKey:kDate];
  NSLog(@"%@", [kRegion description]);

  NSData *kService = [self hmacSha256ForString: serviceName withKey:kRegion];
  NSLog(@"%@", [kService description]);

  NSData *kSigning = [self hmacSha256ForString: @"aws4_request" withKey:kService];
  NSLog(@"%@", [kSigning description]);

  return kSigning;
}

@end
```

This output:

```
2016-02-19 23:00:34.493 Captured[29081:3568690] <41575334 774a616c 72585574 6e46454d 492f4b37 4d44454e 472b6250 78526669 43594558 414d504c 454b4559>
2016-02-19 23:00:34.493 Captured[29081:3568690] <969fbb94 feb542b7 1ede6f87 fe4d5fa2 9c789342 b0f40747 4670f0c2 489e0a0d>
2016-02-19 23:00:34.493 Captured[29081:3568690] <69daa020 9cd9c5ff 5c8ced46 4a696fd4 252e9814 30b10e3d 3fd8e2f1 97d7a70c>
2016-02-19 23:00:34.493 Captured[29081:3568690] <f72cfd46 f26bc464 3f06a11e abb6c0ba 18780c19 a8da0c31 ace67126 5e3c87fa>
2016-02-19 23:00:34.493 Captured[29081:3568690] <f4780e2d 9f65fa89 5f9c67b3 2ce1baf0 b0d8a435 05a000a1 a9e090d4 14db404d>
```

Which if you delete a few extra spaces, you'll notice matches the reference from the AWS documentation:

```
kSecret  = '41575334774a616c725855746e46454d492f4b374d44454e472b62507852666943594558414d504c454b4559'
kDate    = '969fbb94feb542b71ede6f87fe4d5fa29c789342b0f407474670f0c2489e0a0d'
kRegion  = '69daa0209cd9c5ff5c8ced464a696fd4252e981430b10e3d3fd8e2f197d7a70c'
kService = 'f72cfd46f26bc4643f06a11eabb6c0ba18780c19a8da0c31ace671265e3c87fa'
kSigning = 'f4780e2d9f65fa895f9c67b32ce1baf0b0d8a43505a000a1a9e090d414db404d'
```

High-fives all around!

I'd prefer a pure-Swift solution, but this bit of objective-c and the fact that I can omit all the hacky-marshaling to C functions makes me pretty happy. You can find the full class definition [here](https://gist.github.com/csexton/c2963dd1af4cf4e1dfdb).
