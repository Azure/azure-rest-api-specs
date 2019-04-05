# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.AAD/stable/2017-06-01/domainservices.json
  - $(this-folder)/Microsoft.AAD/stable/2017-01-01/domainservices.json
require: $(this-folder)/../../../../profiles/readme.md
```
