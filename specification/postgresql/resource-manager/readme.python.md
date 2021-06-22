## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-rdbms
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && $(track2)
namespace: azure.mgmt.rdbms.postgresql_flexibleservers
output-folder: $(python-sdks-folder)/rdbms/azure-mgmt-rdbms/azure/mgmt/rdbms/postgresql_flexibleservers
```
