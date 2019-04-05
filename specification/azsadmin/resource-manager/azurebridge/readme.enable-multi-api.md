# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.AzureBridge.Admin/preview/2016-01-01/AzureBridge.json
  - $(this-folder)/Microsoft.AzureBridge.Admin/preview/2016-01-01/DownloadedProduct.json
  - $(this-folder)/Microsoft.AzureBridge.Admin/preview/2016-01-01/Product.json
  - $(this-folder)/Microsoft.AzureBridge.Admin/preview/2016-01-01/Activation.json
require: $(this-folder)/../../../../../profiles/readme.md
```
