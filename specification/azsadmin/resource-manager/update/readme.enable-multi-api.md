# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.Update.Admin/preview/2016-05-01/Update.json
  - $(this-folder)/Microsoft.Update.Admin/preview/2016-05-01/Updates.json
  - $(this-folder)/Microsoft.Update.Admin/preview/2016-05-01/UpdateLocations.json
  - $(this-folder)/Microsoft.Update.Admin/preview/2016-05-01/UpdateRuns.json
require: $(this-folder)/../../../../profiles/readme.md
```
