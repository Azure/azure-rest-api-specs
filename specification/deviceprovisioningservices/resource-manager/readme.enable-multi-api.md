# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Devices/preview/2017-08-21-preview/iotdps.json
  - $(this-folder)/Microsoft.Devices/stable/2017-11-15/iotdps.json
  - $(this-folder)/Microsoft.Devices/stable/2018-01-22/iotdps.json
require: $(this-folder)/../../../../profiles/readme.md
```
