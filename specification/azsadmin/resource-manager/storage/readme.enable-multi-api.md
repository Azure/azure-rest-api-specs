# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/storage.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/acquisitions.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/blobServices.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/containers.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/farms.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/queueServices.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/quotas.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/shares.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/storageaccounts.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2015-12-01/tableServices.json
require: $(this-folder)/../../../../../profiles/readme.md
```
