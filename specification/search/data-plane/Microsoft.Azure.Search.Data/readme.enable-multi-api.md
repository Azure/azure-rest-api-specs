# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:
  - $(this-folder)/stable/2019-05-06/searchindex.json
  - $(this-folder)/preview/2017-11-11-preview/searchindex.json
  - $(this-folder)/preview/2017-11-11/searchindex.json
  - $(this-folder)/preview/2016-09-01-preview/searchindex.json
  - $(this-folder)/preview/2016-09-01/searchindex.json
  - $(this-folder)/preview/2015-02-28-preview/searchindex.json
  - $(this-folder)/preview/2015-02-28/searchindex.json
require: $(this-folder)/../../../../profiles/readme.md
```
