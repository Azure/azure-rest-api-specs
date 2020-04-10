## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-network
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
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

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03' && $(python)
python:
  namespace: azure.mgmt.network.v2020_03_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_03_01
```

### Tag: package-2019-12 and python

These settings apply only when `--tag=package-2019-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12' && $(python)
python:
  namespace: azure.mgmt.network.v2019_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_12_01
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11' && $(python)
python:
  namespace: azure.mgmt.network.v2019_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_11_01
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09' && $(python)
python:
  namespace: azure.mgmt.network.v2019_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_09_01
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08' && $(python)
python:
  namespace: azure.mgmt.network.v2019_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_08_01
```

### Tag: package-2019-07 and python

These settings apply only when `--tag=package-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07' && $(python)
python:
  namespace: azure.mgmt.network.v2019_07_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_07_01
```

### Tag: package-2019-06 and python

These settings apply only when `--tag=package-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06' && $(python)
python:
  namespace: azure.mgmt.network.v2019_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_06_01
```

### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04' && $(python)
python:
  namespace: azure.mgmt.network.v2019_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_04_01
```

### Tag: package-2019-02 and python

These settings apply only when `--tag=package-2019-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-02' && $(python)
python:
  namespace: azure.mgmt.network.v2019_02_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_02_01
```

### Tag: package-2018-12 and python

These settings apply only when `--tag=package-2018-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-12' && $(python)
python:
  namespace: azure.mgmt.network.v2018_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_12_01
```

### Tag: package-2018-11 and python

These settings apply only when `--tag=package-2018-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11' && $(python)
python:
  namespace: azure.mgmt.network.v2018_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_11_01
```

### Tag: package-2018-10 and python

These settings apply only when `--tag=package-2018-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-10' && $(python)
python:
  namespace: azure.mgmt.network.v2018_10_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_10_01
```

### Tag: package-2018-08 and python

These settings apply only when `--tag=package-2018-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-08' && $(python)
python:
  namespace: azure.mgmt.network.v2018_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_08_01
```

### Tag: package-2018-07 and python

These settings apply only when `--tag=package-2018-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-07' && $(python)
python:
  namespace: azure.mgmt.network.v2018_07_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_07_01
```

### Tag: package-2018-06 and python

These settings apply only when `--tag=package-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06' && $(python)
python:
  namespace: azure.mgmt.network.v2018_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_06_01
```

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04' && $(python)
python:
  namespace: azure.mgmt.network.v2018_04_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_04_01
```

### Tag: package-2018-02 and python

These settings apply only when `--tag=package-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02' && $(python)
python:
  namespace: azure.mgmt.network.v2018_02_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_02_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01' && $(python)
python:
  namespace: azure.mgmt.network.v2018_01_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_01_01
```

### Tag: package-2017-11 and python

These settings apply only when `--tag=package-2017-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-11' && $(python)
python:
  namespace: azure.mgmt.network.v2017_11_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_11_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10' && $(python)
python:
  namespace: azure.mgmt.network.v2017_10_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_10_01
```

### Tag: package-2017-09 and python

These settings apply only when `--tag=package-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-09' && $(python)
python:
  namespace: azure.mgmt.network.v2017_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_09_01
```

### Tag: package-2017-08 and python

These settings apply only when `--tag=package-2017-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08' && $(python)
python:
  namespace: azure.mgmt.network.v2017_08_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_08_01
```

### Tag: package-2017-06 and python

These settings apply only when `--tag=package-2017-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-06' && $(python)
python:
  namespace: azure.mgmt.network.v2017_06_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_06_01
```

### Tag: package-2017-03 and python

These settings apply only when `--tag=package-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03' && $(python)
python:
  namespace: azure.mgmt.network.v2017_03_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_03_01
```

### Tag: package-2016-12 and python

These settings apply only when `--tag=package-2016-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-12' && $(python)
python:
  namespace: azure.mgmt.network.v2016_12_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_12_01
```

### Tag: package-2016-09 and python

These settings apply only when `--tag=package-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-09' && $(python)
python:
  namespace: azure.mgmt.network.v2016_09_01
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2016_09_01
```

### Tag: package-2015-06split and python

These settings apply only when `--tag=package-2015-06split --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06split' && $(python)
python:
  namespace: azure.mgmt.network.v2015_06_15
  output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2015_06_15
```
