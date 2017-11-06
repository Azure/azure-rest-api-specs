# Cognitive Services CustomSearch SDK

> see https://aka.ms/autorest

Configuration for generating CustomSearch SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
openapi-type: data-plane
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: v1.0/CustomSearch.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.Azure.CognitiveServices.Search.CustomSearch
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Search/Search/Generated/CustomSearch
  add-credentials: true
  sync-methods: none
```

