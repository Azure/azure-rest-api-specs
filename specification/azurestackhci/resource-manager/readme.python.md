## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.azurestackhci
  package-name: azure-mgmt-azurestackhci
  package-version: 2020-11-01-preview
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-03-01-preview
  - tag: package-2020-11-01-preview
```

### Tag: package-2020-11-01-preview and python

These settings apply only when `--tag=package-2020-11-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview' && $(python)
python:
  namespace: azure.mgmt.azurestackhci.v2020_11_01_preview
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci/azure/mgmt/azurestackhci/v2020_11_01_preview
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11-01-preview' && $(python)
python:
  namespace: azure.mgmt.azurestackhci.v2020_03_01_preview
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci/azure/mgmt/azurestackhci/v2020_03_01_preview
```
