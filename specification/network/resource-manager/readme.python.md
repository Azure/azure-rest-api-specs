## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: NetworkManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-network
namespace: azure.mgmt.network
package-version: 28.0.0
clear-output-folder: true
combine-operation-files: true
only-path-and-body-params-positional: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $
    transform: $.host = "management.azure.com"
  
  - from: swagger-document
    where: $
    transform: $.schemes = ["https"]
```
