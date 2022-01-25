## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-apimanagement
no-namespace-folders: true
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/apimanagement/azure-mgmt-apimanagement/azure/mgmt/apimanagement
```

``` yaml $(python-mode) == 'create' && $(track2)
basic-setup-py: true
output-folder: $(python-sdks-folder)/apimanagement/azure-mgmt-apimanagement
```
