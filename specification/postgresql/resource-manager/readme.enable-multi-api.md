# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DBforPostgreSQL/preview/2017-12-01-preview/postgresql.json
  - $(this-folder)/Microsoft.DBforPostgreSQL/stable/2017-12-01/postgresql.json
require: $(this-folder)/../../../../profiles/readme.md
```
