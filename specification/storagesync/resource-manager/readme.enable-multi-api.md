# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.StorageSync/stable/2019-02-01/storagesync.json
  - $(this-folder)/Microsoft.StorageSync/stable/2018-10-01/storagesync.json
  - $(this-folder)/Microsoft.StorageSync/stable/2018-07-01/storagesync.json
  - $(this-folder)/Microsoft.StorageSync/stable/2018-04-02/storagesync.json
  - $(this-folder)/Microsoft.StorageSync/preview/2017-06-05-preview/storagesync.json
require: $(this-folder)/../../../profiles/readme.md
```
