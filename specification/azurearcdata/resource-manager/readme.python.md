## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
use-extension:
  "@autorest/modelerfour": 4.15.421
modelerfour:
    lenient-model-deduplication: true
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-azurearcdata
namespace: azure.mgmt.azurearcdata
package-version: 1.1.1b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/azurearcdata/azure-mgmt-azurearcdata/azure/mgmt/azurearcdata
```
