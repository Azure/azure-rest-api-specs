## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
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

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-11
  - tag: package-2019-03
  - tag: package-2018-04
  - tag: package-2018-01
  - tag: package-2017-07
  - tag: package-2017-01
  - tag: package-2016-02
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11' && $(python)
python:
  namespace: azure.mgmt.iothub.v2019_11_04
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_11_04
```

### Tag: package-2019-03 and python

These settings apply only when `--tag=package-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03' && $(python)
python:
  namespace: azure.mgmt.iothub.v2019_03_22
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2019_03_22
```

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04' && $(python)
python:
  namespace: azure.mgmt.iothub.v2018_04_01
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_04_01
```

### Tag: package-2018-01 and python

These settings apply only when `--tag=package-2018-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01' && $(python)
python:
  namespace: azure.mgmt.iothub.v2018_01_22
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2018_01_22
```

### Tag: package-2017-07 and python

These settings apply only when `--tag=package-2017-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-07' && $(python)
python:
  namespace: azure.mgmt.iothub.v2017_07_01
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_07_01
```

### Tag: package-2017-01 and python

These settings apply only when `--tag=package-2017-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-01' && $(python)
python:
  namespace: azure.mgmt.iothub.v2017_01_19
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2017_01_19
```

### Tag: package-2016-02 and python

These settings apply only when `--tag=package-2016-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-02' && $(python)
python:
  namespace: azure.mgmt.iothub.v2016_02_03
  output-folder: $(python-sdks-folder)/iothub/azure-mgmt-iothub/azure/mgmt/iothub/v2016_02_03
```
