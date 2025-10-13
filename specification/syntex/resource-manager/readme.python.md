## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-syntex
no-namespace-folders: true
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml
no-namespace-folders: true
output-folder: $(python-sdks-folder)/syntex/azure-mgmt-syntex/azure/mgmt/syntex
```
