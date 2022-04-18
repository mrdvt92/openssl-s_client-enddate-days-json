# openssl-s_client-enddate-days-json
Perl script wrapper for openssl s_client to retrieve enddate and calculate days to certificate notAfter date then export as json

I use this script to monitor my HTTPS sites with Node-Red to send me notification when the certificate enddate is less than 10 days away. 

```json
{
   "enddate" : "2023-05-13T09:26:00Z",
   "enddate_epoch" : "1683969960",
   "days" : 390.282465277778
}
```
