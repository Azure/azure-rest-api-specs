## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resourcehealth
namespace: azure.mgmt.resourcehealth
package-version: 1.0.0
clear-output-folder: true
title: ResourceHealthMgmtClient
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/resourcehealth/azure-mgmt-resourcehealth/azure/mgmt/resourcehealth
```

``` yaml $(python)
flatten-models: false
```
