# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.KeyVault/stable/7.0/keyvault.json
  - $(this-folder)/Microsoft.KeyVault/stable/2016-10-01/keyvault.json
  - $(this-folder)/Microsoft.KeyVault/stable/2015-06-01/keyvault.json
require: $(this-folder)/../../../profiles/readme.md
```
