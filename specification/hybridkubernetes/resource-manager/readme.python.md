## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python)
python:
  python-mode: create
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.hybridkubernetes
  package-name: azure-mgmt-hybridkubernetes
  package-version: 0.1.1
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/hybridkubernetes/azure-mgmt-hybridkubernetes/azure/mgmt/hybridkubernetes
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/hybridkubernetes/azure-mgmt-hybridkubernetes
```