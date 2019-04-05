# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.MachineLearning/stable/2017-01-01/webservices.json
  - $(this-folder)/Microsoft.MachineLearning/preview/2016-05-01-preview/commitmentPlans.json
  - $(this-folder)/Microsoft.MachineLearning/stable/2016-04-01/workspaces.json
  - $(this-folder)/Microsoft.MachineLearning/preview/2016-05-01-preview/webservices.json
require: $(this-folder)/../../../../profiles/readme.md
```
