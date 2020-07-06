## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 0
  namespace: azure.mgmt.databoxedge
  package-name: azure-mgmt-databoxedge
  title: DataBoxEdgeManagementClient
  description: The DataBoxEdge Client.
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03
```

### Tag: package-2020-05-preview and python

These settings apply only when `--tag=package-2020-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05-preview' && $(python)
python:
  namespace: azure.mgmt.databoxedge.v2020_05_01_preview
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_05_01_preview
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08' && $(python)
python:
  namespace: azure.mgmt.databoxedge.v2019_08_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_08_01
```

### Tag: package-2019-07 and python

These settings apply only when `--tag=package-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07' && $(python)
python:
  namespace: azure.mgmt.databoxedge.v2019_07_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_07_01
```

### Tag: package-2019-03 and python

These settings apply only when `--tag=package-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03' && $(python)
python:
  namespace: azure.mgmt.databoxedge.v2019_03_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_03_01
```
