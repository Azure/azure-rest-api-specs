# Cognitive Services Face SDK

> see https://aka.ms/autorest

Configuration for generating Face SDK.

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
input-file: v1.0/Face.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Vision.Face
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Vision/Vision/Generated/Face
  clear-output-folder: true
```

