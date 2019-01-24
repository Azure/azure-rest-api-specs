# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.GuestConfiguration/stable/2018-11-20/guestconfiguration.json
  - >-
    Microsoft.GuestConfiguration/preview/2018-06-30-preview/guestconfiguration.json
  - >-
    Microsoft.GuestConfiguration/preview/2018-01-20-preview/guestconfiguration.json
```
