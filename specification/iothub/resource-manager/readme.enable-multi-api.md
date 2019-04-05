# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Devices/preview/2018-12-01-preview/iothub.json
  - $(this-folder)/Microsoft.Devices/stable/2018-04-01/iothub.json
  - $(this-folder)/Microsoft.Devices/stable/2018-01-22/iothub.json
  - $(this-folder)/Microsoft.Devices/stable/2017-07-01/iothub.json
  - $(this-folder)/Microsoft.Devices/stable/2017-01-19/iothub.json
  - $(this-folder)/Microsoft.Devices/stable/2016-02-03/iothub.json
require: $(this-folder)/../../../../profiles/readme.md
```
