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
  package-name: azure-cognitiveservices-knowledge-qnamaker
  clear-output-folder: true
```

``` yaml $(python) && $(tag) == 'release_4_0' && $(python-mode) == 'update'
python:
  basic-setup-py: true
  no-namespace-folders: true
  namespace: azure.cognitiveservices.knowledge.qnamaker.authoring
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/authoring
```

``` yaml $(python) && $(tag) == 'runtime_release_4_0' && $(python-mode) == 'update'
python:
  basic-setup-py: true
  no-namespace-folders: true
  namespace: azure.cognitiveservices.knowledge.qnamaker.runtime
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/runtime
```

``` yaml $(python) && $(tag) == 'release_4_0' && $(python-mode) == 'create'
python:
  basic-setup-py: true
  namespace: azure.cognitiveservices.knowledge.qnamaker.authoring
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/authoring
```

``` yaml $(python) && $(tag) == 'runtime_release_4_0' && $(python-mode) == 'create'
python:
  basic-setup-py: true
  namespace: azure.cognitiveservices.knowledge.qnamaker.runtime
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/runtime
```
