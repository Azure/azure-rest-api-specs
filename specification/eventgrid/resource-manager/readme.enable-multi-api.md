# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.EventGrid/preview/2019-02-01-preview/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/stable/2019-01-01/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/preview/2018-09-15-preview/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/preview/2018-05-01-preview/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/preview/2017-09-15-preview/EventGrid.json
  - $(this-folder)/Microsoft.EventGrid/preview/2017-06-15-preview/EventGrid.json
require: $(this-folder)/../../../profiles/readme.md
```
