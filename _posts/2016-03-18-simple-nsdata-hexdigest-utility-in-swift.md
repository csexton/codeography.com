---
layout: post
title: Simple NSData hexdigest utility in swift
---

I needed an easy way to convert `NSData` to a hexdigest in swift. Since I am working on library code addin extensions to core classes would be bad form, so what I needed was a simple utility I could drop into a class.

```swift
private func hexdigest(data: NSData) -> String {
  var hex = String()
  let bytes = UnsafePointer<CUnsignedChar>(data.bytes)
  for (var i: Int=0; i<data.length; ++i) {
    hex += String(format: "%02x", bytes[i])
  }
  return hex
}
```


