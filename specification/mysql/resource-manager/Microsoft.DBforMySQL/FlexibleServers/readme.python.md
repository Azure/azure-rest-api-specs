## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: MySQLManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
clear-output-folder: true
package-version: 10.1.1
package-name: azure-mgmt-rdbms
namespace: azure.mgmt.rdbms.mysql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql_flexibleservers
```
