## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: Private.EdgeInternal
  package-name: azure-mgmt-exposurecontrol
  package-version: 2024-01-01-preview
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2024-01-01-privatepreview
```

### Tag: package-2024-01-01-preview and python

These settings apply only when `--tag=package-2024-01-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2024-01-01-preview' && $(python)
python:
  namespace: azure.mgmt.exposurecontrol.v2024_01_01_privatepreview
  output-folder: $(python-sdks-folder)/exposurecontrol/azure-mgmt-exposurecontrol/azure/mgmt/exposurecontrol/v2024_01_01_privatepreview
```
