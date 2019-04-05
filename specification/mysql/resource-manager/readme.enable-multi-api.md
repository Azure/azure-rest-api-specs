# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DBforMySQL/preview/2017-12-01-preview/mysql.json
  - $(this-folder)/Microsoft.DBforMySQL/stable/2017-12-01/mysql.json
require: $(this-folder)/../../../../profiles/readme.md
```
