## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.purview
package-name: azure-mgmt-purview
package-version: 1.0.1
clear-output-folder: true
```
``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/purview/azure-mgmt-purview/azure/mgmt/purview
```


``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
