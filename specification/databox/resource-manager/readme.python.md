## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.databox
package-name: azure-mgmt-databox
package-version: 1.0.0b1
title: DataBoxManagementClient
description: The DataBox Client.
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-2021-05
  - tag: package-2021-03
  - tag: package-2020-11
  - tag: package-2020-04
  - tag: package-2019-09
  - tag: package-2018-01
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/
clear-output-folder: false
perform-load: false
```
### Tag: package-2021-05 and python

These settings apply only when `--tag=package-2021-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-05' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2021_05_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2021_05_01
```

### Tag: package-2021-03 and python

These settings apply only when `--tag=package-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2021_03_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2021_03_01
```

### Tag: package-2020-11 and python

These settings apply only when `--tag=package-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2020_11_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2020_11_01
```

### Tag: package-2020-04 and python

These settings apply only when `--tag=package-2020-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2020_04_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2020_04_01
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2019_09_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2019_09_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01' && $(python) && $(track2)
namespace: azure.mgmt.databox.v2018_01_01
output-folder: $(python-sdks-folder)/databox/azure-mgmt-databox/azure/mgmt/databox/v2018_01_01
```
