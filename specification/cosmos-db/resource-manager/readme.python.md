## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-cosmosdb
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2019-08
  - tag: package-2019-08-preview
  - tag: package-2015-04
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2019_08_01
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2019_08_01
```

### Tag: package-2019-08-preview and python

These settings apply only when `--tag=package-2019-08-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-preview' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2019_08_01_preview
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2019_08_01_preview
```

### Tag: package-2015-04 and python

These settings apply only when `--tag=package-2015-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-04' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2015_04_01
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2015_04_01
```

### Tag: package-2014-04 and python

These settings apply only when `--tag=package-2014-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2014-04' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2014_04_01
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2014_04_01
```

### Tag: package-2015-11 and python

These settings apply only when `--tag=package-2015-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-11' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2015_11_06
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2015_11_06
```

### Tag: package-2016-03-19 and python

These settings apply only when `--tag=package-2016-03-19 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-03-19' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2016_03_19
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2016_03_19
```

### Tag: package-2016-03-31 and python

These settings apply only when `--tag=package-2016-03-31 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-03-31' && $(python)
python:
  namespace: azure.mgmt.cosmosdb.v2016_03_31
  output-folder: $(python-sdks-folder)/cosmos/azure-mgmt-cosmosdb/azure/mgmt/cosmosdb/v2016_03_31
```
