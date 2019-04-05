# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.KeyVault.Admin/preview/2017-02-01-preview/KeyVault.json
  - $(this-folder)/Microsoft.KeyVault.Admin/preview/2017-02-01-preview/Quotas.json
require: $(this-folder)/../../../../../profiles/readme.md
```
