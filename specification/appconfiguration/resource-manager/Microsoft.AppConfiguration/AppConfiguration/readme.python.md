## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-appconfiguration
namespace: azure.mgmt.appconfiguration
package-version: 4.0.0
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration
```
