## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-keyvault
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
batch:
- tag: package-2016-10
- tag: package-7.0
- tag: package-7.1
- tag: package-7.2-preview
- multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/keyvault/azure-keyvault/azure/keyvault/
clear-output-folder: false
perform-load: false
```

### Tag: package-7.2-preview

These settings apply only when `--tag=package-7.2-preview` is specified on the command line.

``` yaml $(tag) == 'package-7.2-preview'
namespace: azure.keyvault.v7_2
output-folder: $(python-sdks-folder)/keyvault/azure-keyvault/azure/keyvault/v7_2_preview
```

### Tag: package-7.1

These settings apply only when `--tag=package-7.1` is specified on the command line.

``` yaml $(tag) == 'package-7.1'
namespace: azure.keyvault.v7_1
output-folder: $(python-sdks-folder)/keyvault/azure-keyvault/azure/keyvault/v7_1
```

### Tag: package-7.0

These settings apply only when `--tag=package-7.0` is specified on the command line.

``` yaml $(tag) == 'package-7.0'
  namespace: azure.keyvault.v7_0
  output-folder: $(python-sdks-folder)/keyvault/azure-keyvault/azure/keyvault/v7_0
```

### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
  namespace: azure.keyvault.v2016_10_01
  output-folder: $(python-sdks-folder)/keyvault/azure-keyvault/azure/keyvault/v2016_10_01
```