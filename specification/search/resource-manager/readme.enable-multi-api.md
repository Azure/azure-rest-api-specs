# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Search/stable/2015-08-19/search.json
  - $(this-folder)/Microsoft.Search/stable/2015-02-28/search.json
require: $(this-folder)/../../../profiles/readme.md
```
