## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-rdbms
  clear-output-folder: true
  no-namespace-folders: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-rdbms
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml !$(track2)
batch:
  - tag: package-2020-01-01
  - tag: package-2018-06-01
  - tag: package-2017-12-01
  - tag: package-2020-02-14-privatepreview
  - tag: package-2020-01-01-privatepreview
  - tag: package-2018-06-01-privatepreview
  - tag: package-2017-12-01-preview
```

```yaml $(track2)
clear-output-folder: true
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
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2018-06-01 and python

These settings apply only when `--tag=package-2018-06-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-01' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2017-12-01 and python

These settings apply only when `--tag=package-2017-12-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2020-02-14-privatepreview and python

These settings apply only when `--tag=package-2020-02-14-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-02-14-privatepreview' && $(python)
namespace: azure.mgmt.rdbms.postgresql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql_flexibleservers
python:
  namespace: azure.mgmt.rdbms.postgresql_flexibleservers
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql_flexibleservers
```

### Tag: package-2020-01-01-privatepreview and python

These settings apply only when `--tag=package-2020-01-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-privatepreview' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2018-06-01-privatepreview and python

These settings apply only when `--tag=package-2018-06-01-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-01-privatepreview' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```

### Tag: package-2017-12-01-preview and python

These settings apply only when `--tag=package-2017-12-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(python)
namespace: azure.mgmt.rdbms.postgresql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
python:
  namespace: azure.mgmt.rdbms.postgresql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql
```