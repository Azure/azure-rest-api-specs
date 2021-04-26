## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.iothub
  package-name: azure-mgmt-iothub
  package-version: 0.8.2
  clear-output-folder: true
  no-namespace-folders: true
```

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.iothub
package-name: azure-mgmt-iothub
package-version: 0.8.2
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && !$(track2)
batch:
  - tag: package-preview-2021-03
  - tag: package-2020-03
  - tag: package-2019-11
  - tag: package-2019-03
  - tag: package-2018-04
  - tag: package-2018-01
  - tag: package-2017-07
  - tag: package-2017-01
  - tag: package-2016-02
```

```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-preview-2021-03
  - tag: package-2020-03
  - tag: package-2019-11
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
clear-output-folder: false
perform-load: false
```

### Tag: package-preview-2021-03 and python

These settings apply only when `--tag=package-preview-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-03' && $(python)
namespace: azure.mgmt.iothub.v2021_03_03_preview
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_03_03_preview
python:
  namespace: azure.mgmt.iothub.v2021_03_03_preview
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2021_03_03_preview
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03' && $(python)
namespace: azure.mgmt.iothub.v2020_03_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2020_03_01
python:
  namespace: azure.mgmt.iothub.v2020_03_01
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2020_03_01
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11' && $(python)
namespace: azure.mgmt.iothub.v2019_11_04
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_11_04
python:
  namespace: azure.mgmt.iothub.v2019_11_04
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_11_04
```

### Tag: package-2019-03 and python

These settings apply only when `--tag=package-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03' && $(python)
namespace: azure.mgmt.iothub.v2019_03_22
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_03_22
python:
  namespace: azure.mgmt.iothub.v2019_03_22
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_03_22
```

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04' && $(python)
namespace: azure.mgmt.iothub.v2018_04_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_04_01
python:
  namespace: azure.mgmt.iothub.v2018_04_01
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_04_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01' && $(python)
namespace: azure.mgmt.iothub.v2018_01_22
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_01_22
python:
  namespace: azure.mgmt.iothub.v2018_01_22
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_01_22
```

### Tag: package-2017-07 and python

These settings apply only when `--tag=package-2017-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-07' && $(python)
namespace: azure.mgmt.iothub.v2017_07_01
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_07_01
python:
  namespace: azure.mgmt.iothub.v2017_07_01
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_07_01
```

### Tag: package-2017-01 and python

These settings apply only when `--tag=package-2017-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-01' && $(python)
namespace: azure.mgmt.iothub.v2017_01_19
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_01_19
python:
  namespace: azure.mgmt.iothub.v2017_01_19
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_01_19
```

### Tag: package-2016-02 and python

These settings apply only when `--tag=package-2016-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-02' && $(python)
namespace: azure.mgmt.iothub.v2016_02_03
output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2016_02_03
python:
  namespace: azure.mgmt.iothub.v2016_02_03
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2016_02_03
```
