## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-msi
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(python)
multiapi: true
default-api-version: "2023-01-31"
clear-output-folder: true
batch:
  - tag: package-2023-01-31
  - tag: package-preview-2022-01
  - tag: package-preview-2021-09-30
  - tag: package-2018-11-30
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/resources/azure-mgmt-msi/azure/mgmt/msi/
perform-load: false
```

### Tag: package-2023-01-31 and python

These settings apply only when `--tag=package-2023-01-31 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-01-31'
namespace: azure.mgmt.msi.v2023_01_31
output-folder: $(python-sdks-folder)/resources/azure-mgmt-msi/azure/mgmt/msi/v2023_01_31
```

### Tag: package-preview-2022-01 and python

These settings apply only when `--tag=package-preview-2022-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-01'
namespace: azure.mgmt.msi.v2022_01_31_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-msi/azure/mgmt/msi/v2022_01_31_preview
```

### Tag: package-preview-2021-09-30 and python

These settings apply only when `--tag=package-preview-2021-09-30 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-09-30'
namespace: azure.mgmt.msi.v2021_09_30_preview
output-folder: $(python-sdks-folder)/resources/azure-mgmt-msi/azure/mgmt/msi/v2021_09_30_preview
```

### Tag: package-2018-11-30 and python

These settings apply only when `--tag=package-2018-11-30 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11-30'
namespace: azure.mgmt.msi.v2018_11_30
output-folder: $(python-sdks-folder)/resources/azure-mgmt-msi/azure/mgmt/msi/v2018_11_30
```
