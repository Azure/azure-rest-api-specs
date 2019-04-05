# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ServiceBus/preview/2018-01-01-preview/servicebus-preview.json
  - $(this-folder)/Microsoft.ServiceBus/stable/2017-04-01/servicebus.json
  - $(this-folder)/Microsoft.ServiceBus/stable/2015-08-01/servicebus.json
require: $(this-folder)/../../../../profiles/readme.md
```
