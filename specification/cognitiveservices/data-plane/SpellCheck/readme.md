# Cognitive Services Spell Check SDK

> see https://aka.ms/autorest

Configuration for generating Spell Check SDK.

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
input-file: V1.0/SpellCheck.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.Azure.CognitiveServices.SpellCheck
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/SpellCheck/Generated/
  sync-methods: none
```

