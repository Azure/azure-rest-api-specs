## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-azuredatatransfer
no-namespace-folders: true
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/azuredatatransfer/azure-mgmt-azuredatatransfer/azure/mgmt/azuredatatransfer
```

``` yaml $(python-mode) == 'create' && $(python)
basic-setup-py: true
output-folder: $(python-sdks-folder)/azuredatatransfer/azure-mgmt-azuredatatransfer
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
