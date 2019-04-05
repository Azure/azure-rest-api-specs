# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.AzureStack/stable/2017-06-01/AzureStack.json
  - $(this-folder)/Microsoft.AzureStack/stable/2017-06-01/Product.json
  - $(this-folder)/Microsoft.AzureStack/stable/2017-06-01/Registration.json
  - $(this-folder)/Microsoft.AzureStack/stable/2017-06-01/CustomerSubscription.json
require: $(this-folder)/../../../../profiles/readme.md
```
