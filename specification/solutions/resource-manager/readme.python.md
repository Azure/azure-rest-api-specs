## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-managedapplication
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(python)
clear-output-folder: true
batch:
  - tag: package-managedapplications-2021-07
  - tag: package-managedapplications-2021-02
  - tag: package-managedapplications-2020-08
  - tag: package-managedapplications-2019-07
  - tag: package-managedapplications-2018-09
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2018-03
  - tag: package-managedapplications-2018-02
  - tag: package-managedapplications-2017-12
  - tag: package-managedapplications-2017-09
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/
perform-load: false
```

### Tag: package-managedapplications-2021-07 and python

These settings apply only when `--tag=package-managedapplications-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07'
namespace: azure.mgmt.managedapplication.v2021_07_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2021_07_01
```

### Tag: package-managedapplications-2021-02 and python

These settings apply only when `--tag=package-managedapplications-2021-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-02'
namespace: azure.mgmt.managedapplication.v2021_02_01_preview
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2021_02_01_preview
```

### Tag: package-managedapplications-2020-08 and python

These settings apply only when `--tag=package-managedapplications-2020-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2020-08'
namespace: azure.mgmt.managedapplication.v2020_08_21_preview
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2020_08_21_preview
```

### Tag: package-managedapplications-2019-07 and python

These settings apply only when `--tag=package-managedapplications-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07'
namespace: azure.mgmt.managedapplication.v2019_07_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2019_07_01
```

### Tag: package-managedapplications-2018-09 and python

These settings apply only when `--tag=package-managedapplications-2018-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-09'
namespace: azure.mgmt.managedapplication.v2018_09_01_preview
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2018_09_01_preview
```

### Tag: package-managedapplications-2018-06 and python

These settings apply only when `--tag=package-managedapplications-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06'
namespace: azure.mgmt.managedapplication.v2018_06_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2018_06_01
```

### Tag: package-managedapplications-2018-03 and python

These settings apply only when `--tag=package-managedapplications-2018-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-03'
namespace: azure.mgmt.managedapplication.v2018_03_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2018_03_01
```

### Tag: package-managedapplications-2018-02 and python

These settings apply only when `--tag=package-managedapplications-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-02'
namespace: azure.mgmt.managedapplication.v2018_02_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2018_02_01
```

### Tag: package-managedapplications-2017-12 and python

These settings apply only when `--tag=package-managedapplications-2017-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-12'
namespace: azure.mgmt.managedapplication.v2017_12_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2017_12_01
```

### Tag: package-managedapplications-2017-09 and python

These settings apply only when `--tag=package-managedapplications-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09'
namespace: azure.mgmt.managedapplication.v2017_09_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2017_09_01
```
