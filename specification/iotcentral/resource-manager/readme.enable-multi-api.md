# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.IoTCentral/stable/2018-09-01/iotcentral.json
  - $(this-folder)/Microsoft.IoTCentral/preview/2017-07-01-privatepreview/iotcentral.json
require: $(this-folder)/../../../../profiles/readme.md
```
