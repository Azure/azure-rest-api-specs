# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.KeyVault/stable/2018-02-14/keyvault.json
  - $(this-folder)/Microsoft.KeyVault/stable/2018-02-14/providers.json
  - $(this-folder)/Microsoft.KeyVault/stable/2016-10-01/keyvault.json
  - $(this-folder)/Microsoft.KeyVault/stable/2016-10-01/providers.json
  - $(this-folder)/Microsoft.KeyVault/stable/2015-06-01/keyvault.json
require: $(this-folder)/../../../../profiles/readme.md
```
