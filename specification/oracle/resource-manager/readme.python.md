## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: OracleDatabaseMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-oracledatabase
namespace: azure.mgmt.oracledatabase
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/oracledatabase/azure-mgmt-oracledatabase/azure/mgmt/oracledatabase
```
``` yaml $(python) && $(python-mode) == 'create'
python:
    basic-setup-py: true
    output-folder: $(python-sdks-folder)/oracledatabase/azure-mgmt-oracledatabase
```
