## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(tag) == 'release_4_0'
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  payload-flattening-threshold: 2
  namespace: azure.cognitiveservices.knowledge.qnamaker
  package-name: azure-cognitiveservices-knowledge-qnamaker
  clear-output-folder: true
```

``` yaml $(python) && $(tag) == 'runtime_release_4_0'
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  payload-flattening-threshold: 2
  namespace: azure.cognitiveservices.knowledge.qnamaker.runtime
  package-name: azure-cognitiveservices-knowledge-qnamaker
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update' && $(tag) == 'release_4_0'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker
```
``` yaml $(python) && $(python-mode) == 'create' && $(tag) == 'release_4_0'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker
```

``` yaml $(python) && $(python-mode) == 'update' && $(tag) == 'runtime_release_4_0'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/runtime
```
``` yaml $(python) && $(python-mode) == 'create' && $(tag) == 'runtime_release_4_0'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker
```
