## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.


```yaml $(python)
azure-arm: true 
license-header: MICROSOFT_MIT_NO_VERSION 
package-name: azure-mgmt-automanage
package-version: 0.1.0-preview
clear-output-folder: true 
no-namespace-folders: true 
``` 

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/automanage/azure-mgmt-automanage/azure/mgmt/automanage
```

``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/automanage/azure-mgmt-automanage
```
