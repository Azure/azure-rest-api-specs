# Cognitive Services Text Analytics SDK

> see https://aka.ms/autorest

Configuration for generating Text Analytics SDK.

The current release is `release_2_0`.

``` yaml

tag: release_2_0
```
# Releases

### Release 2.0
These settings apply only when `--tag=release_2_0` is specified on the command line.

``` yaml $(tag) == 'release_2_0'
input-file: v2.0/TextAnalytics.json
log-file: logs/log.txt
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.CognitiveServices.Language.TextAnalytics
  output-folder: out/csharp
```

