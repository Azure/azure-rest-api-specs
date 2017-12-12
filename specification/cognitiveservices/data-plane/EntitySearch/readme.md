# Cognitive Services Entity Search SDK

> see https://aka.ms/autorest

Configuration for generating Entity Search SDK.

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
input-file: v1.0/EntitySearch.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  namespace: Microsoft.Azure.CognitiveServices.Search.EntitySearch
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Search/BingEntitySearch/Generated/EntitySearch
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
  namespace: azure.cognitiveservices.search.entitysearch
  package-name: azure-cognitiveservices-search-entitysearch
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-search-entitysearch/azure/cognitiveservices/search/entitysearch
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-search-entitysearch
```