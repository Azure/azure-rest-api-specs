## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-containerregistry
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-12-preview
  - tag: package-2019-06-preview
  - tag: package-2019-05
  - tag: package-2019-05-preview
  - tag: package-2019-04
  - tag: package-2018-09
  - tag: package-2018-02-preview
  - tag: package-2017-10
  - tag: package-2017-03
```

### Tag: package-2019-12-preview and python

These settings apply only when `--tag=package-2019-12-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12-preview' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2019_12_01_preview
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_12_01_preview
```

### Tag: package-2019-06-preview and python

These settings apply only when `--tag=package-2019-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-preview' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2019_06_01_preview
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_06_01_preview
```

### Tag: package-2019-05 and python

These settings apply only when `--tag=package-2019-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2019_05_01
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01
```

### Tag: package-2019-05-preview and python

These settings apply only when `--tag=package-2019-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-preview' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2019_05_01_preview
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01_preview
```

### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2019_04_01
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_04_01
```

### Tag: package-2018-09 and python

These settings apply only when `--tag=package-2018-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2018_09_01
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_09_01
```

### Tag: package-2018-02-preview and python

These settings apply only when `--tag=package-2018-02-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2018_02_01_preview
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_02_01_preview
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2017_10_01
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_10_01
```

### Tag: package-2017-03 and python

These settings apply only when `--tag=package-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2017_03_01
  output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_03_01
```
