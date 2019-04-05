# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Logic/preview/2018-07-01-preview/logic.json
  - $(this-folder)/Microsoft.Logic/stable/2016-06-01/logic.json
  - $(this-folder)/Microsoft.Logic/preview/2015-08-01-preview/logic.json
  - $(this-folder)/Microsoft.Logic/preview/2015-02-01-preview/logic.json
require: $(this-folder)/../../../../profiles/readme.md
```
