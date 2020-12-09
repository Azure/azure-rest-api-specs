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
  - tag: package-2020-10-05-privatepreview
```

```yaml $(track2)
clear-output-folder: true
batch:
  - tag: package-2020-10-05-privatepreview
```

### Tag: package-2020-10-05-privatepreview and python

These settings apply only when `--tag=package-2020-10-05-privatepreview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10-05-privatepreview' && $(python)
namespace: azure.mgmt.rdbms.postgresqlhsc
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresqlhsc
python:
  namespace: azure.mgmt.rdbms.postgresqlhsc
  output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresqlhsc
```