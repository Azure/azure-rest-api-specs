## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.batch
  package-name: azure-mgmt-batch
  clear-output-folder: true
```

``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.batch
package-name: azure-mgmt-batch
package-version: 14.0.0b1
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/batch/azure-mgmt-batch/azure/mgmt/batch
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/batch/azure-mgmt-batch/azure/mgmt/batch
```

``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/batch/azure-mgmt-batch
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/batch/azure-mgmt-batch
```
