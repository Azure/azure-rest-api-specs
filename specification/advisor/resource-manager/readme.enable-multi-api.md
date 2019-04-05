# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Advisor/stable/2017-04-19/advisor.json
  - $(this-folder)/Microsoft.Advisor/stable/2017-03-31/advisor.json
  - $(this-folder)/Microsoft.Advisor/preview/2016-07-12-preview/advisor.json
require: $(this-folder)/../../../../profiles/readme.md
```
