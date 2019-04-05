# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/stable/v2.0/Training.json
  - $(this-folder)/stable/v2.1/Training.json
  - $(this-folder)/stable/v2.2/Training.json
  - $(this-folder)/stable/v3.0/Training.json
require: $(this-folder)/../../../../../../profiles/readme.md
```
