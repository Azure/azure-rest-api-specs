## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```  yaml $(python) 
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-rdbms
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
batch:
  - tag: package-2020-01-01
  - tag: package-2018-06-01
  - tag: package-2017-12-01
  - tag: package-2020-02-14-privatepreview
  - tag: package-2020-01-01-privatepreview
  - tag: package-2018-06-01-privatepreview
  - tag: package-2017-12-01-preview
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2018-06-01 and python

These settings apply only when `--tag=package-2018-06-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2017-12-01 and python

These settings apply only when `--tag=package-2017-12-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2020-02-14-privatepreview and python

These settings apply only when `--tag=package-2020-02-14-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-02-14-privatepreview' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql.flexibleservers
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql/flexibleservers
```

### Tag: package-2020-01-01-privatepreview and python

These settings apply only when `--tag=package-2020-01-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-privatepreview' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2018-06-01-privatepreview and python

These settings apply only when `--tag=package-2018-06-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-01-privatepreview' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2017-12-01-preview and python

These settings apply only when `--tag=package-2017-12-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(python)
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```