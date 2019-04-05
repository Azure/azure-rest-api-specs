# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/stable/v2.0/TextAnalytics.json
  - $(this-folder)/stable/v2.1/TextAnalytics.json
  - $(this-folder)/preview/v2.1/TextAnalytics.json
require: $(this-folder)/../../../../../profiles/readme.md
```
