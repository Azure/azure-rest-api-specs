## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python) && $(track2)
azure-arm: true 
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resourcemover
clear-output-folder: true
no-namespace-folders: true
package-version: 1.0.0b1
```

```yaml $(python) && $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/resourcemover/azure-mgmt-resourcemover/azure/mgmt/resourcemover
```

``` yaml $(python) && $(python-mode) == 'create' && $(track2)
basic-setup-py: true 
output-folder: $(python-sdks-folder)/resourcemover/azure-mgmt-resourcemover
```
