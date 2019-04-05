# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Billing/preview/2018-11-01-preview/billing.json
  - $(this-folder)/Microsoft.Billing/preview/2018-03-01-preview/billing.json
  - $(this-folder)/Microsoft.Billing/preview/2017-04-24-preview/billing.json
  - $(this-folder)/Microsoft.Billing/preview/2017-02-27-preview/billing.json
require: $(this-folder)/../../../../profiles/readme.md
```
