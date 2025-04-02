## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.keyvault
package-name: azure-mgmt-keyvault
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2024-11-01"
clear-output-folder: true
batch:
  - tag: package-2024-11-01
  - tag: package-2023-02
  - tag: package-2016-10
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/
perform-load: false
```

### Tag: package-2024-11-01 and python

These settings apply only when `--tag=package-2024-11-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2024-11-01'
namespace: azure.mgmt.keyvault.v2024_11_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2024_11_01
```

### Tag: package-2023-02 and python

These settings apply only when `--tag=package-2023-02 --python` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
namespace: azure.mgmt.keyvault.v2023_02_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2023_02_01
```

### Tag: package-2016-10 and python

These settings apply only when `--tag=package-2016-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
namespace: azure.mgmt.keyvault.v2016_10_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2016_10_01
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
