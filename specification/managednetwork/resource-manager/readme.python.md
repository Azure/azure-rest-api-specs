## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-network
  clear-output-folder: true
  no-namespace-folders: true
```

### Tag: package-2019-06-01-preview and python

These settings apply only when `--tag=package-2019-06-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-01-preview' && $(python)
python:
  namespace: azure.mgmt.managednetwork.v2019_06_01_preview
  output-folder: $(python-sdks-folder)/managednetwork/azure-mgmt-managednetwork/azure/mgmt/managednetwork
```
