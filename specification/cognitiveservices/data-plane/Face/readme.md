# Cognitive Services Vision SDK

> see https://aka.ms/autorest

Configuration for generating Vision SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
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
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Vision.Face
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Vision/Microsoft.CognitiveServices.Vision/Generated/Face
  clear-output-folder: true
```

