# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.AnalysisServices/stable/2017-08-01/analysisservices.json
  - Microsoft.AnalysisServices/preview/2017-08-01-beta/analysisservices.json
  - Microsoft.AnalysisServices/stable/2017-07-14/analysisservices.json
  - Microsoft.AnalysisServices/stable/2016-05-16/analysisservices.json
require: ../../../../profiles/readme.md
```
