# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Storage/stable/2018-11-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-11-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2018-07-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-07-01/blob.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/storage.json
  - $(this-folder)/Microsoft.Storage/preview/2018-03-01-preview/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2018-02-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2018-02-01/blob.json
  - $(this-folder)/Microsoft.Storage/stable/2017-10-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2017-06-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-12-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-05-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2016-01-01/storage.json
  - $(this-folder)/Microsoft.Storage/stable/2015-06-15/storage.json
  - $(this-folder)/Microsoft.Storage/preview/2015-05-01-preview/storage.json
require: $(this-folder)/../../../../profiles/readme.md
```
