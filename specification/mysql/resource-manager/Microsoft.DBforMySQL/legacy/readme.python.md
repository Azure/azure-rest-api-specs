## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.



These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
title: MySQLManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-rdbms
no-namespace-folders: true
package-version: 1.0.0b1
clear-output-folder: true
```


``` yaml $(python)
namespace: azure.mgmt.rdbms.mysql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```