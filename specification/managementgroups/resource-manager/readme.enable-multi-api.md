# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Management/preview/2018-03-01-preview/management.json
  - Microsoft.Management/preview/2018-01-01-preview/management.json
  - Microsoft.Management/preview/2017-11-01-preview/management.json
  - Microsoft.Management/preview/2017-08-31-preview/management.json
require: $(this-folder)/../../../../profiles/readme.md
```
