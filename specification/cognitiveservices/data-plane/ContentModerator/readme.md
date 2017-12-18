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
  - v1.0/ContentModerator.json
```

## Validation

``` yaml
add-credentials: true
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
## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  payload-flattening-threshold: 2
  namespace: azure.cognitiveservices.vision.contentmoderator
  package-name: azure-cognitiveservices-vision-contentmoderator
  clear-output-folder: true
  title: "Content Moderator API"
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-vision-contentmoderator/azure/cognitiveservices/vision/contentmoderator
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-vision-contentmoderator
```
