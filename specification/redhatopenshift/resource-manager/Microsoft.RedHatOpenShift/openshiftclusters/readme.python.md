## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-redhatopenshift
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
default-api-version: "2023-11-22"
multiapi: true
batch:
  - tag: package-2023-11
  - tag: package-2020-04-30
  - tag: package-2021-09-01-preview
  - tag: package-2022-04-01
  - tag: package-2022-09-04
  - tag: package-2023-04-01
  - tag: package-2023-09-04
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-04-30 and python

These settings apply only when `--tag=package-2020-04-30 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04-30' && $(python)
namespace: azure.mgmt.redhatopenshift.v2020_04_30
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2020_04_30
```

### Tag: package-2021-09-01-preview and python

These settings apply only when `--tag=package-2021-09-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(python)
namespace: azure.mgmt.redhatopenshift.v2021_09_01_preview
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2021_09_01_preview
```

### Tag: package-2022-04-01 and python

These settings apply only when `--tag=package-2022-04-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(tag) == 'package-2022-04-01' && $(python)
namespace: azure.mgmt.redhatopenshift.v2022_04_01
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2022_04_01
```

### Tag: package-2022-09-04 and python

These settings apply only when `--tag=package-2022-09-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(tag) == 'package-2022-09-04' && $(python)
namespace: azure.mgmt.redhatopenshift.v2022_09_04
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2022_09_04
```

### Tag: package-2023-04-01 and python

These settings apply only when `--tag=package-2023-04-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(tag) == 'package-2023-04-01' && $(python)
namespace: azure.mgmt.redhatopenshift.v2022_09_04
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2023_04_01
```

### Tag: package-2023-09-04 and python

These settings apply only when `--tag=package-2023-09-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(tag) == 'package-2023-09-04' && $(python)
namespace: azure.mgmt.redhatopenshift.v2023_09_04
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2023_09_04
```

### Tag: package-2023-11 and python

These settings apply only when `--tag=package-2023-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


``` yaml $(tag) == 'package-2023-11' && $(python)
namespace: azure.mgmt.redhatopenshift.v2023_11_22
output-folder: $(python-sdks-folder)/redhatopenshift/azure-mgmt-redhatopenshift/azure/mgmt/redhatopenshift/v2023_11_22
```
