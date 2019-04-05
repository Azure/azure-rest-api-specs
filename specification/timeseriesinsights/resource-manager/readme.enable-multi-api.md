# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.TimeSeriesInsights/preview/2017-02-28-preview/timeseriesinsights.json
  - $(this-folder)/Microsoft.TimeSeriesInsights/stable/2017-11-15/timeseriesinsights.json
  - $(this-folder)/Microsoft.TimeSeriesInsights/preview/2018-08-15-preview/timeseriesinsights.json
require: $(this-folder)/../../../../profiles/readme.md
```
