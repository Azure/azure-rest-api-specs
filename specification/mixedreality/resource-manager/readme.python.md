## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: update
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.mixedreality
package-name: azure-mgmt-mixedreality
package-version: 0.0.1
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/mixedreality/azure-mgmt-mixedreality/azure/mgmt/mixedreality
```

``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/mixedreality/azure-mgmt-mixedreality
```