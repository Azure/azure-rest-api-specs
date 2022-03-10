## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.managednetworkfabric
  package-name: azure-mgmt-managednetworkfabric
  package-version: 2022-01-15-privatepreview
  clear-output-folder: true
```

```yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
output-folder: $(python-sdks-folder)/managednetworkfabric/azure-mgmt-managednetworkfabric/azure/mgmt/managednetworkfabric
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/managednetworkfabric/azure-mgmt-managednetworkfabric
```
