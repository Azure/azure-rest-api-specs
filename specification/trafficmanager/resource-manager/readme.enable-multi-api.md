# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Network/stable/2018-04-01/trafficmanager.json
  - $(this-folder)/Microsoft.Network/stable/2018-03-01/trafficmanager.json
  - $(this-folder)/Microsoft.Network/stable/2018-02-01/trafficmanager.json
  - $(this-folder)/Microsoft.Network/preview/2017-09-01-preview/trafficmanageranalytics.json
  - $(this-folder)/Microsoft.Network/stable/2017-05-01/trafficmanager.json
  - $(this-folder)/Microsoft.Network/stable/2017-03-01/trafficmanager.json
  - $(this-folder)/Microsoft.Network/stable/2015-11-01/trafficmanager.json
require: $(this-folder)/../../../../profiles/readme.md
```
