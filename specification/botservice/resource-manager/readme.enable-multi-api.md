# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.BotService/preview/2018-07-12/botservice.json
  - $(this-folder)/Microsoft.BotService/preview/2017-12-01/botservice.json
require: $(this-folder)/../../../../profiles/readme.md
```
