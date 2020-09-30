## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.falcon.v2020_09_02_preview
  package-name: azure-mgmt-falcon
  package-version: 2020-09-02-preview
  clear-output-folder: true
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/falcon/azure-mgmt-falcon/azure/mgmt/falcon/v2020_09_02_preview
```

### Tag: package-2020-01-20-preview and python

These settings apply only when `--tag=package-2020-01-20-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-20-preview' && $(python)
python:
  namespace: azure.mgmt.falcon.v2020_01_20_preview
  package-version: 2020-01-20-preview
  output-folder: $(python-sdks-folder)/falcon/azure-mgmt-falcon/azure/mgmt/falcon/v2020_01_20_preview
```