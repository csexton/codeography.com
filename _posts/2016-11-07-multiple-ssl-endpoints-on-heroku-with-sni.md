---
layout: post
title: Multiple SSL endpoints on Heroku with SNI
---

I recently added another domain to an app I host on Heroku. And I ran into a problem:

```
Only one SNI endpoint is allowed per app (try certs:update instead).
```

You can't have more than one cert on a SNI endpoint. Turns out you don't need more than one cert. You just need a Multi-Domain cert.

Luckily you can get one pretty easily, as long as you know a few tricks to set it up. I got to admit I was a little worried about the manual steps for setting up the openssl config and CSR, but it was worth risking $25 to save $360/year in SSL endpoints on heroku. Turns out this even works with wildcards.


### 1. Buy Multi-Domain SSL Cert

I bought a "Comodo PositiveSSL Multi-Domain" from [SSLs.com](https://www.ssls.com/ssl-certificates/comodo-positivessl-multi-domain). Buy it first, and you will add the domains and "Activate" it later.

### 2. Create the Signing Request (CSR)

This is specific to a Mac, but should work on other platforms if you adjust a few paths.

First lets make a folder to put all our files in:

```
mkdir mydomain_com_multidomain
cd mydomain_com_multidomain
```

Copy the default `openssl.cnf file :

```
cp /System/Library/OpenSSL/openssl.cnf .
```

Edit that new file, and modify the folling sections:

At the end of the `[ req ]` add:

```
req_extensions = v3_req
```

At the end of `[ v3_req ]` add:

```
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = foo.net
DNS.2 = bar.com
DNS.3 = *.baz.com
```

Just enter the domain you want. As you can see this will even work with wildcard domains. Unlike some other certs, you will have to enter seperate domains for "www.foo.com and "foo.com".

You can see a full example of the file here: [`openssl.cnf`](https://gist.github.com/csexton/ca9971f24001bf504181745ec779ca8e).

Generate a signing key:

```
openssl genrsa -out server.key 2048
```

Generate the CSR:

```
openssl req -nodes -newkey rsa:2048 -keyout server.key -out server.csr -config openssl.cnf
```

You'll be asked a bunch of questions. It's best to not leave any blank, but as far as I can tell it doesn't matter much what they are. Entering "NA" is totally acceptable.

### 3. Activate that cert

Back on the browser on SSLs.com. They will ask for your CSR, just copy and paste:

```
cat server.csr | pbcopy
```

Follow their flow, and confirm your domains. Once that's done they'll email you a zip file with the certs.

### 4. bundle the certs into one file.

This is important for some browsers to work, like Chrome.

Unzip the attachemt they emailed you into the dir you created above, then cat the files together. Order is important:

```
cat YOUR_CERT.crt COMODORSADomainValidationSecureServerCA.crt cOMODORSAAddTrustCA.crt AddTrustExternalCARoot.crt > multidomain-bundle.pem
```

### 5. Add the cert to Heroku using SNI

Almost there, just one last step

```
heroku certs:add path/to/multidomain-bundle.pem path/to/server.key
```

Heroku will let you knwo the domains and DNS setting you'll need:

```
=== Your certificate has been added successfully.  Update your application's DNS settings as follows
Domain                        Record Type  DNS Target
────────────────────────────  ───────────  ──────────────────────────────────────────
foo.bar.com                   CNAME        foo.bar.com.herokudns.com
baz.net                       ALIAS/ANAME  baz.net.herokudns.com
```

Add those to DNS and you should be good. If you already had a cert on your domain you'll need to remove it first with `heroku certs:remove`


All the SSL stuff is turtles all the way down, so hopefully this guide saves you some time.





