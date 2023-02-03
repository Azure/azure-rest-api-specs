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

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2021-07-02
  - tag: package-2021-07
  - tag: package-2021-03
  - tag: package-preview-2021-03
  - tag: package-2020-03
  - tag: package-2019-11
  - tag: package-preview-2019-07
  - tag: package-2019-03
  - tag: package-2018-04
  - tag: package-2018-01
  - tag: package-2017-07
  - tag: package-2017-01
  - tag: package-2016-02
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/
perform-load: false

```
### Tag: package-2021-07-02 and python

These settings apply only when `--tag=package-2021-07-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-02' && $(python)
namespace: azure.mgmt.iothub.v2021_07_02
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_07_02
```

### Tag: package-2021-07 and python

These settings apply only when `--tag=package-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07' && $(python)
namespace: azure.mgmt.iothub.v2021_07_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_07_01
```

### Tag: package-2021-03 and python

These settings apply only when `--tag=package-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03' && $(python)
namespace: azure.mgmt.iothub.v2021_03_31
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_03_31
```

### Tag: package-preview-2021-03 and python

These settings apply only when `--tag=package-preview-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-03' && $(python)
namespace: azure.mgmt.iothub.v2021_03_03_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_03_03_preview
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03' && $(python)
namespace: azure.mgmt.iothub.v2020_03_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2020_03_01
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11' && $(python)
namespace: azure.mgmt.iothub.v2019_11_04
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_11_04
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

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04' && $(python)
namespace: azure.mgmt.iothub.v2018_04_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_04_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01' && $(python)
namespace: azure.mgmt.iothub.v2018_01_22
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_01_22
```

### Tag: package-2017-07 and python

These settings apply only when `--tag=package-2017-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-07' && $(python)
namespace: azure.mgmt.iothub.v2017_07_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_07_01
```

### Tag: package-2017-01 and python

These settings apply only when `--tag=package-2017-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-01' && $(python)
namespace: azure.mgmt.iothub.v2017_01_19
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_01_19
```

### Tag: package-2016-02 and python

These settings apply only when `--tag=package-2016-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-02' && $(python)
namespace: azure.mgmt.iothub.v2016_02_03
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2016_02_03
```
