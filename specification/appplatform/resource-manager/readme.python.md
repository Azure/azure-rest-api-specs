## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-appplatform
package-version: 6.1.0
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(python)
multiapi: true
clear-output-folder: true
batch:
  - tag: package-preview-2023-09
  - tag: package-preview-2023-07
  - tag: package-preview-2023-05
  - tag: package-preview-2023-03
  - tag: package-preview-2023-01
  - tag: package-2022-12
  - tag: package-preview-2022-11
  - tag: package-preview-2022-09
  - tag: package-preview-2022-05
  - tag: package-2022-04
  - tag: package-preview-2022-03
  - tag: package-preview-2022-01
  - tag: package-preview-2021-09
  - tag: package-preview-2021-06
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/
perform-load: false
```

### Tag: package-preview-2023-09 and python

These settings apply only when `--tag=package-preview-2023-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-09' && $(python)
namespace: azure.mgmt.appplatform.v2023_09_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2023_09_01_preview
```

### Tag: package-preview-2023-07 and python

These settings apply only when `--tag=package-preview-2023-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-07' && $(python)
namespace: azure.mgmt.appplatform.v2023_07_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2023_07_01_preview
```

### Tag: package-preview-2023-05 and python

These settings apply only when `--tag=package-preview-2023-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-05' && $(python)
namespace: azure.mgmt.appplatform.v2023_05_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2023_05_01_preview
```

### Tag: package-preview-2023-03 and python

These settings apply only when `--tag=package-preview-2023-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-03' && $(python)
namespace: azure.mgmt.appplatform.v2023_03_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2023_03_01_preview
```

### Tag: package-preview-2023-01 and python

These settings apply only when `--tag=package-preview-2023-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-01' && $(python)
namespace: azure.mgmt.appplatform.v2023_01_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2023_01_01_preview
```

### Tag: package-2022-12 and python

These settings apply only when `--tag=package-2022-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-12' && $(python)
namespace: azure.mgmt.appplatform.v2022_12_01
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_12_01
```

### Tag: package-preview-2022-11 and python

These settings apply only when `--tag=package-preview-2022-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-11' && $(python)
namespace: azure.mgmt.appplatform.v2022_11_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_11_01_preview
```

### Tag: package-preview-2022-09 and python

These settings apply only when `--tag=package-preview-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(python)
namespace: azure.mgmt.appplatform.v2022_09_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_09_01_preview
```

### Tag: package-preview-2022-05 and python

These settings apply only when `--tag=package-preview-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(python)
namespace: azure.mgmt.appplatform.v2022_05_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_05_01_preview
```

### Tag: package-2022-04 and python

These settings apply only when `--tag=package-2022-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-04' && $(python)
namespace: azure.mgmt.appplatform.v2022_04_01
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_04_01
```

### Tag: package-preview-2022-03 and python

These settings apply only when `--tag=package-preview-2022-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-03' && $(python)
namespace: azure.mgmt.appplatform.v2022_03_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_03_01_preview
```

### Tag: package-preview-2022-01 and python

These settings apply only when `--tag=package-preview-2022-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-01' && $(python)
namespace: azure.mgmt.appplatform.v2022_01_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2022_01_01_preview
```

### Tag: package-preview-2021-09 and python

These settings apply only when `--tag=package-preview-2021-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-09' && $(python)
namespace: azure.mgmt.appplatform.v2021_09_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2021_09_01_preview
```

### Tag: package-preview-2021-06 and python

These settings apply only when `--tag=package-preview-2021-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-06' && $(python)
namespace: azure.mgmt.appplatform.v2021_06_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2021_06_01_preview
```

### Tag: package-preview-2020-11 and python

These settings apply only when `--tag=package-preview-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2020-11' && $(python)
namespace: azure.mgmt.appplatform.v2020_11_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_11_01_preview
```

### Tag: package-2020-07 and python

These settings apply only when `--tag=package-2020-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07' && $(python)
namespace: azure.mgmt.appplatform.v2020_07_01
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_07_01
```
