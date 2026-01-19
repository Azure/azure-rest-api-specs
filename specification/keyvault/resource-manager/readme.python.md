## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: KeyVaultManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-keyvault
namespace: azure.mgmt.keyvault
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault
```

``` yaml $(python)
modelerfour:
  seal-single-value-enum-by-default: true
directive:
  - from: keyvault.json
    where: $.definitions.Sku.properties.family
    transform: >
        $['default'] = 'A';
```
