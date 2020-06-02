## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azure.mgmt.datacollaboration
  package-name: azure-mgmt-datacollaboration
  package-version: 2020-05-04-preview
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/datacollaboration/azure-mgmt-datacollaboration/azure/mgmt/datacollaboration
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/datacollaboration/azure-mgmt-datacollaboration
```