# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Storage/stable/2018-01-01/Storage.json
  - $(this-folder)/Microsoft.EventHub/stable/2018-01-01/EventHub.json
  - $(this-folder)/Microsoft.Resources/stable/2018-01-01/Resources.json
  - $(this-folder)/Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
  - $(this-folder)/Microsoft.Devices/stable/2018-01-01/IotHub.json
  - $(this-folder)/Microsoft.ContainerRegistry/stable/2018-01-01/ContainerRegistry.json
  - $(this-folder)/Microsoft.ServiceBus/stable/2018-01-01/ServiceBus.json
  - $(this-folder)/Microsoft.Media/stable/2018-01-01/MediaServices.json
  - $(this-folder)/Microsoft.Maps/stable/2018-01-01/Maps.json
  - $(this-folder)/Microsoft.AppConfiguration/stable/2018-01-01/AppConfiguration.json
require: $(this-folder)/../../../../profiles/readme.md
```
