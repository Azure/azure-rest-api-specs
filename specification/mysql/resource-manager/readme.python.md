## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
clear-output-folder: true
```

### Tag: package-flexibleserver-2024-02-01-preview and python

These settings apply only when `--tag=package-flexibleserver-2024-02-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-flexibleserver-2024-02-01-preview' && $(python)
title: MySQLManagementClient
package-version: 1.0.0b1
package-name: azure-mgmt-mysqlflexibleservers
namespace: azure.mgmt.mysqlflexibleservers
output-folder: $(python-sdks-folder)/mysqlflexibleservers/azure-mgmt-mysqlflexibleservers/azure/mgmt/mysqlflexibleservers
```

### Tag: package-2020-01-01 and python

These settings apply only when `--tag=package-2020-01-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(python)
title: MySQLManagementClient
package-name: azure-mgmt-rdbms
package-version: 1.0.0b1
namespace: azure.mgmt.rdbms.mysql
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/mysql
modelerfour:
  lenient-model-deduplication: true
```
