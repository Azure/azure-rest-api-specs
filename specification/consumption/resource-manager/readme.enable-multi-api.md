# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Consumption/preview/2018-11-01-preview/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2019-01-01/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2017-11-30/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-01-31/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-03-31/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-05-31/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-06-30/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-08-31/consumption.json
  - $(this-folder)/Microsoft.Consumption/stable/2018-10-01/consumption.json
  - $(this-folder)/Microsoft.Consumption/preview/2017-04-24-preview/consumption.json
  - $(this-folder)/Microsoft.Consumption/preview/2017-12-30-preview/consumption.json
require: $(this-folder)/../../../profiles/readme.md
```
