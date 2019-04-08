# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.RecoveryServices/stable/2017-07-01/bms.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-12-01/bms.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-08-10/operations.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/recoveryservicesbackup.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-06-01/registeredIdentities.json
require: $(this-folder)/../../../profiles/readme.md
```
