# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/Microsoft.ResourceGraph/stable/2019-04-01/resourcegraph.json
  - $(this-folder)/Microsoft.ResourceGraph/preview/2018-09-01-preview/resourcegraph.json
  - $(this-folder)/Microsoft.ResourceGraph/preview/2018-09-01-preview/graphquery.json
require: $(this-folder)/../../../profiles/readme.md
```
