## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
namespace: azure.mgmt.batchai
package-name: azure-mgmt-batchai
package-version: 1.0.0b1
clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/azure-mgmt-batchai/azure/mgmt/batchai
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/azure-mgmt-batchai
```