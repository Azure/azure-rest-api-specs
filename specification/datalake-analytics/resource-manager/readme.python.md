## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-datalake-analytics
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python-mode) == 'update' && $(track2)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-analytics/azure/mgmt/datalake/analytics/account
```

``` yaml $(python-mode) == 'create' && $(track2)
basic-setup-py: true
namespace: azure.mgmt.datalake.analytics.account
output-folder: $(python-sdks-folder)/datalake/azure-mgmt-datalake-analytics
```
