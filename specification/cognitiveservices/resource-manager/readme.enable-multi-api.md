# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.CognitiveServices/stable/2017-04-18/cognitiveservices.json
  - $(this-folder)/Microsoft.CognitiveServices/preview/2016-02-01-preview/cognitiveservices.json
require: $(this-folder)/../../../../profiles/readme.md
```
