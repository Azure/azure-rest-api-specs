## Python
 
These settings apply only when `--python` is specified on the command line.
 
```yaml $(python)
title: ContainerServiceFleetMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservicefleet
package-version: 4.0.0b2
clear-output-folder: true
no-namespace-folders: true
```
 
### Python multi-api
 
Generate all API versions currently shipped for this package
 
```yaml $(python)
multiapi: true
batch:
  - tag: package-2025-04-01-preview
  - tag: package-2025-03-01
  - tag: package-2024-05-preview
  - tag: package-2024-04
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
clear-output-folder: true
perform-load: false
```

### Tag: package-2025-04-01-preview and python
 
These settings apply only when `--tag=package-2025-04-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2025-04-01-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2025_04_01_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2025_04_01_preview
```
 
### Tag: package-2025-03-01 and python
 
These settings apply only when `--tag=package-2025-03-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2025-03-01' && $(python)
namespace: azure.mgmt.containerservicefleet.v2025_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2025_03_01
```
 
### Tag: package-2024-02-preview and python
 
These settings apply only when `--tag=package-2024-02-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2024-02-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2024_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2024_02_preview
```
 
### Tag: package-2023-10 and python
 
These settings apply only when `--tag=package-2023-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2023-10' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_10_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_10_01
```
 
### Tag: package-2023-08-preview and python
 
These settings apply only when `--tag=package-2023-08-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2023-08-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_08_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_08_preview
```
 
### Tag: package-2023-06-preview and python
 
These settings apply only when `--tag=package-2023-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2023-06-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_06_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_06_preview
```
 
### Tag: package-2023-03-preview and python
 
These settings apply only when `--tag=package-2023-03-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2023-03-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2023_03_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2023_03_preview
```
 
### Tag: package-2022-09-preview and python
 
These settings apply only when `--tag=package-2022-09-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2022-09-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_09_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_09_preview
```
 
### Tag: package-2022-07-preview and python
 
These settings apply only when `--tag=package-2022-07-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2022-07-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_07_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_07_preview
```
 
### Tag: package-2022-06-preview and python
 
These settings apply only when `--tag=package-2022-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
 
``` yaml $(tag) == 'package-2022-06-preview' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_06_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_06_preview
```