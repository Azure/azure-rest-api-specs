# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.Cache/stable/2018-03-01/redis.json
  - $(this-folder)/Microsoft.Cache/stable/2017-10-01/redis.json
  - $(this-folder)/Microsoft.Cache/stable/2017-02-01/redis.json
  - $(this-folder)/Microsoft.Cache/stable/2016-04-01/redis.json
  - $(this-folder)/Microsoft.Cache/stable/2015-08-01/redis.json
require: $(this-folder)/../../../profiles/readme.md
```
