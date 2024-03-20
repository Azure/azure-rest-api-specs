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
default-api-version: "2023-10-15"
multiapi: true
batch:
  - tag: package-2024-02-preview
  - tag: package-2023-10
  - tag: package-2023-08-preview
  - tag: package-2023-06-preview
  - tag: package-2023-03-preview
  - tag: package-2022-09-preview
  - tag: package-2022-07-preview
  - tag: package-2022-06-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/
clear-output-folder: false
perform-load: false
```

### Tag: package-2024-02-preview and python

These settings apply only when `--tag=package-2024-02-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-02-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2024_02_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2024_02_02_preview
```

### Tag: package-2023-10 and python

These settings apply only when `--tag=package-2023-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-10' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_10_15
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_10_15
```

### Tag: package-2023-08-preview and python

These settings apply only when `--tag=package-2023-08-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-08-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_08_15_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_08_15_preview
```

### Tag: package-2023-06-preview and python

These settings apply only when `--tag=package-2023-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-06-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_06_15_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_06_15_preview
```

### Tag: package-2023-03-preview and python

These settings apply only when `--tag=package-2023-03-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-03-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_03_15_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_03_15_preview
```

### Tag: package-2022-09-preview and python

These settings apply only when `--tag=package-2022-09-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-06-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_09_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_09_02_preview
```

### Tag: package-2022-07-preview and python

These settings apply only when `--tag=package-2022-07-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-07-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_07_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_07_02_preview
```

### Tag: package-2022-06-preview and python

These settings apply only when `--tag=package-2022-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-09-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_06_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_06_02_preview
```
