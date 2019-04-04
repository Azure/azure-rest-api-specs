# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.DBforMariaDB/preview/2018-06-01-preview/mariadb.json
  - Microsoft.DBforMariaDB/stable/2018-06-01/mariadb.json
require: $(this-folder)/../../../../profiles/readme.md
```
