# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ManagedIdentity/stable/2018-11-30/ManagedIdentity.json
  - $(this-folder)/Microsoft.ManagedIdentity/preview/2015-08-31-preview/ManagedIdentity.json
require: $(this-folder)/../../../../profiles/readme.md
```
