## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: MySQLManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
clear-output-folder: true
package-version: 1.0.0b1
package-name: azure-mgmt-mysqlflexibleservers
namespace: azure.mgmt.mysqlflexibleservers
output-folder: $(python-sdks-folder)/mysqlflexibleservers/azure-mgmt-mysqlflexibleservers/azure/mgmt/mysqlflexibleservers
```
