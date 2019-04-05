# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.BatchAI/preview/2017-09-01-preview/BatchAI.json
  - $(this-folder)/Microsoft.BatchAI/stable/2018-03-01/BatchAI.json
  - $(this-folder)/Microsoft.BatchAI/stable/2018-05-01/BatchAI.json
require: $(this-folder)/../../../../profiles/readme.md
```
