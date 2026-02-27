## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-hybridkubernetes
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
  - tag: package-2019-11-01-preview
  - tag: package-2019-09-01-privatepreview
```

### Tag: package-2020-01-01-preview and python

These settings apply only when `--tag=package-2020-01-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview' && $(python)
python:
  namespace: azure.mgmt.hybridkubernetes.v2020_01_01_preview
  output-folder: $(python-sdks-folder)/hybridkubernetes/azure-mgmt-hybridkubernetes/azure/mgmt/hybridkubernetes/v2020_01_01_preview
```

### Tag: package-2019-11-01-preview and python

These settings apply only when `--tag=package-2019-11-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11-01-preview' && $(python)
python:
  namespace: azure.mgmt.hybridkubernetes.v2019_11_01_preview
  output-folder: $(python-sdks-folder)/hybridkubernetes/azure-mgmt-hybridkubernetes/azure/mgmt/hybridkubernetes/v2019_11_01_preview
```

### Tag: package-2019-09-01-privatepreview and python

These settings apply only when `--tag=package-2019-09-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09-01-privatepreview' && $(python)
python:
  namespace: azure.mgmt.hybridkubernetes.v2019_09_01_privatepreview
  output-folder: $(python-sdks-folder)/hybridkubernetes/azure-mgmt-hybridkubernetes/azure/mgmt/hybridkubernetes/v2019_09_01_privatepreview
```