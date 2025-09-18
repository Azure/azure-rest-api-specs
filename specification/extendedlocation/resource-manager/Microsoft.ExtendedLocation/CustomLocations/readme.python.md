## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-extendedlocation
namespace: azure.mgmt.extendedlocation
package-version: 2.0.0
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/extendedlocation/azure-mgmt-extendedlocation/azure/mgmt/extendedlocation
```
