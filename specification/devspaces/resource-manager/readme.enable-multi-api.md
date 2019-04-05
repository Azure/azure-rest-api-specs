# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DevSpaces/preview/2019-01-01-preview/devspaces.json
  - $(this-folder)/Microsoft.DevSpaces/preview/2018-06-01-preview/devspaces.json
require: $(this-folder)/../../../../profiles/readme.md
```
