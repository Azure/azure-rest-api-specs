# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.DevTestLab/stable/2018-09-15/DTL.json
  - $(this-folder)/Microsoft.DevTestLab/stable/2016-05-15/DTL.json
  - $(this-folder)/Microsoft.DevTestLab/preview/2015-05-21-preview/DTL.json
require: $(this-folder)/../../../profiles/readme.md
```
