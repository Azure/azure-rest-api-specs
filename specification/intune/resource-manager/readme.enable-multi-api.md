# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Intune/preview/2015-01-14-preview/intune.json
  - $(this-folder)/Microsoft.Intune/preview/2015-01-14-privatepreview/intune.json
require: $(this-folder)/../../../../profiles/readme.md
```
