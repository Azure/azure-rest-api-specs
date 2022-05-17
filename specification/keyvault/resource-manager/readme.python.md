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

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2019-09
  - tag: package-2018-02
  - tag: package-2016-10
  - tag: package-preview-2020-04-full
  - tag: package-preview-2021-04
  - tag: package-preview-2021-06
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/
clear-output-folder: false
perform-load: false
```
### Tag: package-preview-2021-06 and python

These settings apply only when `--tag=package-preview-2021-06 --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-06'
namespace: azure.mgmt.keyvault.v2021_06_01_preview
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2021_06_01_preview
```

### Tag: package-preview-2021-04 and python

These settings apply only when `--tag=package-preview-2021-04 --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-04'
namespace: azure.mgmt.keyvault.v2021_04_01_preview
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2021_04_01_preview
```

### Tag: package-preview-2020-04-full and python

These settings apply only when `--tag=package-preview-2020-04-full --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-04-full'
namespace: azure.mgmt.keyvault.v2020_04_01_preview
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2020_04_01_preview
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.

``` yaml $(tag) == 'package-2019-09'
namespace: azure.mgmt.keyvault.v2019_09_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2019_09_01
```

### Tag: package-2018-02 and python

These settings apply only when `--tag=package-2018-02 --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
namespace: azure.mgmt.keyvault.v2018_02_14
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2018_02_14
```

### Tag: package-2016-10 and python

These settings apply only when `--tag=package-2016-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-2016-10' 
namespace: azure.mgmt.keyvault.v2016_10_01
output-folder: $(python-sdks-folder)/keyvault/azure-mgmt-keyvault/azure/mgmt/keyvault/v2016_10_01
```
