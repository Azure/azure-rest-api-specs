# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.Batch/stable/2019-04-01/BatchManagement.json
  - $(this-folder)/Microsoft.Batch/stable/2018-12-01/BatchManagement.json
  - $(this-folder)/Microsoft.Batch/stable/2017-09-01/BatchManagement.json
  - $(this-folder)/Microsoft.Batch/stable/2017-05-01/BatchManagement.json
  - $(this-folder)/Microsoft.Batch/stable/2017-01-01/BatchManagement.json
  - $(this-folder)/Microsoft.Batch/stable/2015-12-01/BatchManagement.json
require: $(this-folder)/../../../profiles/readme.md
```
