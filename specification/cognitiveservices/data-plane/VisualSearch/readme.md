# Bing Visual Search SDK

> see https://aka.ms/autorest

Configuration for generating Visual Search SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
add-credentials: true
openapi-type: data-plane
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: v1.0/VisualSearch.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.Azure.CognitiveServices.Search.VisualSearch
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Search/Search/Generated/VisualSearch
  sync-methods: none
```

## Suppressions
Suppressing errors due to API design:
``` yaml
directive:
  - suppress: R3016
    reason: _type is a polymorphic discriminator that can't be changed.