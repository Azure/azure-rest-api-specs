## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.iothub
package-name: azure-mgmt-iothub
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2023-06-30"
batch:
  - tag: package-2023-06
  - tag: package-preview-2023-06
  - tag: package-preview-2019-07
  - tag: package-2019-03
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/
perform-load: false
```

### Tag: package-2023-06 and python

These settings apply only when `--tag=package-2023-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-06' && $(python)
namespace: azure.mgmt.iothub.v2023_06_30
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2023_06_30
```

### Tag: package-preview-2023-06 and python

These settings apply only when `--tag=package-preview-2023-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-06' && $(python)
namespace: azure.mgmt.iothub.v2023_06_30_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2023_06_30_preview
```

### Tag: package-preview-2019-07 and python

These settings apply only when `--tag=package-preview-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2019-07' && $(python)
namespace: azure.mgmt.iothub.v2019_07_01_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_07_01_preview
```

### Tag: package-2019-03 and python

These settings apply only when `--tag=package-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03' && $(python)
namespace: azure.mgmt.iothub.v2019_03_22
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_03_22
```
