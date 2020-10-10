## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.digitaltwins
  package-name: azure-mgmt-digitaltwins
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-10
  - tag: package-2020-03-01-preview
```

### Tag: package-2020-10 and python

These settings apply only when `--tag=package-2020-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10' && $(python)
python:
  namespace: azure.mgmt.digitaltwins.v2020_10_31
  output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2020_10_31
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(python)
python:
  namespace: azure.mgmt.digitaltwins.v2020_03_01_preview
  output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2020_03_01_preview
```