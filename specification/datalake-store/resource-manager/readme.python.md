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
  namespace: azure.mgmt.datalake.store
  package-name: azure-mgmt-datalake-store
  clear-output-folder: true
```
``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
namespace: azure.mgmt.datalake.store
package-name: azure-mgmt-datalake-store
package-version: 1.0.0b1
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-store/azure/mgmt/datalake/store
no-namespace-folders: true
output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-store/azure/mgmt/datalake/store
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-store
basic-setup-py: true
output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-store
```
