# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Storage.Admin/preview/2015-12-01/storage.json
  - Microsoft.Storage.Admin/preview/2015-12-01/acquisitions.json
  - Microsoft.Storage.Admin/preview/2015-12-01/blobServices.json
  - Microsoft.Storage.Admin/preview/2015-12-01/containers.json
  - Microsoft.Storage.Admin/preview/2015-12-01/farms.json
  - Microsoft.Storage.Admin/preview/2015-12-01/queueServices.json
  - Microsoft.Storage.Admin/preview/2015-12-01/quotas.json
  - Microsoft.Storage.Admin/preview/2015-12-01/shares.json
  - Microsoft.Storage.Admin/preview/2015-12-01/storageaccounts.json
  - Microsoft.Storage.Admin/preview/2015-12-01/tableServices.json
require: $(this-folder)/../../../../../profiles/readme.md
```
