## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
title: EdgeMarketPlaceMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-mgmt-edgemarketplace
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
multiapi: true
clear-output-folder: true
batch:
  - tag: package-2023-08-01
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/edgemarketplace/azure-mgmt-edgemarketplace/azure/mgmt/edgemarketplace/
perform-load: false
clear-output-folder: false
```

### Tag: package-2023-08-01 and python

These settings apply only when `--tag=package-2023-08-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-08-01' && $(python)
namespace: azure.mgmt.edgemarketplace.v2023_08_01
output-folder: $(python-sdks-folder)/edgemarketplace/azure-mgmt-edgemarketplace/azure/mgmt/edgemarketplace/v2023_08_01
```
