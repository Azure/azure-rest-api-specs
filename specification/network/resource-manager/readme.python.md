## Python

These settings apply only when `--python` is specified on the command line.

``` yaml !$(track2)
python:
  azure-arm: true
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-network
  clear-output-folder: true
  no-namespace-folders: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-network
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-2020-05
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-11
  - tag: package-2019-09
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-12
  - tag: package-2018-11
  - tag: package-2018-10
  - tag: package-2018-08
  - tag: package-2018-07
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2018-02
  - tag: package-2018-01
  - tag: package-2017-11
  - tag: package-2017-10
  - tag: package-2017-09
  - tag: package-2017-08
  - tag: package-2017-06
  - tag: package-2017-03
  - tag: package-2016-12
  - tag: package-2016-09
  - tag: package-2015-06split
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2020-05
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-11
  - tag: package-2019-09
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-12
  - tag: package-2018-11
  - tag: package-2018-10
  - tag: package-2018-08
  - tag: package-2018-07
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2018-02
  - tag: package-2018-01
  - tag: package-2017-11
  - tag: package-2017-10
  - tag: package-2017-09
  - tag: package-2017-08
  - tag: package-2017-06
  - tag: package-2017-03
  - tag: package-2016-12
  - tag: package-2016-09
  - tag: package-2015-06split
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-05 and python

These settings apply only when `--tag=package-2020-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05'
namespace: azure.mgmt.network.v2020_05_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_05_01
python:
  namespace: azure.mgmt.network.v2020_05_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_05_01
```

### Tag: package-2020-04 and python

These settings apply only when `--tag=package-2020-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04'
namespace: azure.mgmt.network.v2020_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_04_01
python:
  namespace: azure.mgmt.network.v2020_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_04_01
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03'
namespace: azure.mgmt.network.v2020_03_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_03_01
python:
  namespace: azure.mgmt.network.v2020_03_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_03_01
```

### Tag: package-2019-12 and python

These settings apply only when `--tag=package-2019-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12'
namespace: azure.mgmt.network.v2019_12_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_12_01
python:
  namespace: azure.mgmt.network.v2019_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_12_01
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11'
namespace: azure.mgmt.network.v2019_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_11_01
python:
  namespace: azure.mgmt.network.v2019_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_11_01
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09'
namespace: azure.mgmt.network.v2019_09_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_09_01
python:
  namespace: azure.mgmt.network.v2019_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_09_01
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08'
namespace: azure.mgmt.network.v2019_08_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_08_01
python:
  namespace: azure.mgmt.network.v2019_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_08_01
```

### Tag: package-2019-07 and python

These settings apply only when `--tag=package-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07'
namespace: azure.mgmt.network.v2019_07_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_07_01
python:
  namespace: azure.mgmt.network.v2019_07_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_07_01
```

### Tag: package-2019-06 and python

These settings apply only when `--tag=package-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06'
namespace: azure.mgmt.network.v2019_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_06_01
python:
  namespace: azure.mgmt.network.v2019_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_06_01
```

### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04'
namespace: azure.mgmt.network.v2019_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_04_01
python:
  namespace: azure.mgmt.network.v2019_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_04_01
```

### Tag: package-2019-02 and python

These settings apply only when `--tag=package-2019-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-02'
namespace: azure.mgmt.network.v2019_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_02_01
python:
  namespace: azure.mgmt.network.v2019_02_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_02_01
```

### Tag: package-2018-12 and python

These settings apply only when `--tag=package-2018-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-12'
namespace: azure.mgmt.network.v2018_12_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_12_01
python:
  namespace: azure.mgmt.network.v2018_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_12_01
```

### Tag: package-2018-11 and python

These settings apply only when `--tag=package-2018-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11'
namespace: azure.mgmt.network.v2018_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_11_01
python:
  namespace: azure.mgmt.network.v2018_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_11_01
```

### Tag: package-2018-10 and python

These settings apply only when `--tag=package-2018-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-10'
namespace: azure.mgmt.network.v2018_10_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_10_01
python:
  namespace: azure.mgmt.network.v2018_10_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_10_01
```

### Tag: package-2018-08 and python

These settings apply only when `--tag=package-2018-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-08'
namespace: azure.mgmt.network.v2018_08_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_08_01
python:
  namespace: azure.mgmt.network.v2018_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_08_01
```

### Tag: package-2018-07 and python

These settings apply only when `--tag=package-2018-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-07'
namespace: azure.mgmt.network.v2018_07_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_07_01
python:
  namespace: azure.mgmt.network.v2018_07_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_07_01
```

### Tag: package-2018-06 and python

These settings apply only when `--tag=package-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06'
namespace: azure.mgmt.network.v2018_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_06_01
python:
  namespace: azure.mgmt.network.v2018_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_06_01
```

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04'
namespace: azure.mgmt.network.v2018_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_04_01
python:
  namespace: azure.mgmt.network.v2018_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_04_01
```

### Tag: package-2018-02 and python

These settings apply only when `--tag=package-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02'
namespace: azure.mgmt.network.v2018_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_02_01
python:
  namespace: azure.mgmt.network.v2018_02_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_02_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01'
namespace: azure.mgmt.network.v2018_01_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_01_01
python:
  namespace: azure.mgmt.network.v2018_01_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_01_01
```

### Tag: package-2017-11 and python

These settings apply only when `--tag=package-2017-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-11'
namespace: azure.mgmt.network.v2017_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_11_01
python:
  namespace: azure.mgmt.network.v2017_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_11_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10'
namespace: azure.mgmt.network.v2017_10_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_10_01
python:
  namespace: azure.mgmt.network.v2017_10_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_10_01
```

### Tag: package-2017-09 and python

These settings apply only when `--tag=package-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-09'
namespace: azure.mgmt.network.v2017_09_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_09_01
python:
  namespace: azure.mgmt.network.v2017_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_09_01
```

### Tag: package-2017-08 and python

These settings apply only when `--tag=package-2017-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08'
namespace: azure.mgmt.network.v2017_08_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_08_01
python:
  namespace: azure.mgmt.network.v2017_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_08_01
```

### Tag: package-2017-06 and python

These settings apply only when `--tag=package-2017-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-06'
namespace: azure.mgmt.network.v2017_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_06_01
python:
  namespace: azure.mgmt.network.v2017_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_06_01
```

### Tag: package-2017-03 and python

These settings apply only when `--tag=package-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03'
namespace: azure.mgmt.network.v2017_03_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_03_01
python:
  namespace: azure.mgmt.network.v2017_03_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_03_01
```

### Tag: package-2016-12 and python

These settings apply only when `--tag=package-2016-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-12'
namespace: azure.mgmt.network.v2016_12_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_12_01
python:
  namespace: azure.mgmt.network.v2016_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_12_01
```

### Tag: package-2016-09 and python

These settings apply only when `--tag=package-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-09'
namespace: azure.mgmt.network.v2016_09_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_09_01
python:
  namespace: azure.mgmt.network.v2016_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_09_01
```

### Tag: package-2015-06split and python

These settings apply only when `--tag=package-2015-06split --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06split'
namespace: azure.mgmt.network.v2015_06_15
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2015_06_15
python:
  namespace: azure.mgmt.network.v2015_06_15
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2015_06_15
```
