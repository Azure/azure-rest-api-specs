# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Relay/stable/2017-04-01/relay.json
  - $(this-folder)/Microsoft.Relay/stable/2016-07-01/relay.json
require: $(this-folder)/../../../../profiles/readme.md
```
