# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.RecoveryServices/stable/2018-07-10/service.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2018-01-10/service.json
  - $(this-folder)/Microsoft.RecoveryServices/stable/2016-08-10/service.json
require: $(this-folder)/../../../../profiles/readme.md
```
