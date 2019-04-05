# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/preview/2017-11-11-preview/searchservice.json
  - $(this-folder)/preview/2017-11-11/searchservice.json
  - $(this-folder)/preview/2016-09-01-preview/searchservice.json
  - $(this-folder)/preview/2016-09-01/searchservice.json
  - $(this-folder)/preview/2015-02-28-preview/searchservice.json
  - $(this-folder)/preview/2015-02-28/searchservice.json
require: $(this-folder)/../../../../../profiles/readme.md
```
