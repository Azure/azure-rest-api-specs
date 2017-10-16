<<<<<<< HEAD
# Cognitive Services Vision SDK

> see https://aka.ms/autorest

Configuration for generating Vision SDK.
=======
# Cognitive Services Face SDK

> see https://aka.ms/autorest

Configuration for generating Face SDK.
>>>>>>> b0bd08e4060ceba449110d7930c5ee78ddba5c17

The current release is `release_1_0`.

``` yaml

tag: release_1_0
<<<<<<< HEAD
openapi-type: data-plane
=======
>>>>>>> b0bd08e4060ceba449110d7930c5ee78ddba5c17
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: v1.0/Face.json
<<<<<<< HEAD
=======
log-file: logs/log.txt
>>>>>>> b0bd08e4060ceba449110d7930c5ee78ddba5c17
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
<<<<<<< HEAD
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Vision.Face
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Vision/Microsoft.CognitiveServices.Vision/Generated/Face
  clear-output-folder: true
=======
  namespace: Microsoft.CognitiveServices.Vision.Face
  output-folder: out/csharp
>>>>>>> b0bd08e4060ceba449110d7930c5ee78ddba5c17
```

