# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.StreamAnalytics/stable/2016-03-01/streamingjobs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/inputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/outputs.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/transformations.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/functions.json
  - Microsoft.StreamAnalytics/stable/2016-03-01/subscriptions.json
require: ../../../../profiles/readme.md
```
