# Cognitive Services Custom Decision Service SDK

> see https://aka.ms/autorest

Configuration for generating Custom Decision Service SDK.

The current release is `release_2_0`.

``` yaml

tag: release_2_0
add-credentials: true
openapi-type: data-plane
```
# Releases

### Release 2.0
These settings apply only when `--tag=release_2_0` is specified on the command line.

``` yaml $(tag) == 'release_2_0'
input-file: v2.0/CustomDecisionService.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.CustomDecisionService
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/CustomDecisionService/Generated
  clear-output-folder: true
```

