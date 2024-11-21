## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.windowsimagebuilder
package-name: azure-mgmt-windowsimagebuilder
clear-output-folder: true
package-version: 1.0.0b1
```
``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/compute/azure-mgmt-windowsimagebuilder/azure/mgmt/windowsimagebuilder
```
