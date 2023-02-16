# openssl-s_client-enddate-days-json

Perl script wrapper for openssl s_client to retrieve enddate and calculate days to certificate notAfter date then export as json

I use this script to monitor my HTTPS sites with Node-Red to send me notification when the certificate enddate is less than 10 days away. 

```json
{
   "enddate" : "2023-05-13T09:26:00Z",
   "enddate_epoch" : "1683969960",
   "port" : "443",
   "days" : 390.254502314815,
   "host" : "www.cliftonva.org"
}
```

## See Also

  - [bartbutenaers/node-red-contrib-certificate-grabber](https://github.com/bartbutenaers/node-red-contrib-certificate-grabber) - A Node-RED node to capture certificates from TLS/SSL connections
  - [hirose31/Net-SSL-ExpireDate](https://github.com/hirose31/Net-SSL-ExpireDate) - A Perl libraery to obtain expiration date of certificates from TLS/SSL connections
