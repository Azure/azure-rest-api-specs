## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.azurestackhci
  package-name: azure-mgmt-azurestackhci
  package-version: 1.0.0rc1
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci/azure/mgmt/azurestackhci
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci
```
