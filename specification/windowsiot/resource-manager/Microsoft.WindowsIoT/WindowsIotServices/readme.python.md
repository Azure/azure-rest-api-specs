## Python 

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.windowsiot
package-name: azure-mgmt-windowsiot
package-version: 0.1.0
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/windowsiot/azure-mgmt-windowsiot/azure/mgmt/windowsiot
```
