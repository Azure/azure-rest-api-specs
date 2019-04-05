# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Subscriptions/preview/2015-11-01/Subscriptions.json
  - $(this-folder)/Microsoft.Subscriptions/preview/2015-11-01/Offer.json
require: $(this-folder)/../../../../../profiles/readme.md
```
