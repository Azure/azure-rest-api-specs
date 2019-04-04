# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Capacity/preview/2018-06-01/reservations.json
  - Microsoft.Capacity/stable/2017-11-01/reservations.json
require: $(this-folder)/../../../../profiles/readme.md
```
