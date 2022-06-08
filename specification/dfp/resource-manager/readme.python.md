## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-dfp
namespace: azure.mgmt.dfp
package-version: 1.0.0b1
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/dfp/azure-mgmt-dfp/azure/mgmt/dfp
```