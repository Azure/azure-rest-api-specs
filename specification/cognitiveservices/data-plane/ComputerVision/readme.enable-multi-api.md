# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - stable/v2.0/ComputerVision.json
  - stable/v2.0/Ocr.json
require: $(this-folder)/../../../../../profiles/readme.md
```
