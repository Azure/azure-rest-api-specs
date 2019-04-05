# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Subscription/preview/2018-11-01-preview/subscriptions.json
  - $(this-folder)/Microsoft.Subscription/stable/2016-06-01/subscriptions.json
  - $(this-folder)/Microsoft.Subscription/preview/2018-03-01-preview/subscriptions.json
  - $(this-folder)/Microsoft.Subscription/preview/2017-11-01-preview/subscriptionDefinitions.json
require: $(this-folder)/../../../../profiles/readme.md
```
