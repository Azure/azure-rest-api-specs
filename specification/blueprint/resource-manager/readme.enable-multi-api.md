# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2017-11-11-preview/blueprintAssignment.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintDefinition.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/blueprintAssignment.json
  - Microsoft.Blueprint/preview/2018-11-01-preview/assignmentOperation.json
require: $(this-folder)/../../../../profiles/readme.md
```
