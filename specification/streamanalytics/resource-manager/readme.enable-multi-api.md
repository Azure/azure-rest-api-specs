# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/streamingjobs.json
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/inputs.json
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/outputs.json
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/transformations.json
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/functions.json
  - $(this-folder)/Microsoft.StreamAnalytics/stable/2016-03-01/subscriptions.json
require: $(this-folder)/../../../../profiles/readme.md
```
