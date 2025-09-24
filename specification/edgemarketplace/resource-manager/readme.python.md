## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
title: EdgeMarketPlaceMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.edgemarketplace
package-name: azure-mgmt-edgemarketplace
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/edgemarketplace/azure-mgmt-edgemarketplace/azure/mgmt/edgemarketplace
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2024-10-01
```

### Tag: package-2024-01-01 and python

These settings apply only when `--tag=package-2024-10-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-10-01' && $(python)
python:
  namespace: azure.mgmt.edgemarketplace.v2024_10_01_preview
  output-folder: $(python-sdks-folder)/edgemarketplace/azure-mgmt-edgemarketplace/azure/mgmt/edgemarketplace/v2024_10_01
```