# Cognitive Services Face SDK

> see https://aka.ms/autorest

Configuration for generating Face SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: v1.0/Face.json
log-file: logs/log.txt
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.CognitiveServices.Face
  output-folder: out/csharp
```

