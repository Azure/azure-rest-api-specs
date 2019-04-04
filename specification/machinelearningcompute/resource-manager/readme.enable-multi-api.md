# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.MachineLearningCompute/preview/2017-08-01-preview/machineLearningCompute.json
  - Microsoft.MachineLearningCompute/preview/2017-06-01-preview/machineLearningCompute.json
require: $(this-folder)/../../../../profiles/readme.md
```
