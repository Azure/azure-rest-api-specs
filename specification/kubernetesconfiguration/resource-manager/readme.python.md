## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python) && !$(track2)
python:
  python-mode: create
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.kubernetesconfiguration
  package-name: azure-mgmt-kubernetesconfiguration
  package-version: 0.1.1
  clear-output-folder: true
```
```yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.kubernetesconfiguration
package-name: azure-mgmt-kubernetesconfiguration
package-version: 0.1.1
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update' && !$(track2)
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration
```
``` yaml $(python) && $(python-mode) == 'create' && !$(track2)
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration
```
``` yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration
```
``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration
```


```yaml $(python) && $(track2)
directive:
  - from: kubernetesconfiguration.json
    where: $.definitions.EnableHelmOperatorDefinition
    transform: >
      return {
        "description": "Option to enable Helm Operator for this git configuration.",
        "type": "string",
        "enum": [
          "true",
          "false"
        ],
        "x-ms-enum": {
          "name": "EnableHelmOperatorType",
          "modelAsString": true
        }
      }
```