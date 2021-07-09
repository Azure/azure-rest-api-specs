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
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml !$(track2)
batch:
  - tag: package-2020-01-01
  - tag: package-2020-07-01-preview
```

```yaml $(track2)
clear-output-folder: true
batch:
  - tag: package-flexibleserver-2021-05-01-preview
  - tag: package-2020-01-01
  - tag: package-2020-07-01-preview
```

### Tag: package-flexibleserver-2021-05-01-preview and python

These settings apply only when `--tag=package-flexibleserver-2021-05-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-05-01-preview' && $(python)
namespace: azure.mgmt.rdbms.mysql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql_flexibleservers
python:
  namespace: azure.mgmt.rdbms.mysql_flexibleservers
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql_flexibleservers
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
namespace: azure.mgmt.rdbms.mysql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql
python:
  namespace: azure.mgmt.rdbms.mysql
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql
```

### Tag: package-2020-07-01-preview and python

These settings apply only when `--tag=package-2020-07-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(python)
namespace: azure.mgmt.rdbms.mysql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql_flexibleservers
python:
  namespace: azure.mgmt.rdbms.mysql_flexibleservers
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql_flexibleservers
```