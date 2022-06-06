## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-azurestackhci
package-version: 1.0.0b1
no-namespace-folders: true
modelerfour: 
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
multiapi: true
batch:
  - tag: package-2020-03-01-preview
  - tag: package-2020-11-01-preview
```

### Tag: package-2020-11-01-preview and python

These settings apply only when `--tag=package-2020-11-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11-01-preview' && $(python)
python:
  namespace: azure.mgmt.azurestackhci.v2020_11_01_preview
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci/azure/mgmt/azurestackhci/v2020_11_01_preview
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(python)
python:
  namespace: azure.mgmt.azurestackhci.v2020_03_01_preview
  output-folder: $(python-sdks-folder)/azurestackhci/azure-mgmt-azurestackhci/azure/mgmt/azurestackhci/v2020_03_01_preview
```
