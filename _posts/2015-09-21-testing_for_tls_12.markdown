---
title: Testing for TLS 1.2
layout: post
date: 2015-09-21
---

iOS 9 requires all `NSURLConnection` connections to [support TLS 1.2](https://developer.apple.com/library/ios/technotes/tn2287/_index.html). So I needed to check my servers to see if this was indeed configured. After looking around a bit I was able to find that you could test for this using `openssl`.

On OS X with homebrew you can test with this command:

```
/usr/local/Cellar/openssl/1.0.2d_1/bin/openssl s_client -tls1_2 -connect www.codeography.com:443
```

If you have linux (with a new enough `openssl`) or have overridden the system `openssl` on OS X you can just leave off the full path:

```
openssl s_client -tls1_2 -connect www.codeography.com:443
```

If it is supported you'll see the Certificate chain as well as some information about the connection. The bit I was looking for was "Protocol: TLSv1.2"

Looked something like this:

```
New, TLSv1/SSLv3, Cipher is ECDHE-RSA-AES128-GCM-SHA256
SSL-Session:
    Protocol  : TLSv1.2
    TLS session ticket lifetime hint: 1200 (seconds)
```
