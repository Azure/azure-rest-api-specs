## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-compute
  no-namespace-folders: true
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2018-10-01-only
  - tag: package-2018-09-30-only
  - tag: package-compute-only-2018-06
  - tag: package-compute-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-compute-2015-06
```

### Tag: package-2018-10-01-only and python

These settings apply only when `--tag=package-2018-10-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-10-01-only' && $(python)
python:
  namespace: azure.mgmt.compute.v2018_10_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2018_10_01
```

### Tag: package-2018-09-30-only and python

These settings apply only when `--tag=package-2018-09-30-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-30-only' && $(python)
python:
  namespace: azure.mgmt.compute.v2018_09_30
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2018_09_30
```

### Tag: package-compute-only-2018-06 and python

These settings apply only when `--tag=package-compute-only-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-only-2018-06' && $(python)
python:
  namespace: azure.mgmt.compute.v2018_06_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2018_06_01
```

### Tag: package-compute-2018-04 and python

These settings apply only when `--tag=package-compute-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2018-04' && $(python)
python:
  namespace: azure.mgmt.compute.v2018_04_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2018_04_01
```

### Tag: package-compute-only-2017-12 and python

These settings apply only when `--tag=package-compute-only-2017-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_12_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_12_01
```

### Tag: package-skus-2017-09 and python

These settings apply only when `--tag=package-skus-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_09_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_09_01
```

### Tag: package-compute-2017-03 and python

These settings apply only when `--tag=package-compute-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_03_30
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_03_30
```

### Tag: package-compute-2016-04-preview and python

These settings apply only when `--tag=package-compute-2016-04-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-04-preview' && $(python)
python:
  namespace: azure.mgmt.compute.v2016_04_30_preview
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2016_04_30_preview
```

### Tag: package-compute-2016-03 and python

These settings apply only when `--tag=package-compute-2016-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-03' && $(python)
python:
  namespace: azure.mgmt.compute.v2016_03_30
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2016_03_30
```

### Tag: package-compute-2015-06 and python

These settings apply only when `--tag=package-compute-2015-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2015-06' && $(python)
python:
  namespace: azure.mgmt.compute.v2015_06_15
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2015_06_15
```
