## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.edgemarketplace
  package-name: azure-mgmt-edgemarketplace
  package-version: 2023-04-01-preview
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2023-04-01-preview
```

### Tag: package-2023-04-01-preview and python

These settings apply only when `--tag=package-2023-04-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-04-01-preview' && $(python)
python:
  namespace: azure.mgmt.edgemarketplace.v2023_04_01_preview
  output-folder: $(python-sdks-folder)/edgemarketplace/azure-mgmt-edgemarketplace/azure/mgmt/edgemarketplace/v2023_04_01_preview
```