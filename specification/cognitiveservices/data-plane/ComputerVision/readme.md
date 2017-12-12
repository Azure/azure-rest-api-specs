# Cognitive Services Computer Vision SDK

> see https://aka.ms/autorest

Configuration for generating Computer Vision SDK.

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
input-file: v1.0/ComputerVision.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Vision.ComputerVision
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Vision/Vision/Generated/ComputerVision
  clear-output-folder: true
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
  namespace: azure.cognitiveservices.vision.computervision
  package-name: azure-cognitiveservices-vision-computervision
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-vision-computervision/azure/cognitiveservices/vision/computervision
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-vision-computervision
```