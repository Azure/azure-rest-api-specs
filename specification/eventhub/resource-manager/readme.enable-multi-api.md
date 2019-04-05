# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.EventHub/stable/2017-04-01/EventHub.json
  - $(this-folder)/Microsoft.EventHub/stable/2015-08-01/EventHub.json
  - $(this-folder)/Microsoft.EventHub/stable/2014-09-01/EventHub.json
  - $(this-folder)/Microsoft.EventHub/preview/2018-01-01-preview/EventHub-preview.json
require: $(this-folder)/../../../../profiles/readme.md
```
