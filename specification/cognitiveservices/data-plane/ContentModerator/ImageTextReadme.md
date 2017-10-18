# Cognitive Services Content Moderator SDK

> see https://aka.ms/autorest

Configuration for generating Content Moderator SDK.

The current release is `release_1_0`.

``` yaml

tag: release_1_0
```
# Releases

### Release 1.0
These settings apply only when `--tag=release_1_0` is specified on the command line.

``` yaml $(tag) == 'release_1_0'
input-file: 
  - v1.0/contentmoderatorImageText.json
```

## Validation

``` yaml
openapi-type: data-plane
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.CognitiveServices.ContentModerator
  output-folder: out/csharp
```

``` yaml
directive:
  - suppress: R2022                        # the message to suppress
```