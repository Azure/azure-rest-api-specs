# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.AlertsManagement/stable/2018-05-05/AlertsManagement.json
  - $(this-folder)/Microsoft.AlertsManagement/preview/2018-05-05-preview/AlertsManagement.json
require: $(this-folder)/../../../../profiles/readme.md
```
