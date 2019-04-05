# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/registeredidentities.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/replicationusages.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/vaults.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/vaultusages.json
require: $(this-folder)/../../../../profiles/readme.md
```
