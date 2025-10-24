## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: RedHatOpenShiftHcpMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-redhatopenshifthcp
namespace: azure.mgmt.redhatopenshifthcp
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/redhatopenshifthcp/azure-mgmt-redhatopenshifthcp/azure/mgmt/redhatopenshifthcp
```

``` yaml $(python)
modelerfour:
  flatten-models: false
```

### Tag: package-2024-06-10-preview and python

These settings apply only when `--tag=package-2024-06-10-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-06-10-preview' && $(python)
namespace: azure.mgmt.redhatopenshifthcp.v2024_06_10_preview
output-folder: $(python-sdks-folder)/redhatopenshifthcp/azure-mgmt-redhatopenshifthcp/azure/mgmt/redhatopenshifthcp/v2024_06_10_preview
```