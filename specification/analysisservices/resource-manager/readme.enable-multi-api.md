# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.AnalysisServices/stable/2017-08-01/analysisservices.json
  - $(this-folder)/Microsoft.AnalysisServices/preview/2017-08-01-beta/analysisservices.json
  - $(this-folder)/Microsoft.AnalysisServices/stable/2017-07-14/analysisservices.json
  - $(this-folder)/Microsoft.AnalysisServices/stable/2016-05-16/analysisservices.json
require: $(this-folder)/../../../../profiles/readme.md
```
