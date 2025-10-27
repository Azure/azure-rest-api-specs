## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
title: ManagedLabsClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.labservices
package-name: azure-mgmt-labservices
package-version: 1.0.0
clear-output-folder: true
```

``` yaml $(python) 
no-namespace-folders: true
output-folder: $(python-sdks-folder)/labservices/azure-mgmt-labservices/azure/mgmt/labservices
```
