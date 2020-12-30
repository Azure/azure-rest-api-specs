## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: Microsoft.VMware
  package-name: vmware
  package-version: 2020-10-01-preview
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-12-20-privatepreview
  - tag: package-2020-10-01-preview
```

### Tag: package-2020-10-01-preview and python

These settings apply only when `--tag=package-2020-10-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10-01-preview' && $(python)
python:
  namespace: azure.mgmt.vmware.v2020-10-01-preview
  output-folder: $(python-sdks-folder)/vmware/azure-mgmt-vmware/azure/mgmt/vmware/v2020-10-01-preview
```

### Tag: package-2019-12-20-privatepreview and python

These settings apply only when `--tag=package-2019-12-20-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12-20-privatepreview' && $(python)
python:
  namespace: azure.mgmt.vmware.v2019_12_20_privatepreview
  output-folder: $(python-sdks-folder)/vmware/azure-mgmt-vmware/azure/mgmt/vmware/v2019_12_20_privatepreview
```

