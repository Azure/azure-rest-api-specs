## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
title: ContainerServiceFleetMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservicefleet
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
batch:
  - tag: package-2024-05-preview
  - tag: package-2024-04
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/
clear-output-folder: true
perform-load: false
```

### Tag: package-2024-05-preview and python

These settings apply only when `--tag=package-2024-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-05-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2024_05_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2024_05_02_preview
```

### Tag: package-2024-04 and python

These settings apply only when `--tag=package-2024-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-04' && $(python)
namespace: azure.mgmt.containerservicefleet.v2024_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2024_04_01
```
