## Python

These settings apply only when `--python` is specified on the command line.

```yaml !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-storage
  payload-flattening-threshold: 2
  clear-output-folder: true
  no-namespace-folders: true
```

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-storage
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2018-11
  - tag: package-2018-07
  - tag: package-2018-03
  - tag: package-2018-02
  - tag: package-2017-10
  - tag: package-2017-06
  - tag: package-2016-12
  - tag: package-2016-01
  - tag: package-2015-06
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2018-11
  - tag: package-2018-07
  - tag: package-2018-03
  - tag: package-2018-02
  - tag: package-2017-10
  - tag: package-2017-06
  - tag: package-2016-12
  - tag: package-2016-01
  - tag: package-2015-06
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/
clear-output-folder: false
perform-load: false
```

### Tag: package-2019-06 and python

These settings apply only when `--tag=package-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06'
namespace: azure.mgmt.storage.v2019_06_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2019_06_01
python:
  namespace: azure.mgmt.storage.v2019_06_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2019_06_01
```
### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04'
namespace: azure.mgmt.storage.v2019_04_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2019_04_01
python:
  namespace: azure.mgmt.storage.v2019_04_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2019_04_01
```

### Tag: package-2018-11 and python

These settings apply only when `--tag=package-2018-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11'
namespace: azure.mgmt.storage.v2018_11_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_11_01
python:
  namespace: azure.mgmt.storage.v2018_11_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_11_01
```

### Tag: package-2018-07 and python

These settings apply only when `--tag=package-2018-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-07'
namespace: azure.mgmt.storage.v2018_07_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_07_01
python:
  namespace: azure.mgmt.storage.v2018_07_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_07_01
```

### Tag: package-2018-03 and python

These settings apply only when `--tag=package-2018-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-03'
namespace: azure.mgmt.storage.v2018_03_01_preview
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_03_01_preview
python:
  namespace: azure.mgmt.storage.v2018_03_01_preview
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_03_01_preview
```

### Tag: package-2018-02 and python

These settings apply only when `--tag=package-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02'
namespace: azure.mgmt.storage.v2018_02_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_02_01
python:
  namespace: azure.mgmt.storage.v2018_02_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2018_02_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10'
namespace: azure.mgmt.storage.v2017_10_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2017_10_01
python:
  namespace: azure.mgmt.storage.v2017_10_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2017_10_01
```

### Tag: package-2017-06 and python

These settings apply only when `--tag=package-2017-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-06'
namespace: azure.mgmt.storage.v2017_06_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2017_06_01
python:
  namespace: azure.mgmt.storage.v2017_06_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2017_06_01
```

### Tag: package-2016-12 and python

These settings apply only when `--tag=package-2016-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-12'
namespace: azure.mgmt.storage.v2016_12_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2016_12_01
python:
  namespace: azure.mgmt.storage.v2016_12_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2016_12_01
```

### Tag: package-2016-01 and python

These settings apply only when `--tag=package-2016-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-01'
namespace: azure.mgmt.storage.v2016_01_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2016_01_01
python:
  namespace: azure.mgmt.storage.v2016_01_01
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2016_01_01
```

### Tag: package-2015-06 and python

These settings apply only when `--tag=package-2015-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06'
namespace: azure.mgmt.storage.v2015_06_15
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2015_06_15
python:
  namespace: azure.mgmt.storage.v2015_06_15
  output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2015_06_15
```
