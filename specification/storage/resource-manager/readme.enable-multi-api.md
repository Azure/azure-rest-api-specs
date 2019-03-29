# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Storage/stable/2018-11-01/storage.json
  - Microsoft.Storage/stable/2018-11-01/blob.json
  - Microsoft.Storage/stable/2018-07-01/storage.json
  - Microsoft.Storage/stable/2018-07-01/blob.json
  - Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json
  - Microsoft.Storage/preview/2018-03-01-preview/storage.json
  - Microsoft.Storage/preview/2018-03-01-preview/blob.json
  - Microsoft.Storage/stable/2018-02-01/storage.json
  - Microsoft.Storage/stable/2018-02-01/blob.json
  - Microsoft.Storage/stable/2017-10-01/storage.json
  - Microsoft.Storage/stable/2017-06-01/storage.json
  - Microsoft.Storage/stable/2016-12-01/storage.json
  - Microsoft.Storage/stable/2016-05-01/storage.json
  - Microsoft.Storage/stable/2016-01-01/storage.json
  - Microsoft.Storage/stable/2015-06-15/storage.json
  - Microsoft.Storage/preview/2015-05-01-preview/storage.json
```
