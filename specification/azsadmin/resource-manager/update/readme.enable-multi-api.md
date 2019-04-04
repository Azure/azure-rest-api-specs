# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Update.Admin/preview/2016-05-01/Update.json
  - Microsoft.Update.Admin/preview/2016-05-01/Updates.json
  - Microsoft.Update.Admin/preview/2016-05-01/UpdateLocations.json
  - Microsoft.Update.Admin/preview/2016-05-01/UpdateRuns.json
require: $(this-folder)/../../../../../profiles/readme.md
```
