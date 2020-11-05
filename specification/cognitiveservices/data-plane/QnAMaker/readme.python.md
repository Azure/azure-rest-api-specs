## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
license-header: MICROSOFT_MIT_NO_VERSION
add-credentials: true
payload-flattening-threshold: 2
package-name: azure-cognitiveservices-knowledge-qnamaker
no-namespace-folders: true
clear-output-folder: true
```
### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: release_5_0_preview.1
  - tag: release_4_0
  - tag: runtime_release_4_0
```
### Tag: release_4_0 and python

These settings apply only when `--tag=release_4_0 --python` is specified on the command line.


``` yaml $(tag) == 'release_4_0' && $(python)
python:
  namespace: azure.cognitiveservices.knowledge.qnamaker.authoring
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/authoring
```
### Tag: runtime_release_4_0 and python

These settings apply only when `--tag=runtime_release_4_0 --python` is specified on the command line.

``` yaml $(tag) == 'runtime_release_4_0' && $(python)
python:
  namespace: azure.cognitiveservices.knowledge.qnamaker.runtime
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/runtime
```
### Tag: release_5_0_preview.1 and python

These settings apply only when `--tag=release_5_0_preview.1 --python` is specified on the command line.

``` yaml $(tag) == 'release_5_0_preview.1' && $(python)
python:
  namespace: azure.cognitiveservices.knowledge.qnamaker.v5_0
  output-folder: $(python-sdks-folder)/cognitiveservices/azure-cognitiveservices-knowledge-qnamaker/azure/cognitiveservices/knowledge/qnamaker/v5_0_preview
```
