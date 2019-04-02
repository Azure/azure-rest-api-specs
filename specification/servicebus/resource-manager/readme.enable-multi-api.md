# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.ServiceBus/preview/2018-01-01-preview/servicebus-preview.json
  - Microsoft.ServiceBus/stable/2017-04-01/servicebus.json
  - Microsoft.ServiceBus/stable/2015-08-01/servicebus.json
require: ../../../../profiles/readme.md
```
