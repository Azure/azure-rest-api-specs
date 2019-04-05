# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Scheduler/stable/2016-03-01/scheduler.json
  - $(this-folder)/Microsoft.Scheduler/stable/2016-01-01/scheduler.json
  - $(this-folder)/Microsoft.Scheduler/preview/2014-08-01-preview/scheduler.json
require: $(this-folder)/../../../../profiles/readme.md
```
