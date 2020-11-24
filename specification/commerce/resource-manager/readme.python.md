## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.commerce
  package-name: azure-mgmt-commerce
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2015-06-preview
```

### Tag: package-2015-06-preview and python

These settings apply only when `--tag=package-2015-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06-preview' && $(python)
namespace: azure.mgmt.commerce.v2015_06_01_preview
output-folder: $(python-sdks-folder)/commerce/azure-mgmt-commerce/azure/mgmt/commerce/v2015_06_01_preview
python:
  namespace: azure.mgmt.commerce.v2015_06_01_preview
  output-folder: $(python-sdks-folder)/commerce/azure-mgmt-commerce/azure/mgmt/commerce/v2015_06_01_preview
```