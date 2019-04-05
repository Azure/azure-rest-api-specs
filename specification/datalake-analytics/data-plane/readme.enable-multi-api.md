# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DataLakeAnalytics/stable/2016-11-01/catalog.json
  - $(this-folder)/Microsoft.DataLakeAnalytics/preview/2015-10-01-preview/catalog.json
  - $(this-folder)/Microsoft.DataLakeAnalytics/preview/2017-09-01-preview/job.json
  - $(this-folder)/Microsoft.DataLakeAnalytics/stable/2016-11-01/job.json
  - $(this-folder)/Microsoft.DataLakeAnalytics/preview/2016-03-20-preview/job.json
  - $(this-folder)/Microsoft.DataLakeAnalytics/preview/2015-11-01-preview/job.json
require: $(this-folder)/../../../../profiles/readme.md
```
