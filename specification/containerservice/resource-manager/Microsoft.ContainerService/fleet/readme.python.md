## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
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
  - tag: package-preview-2022-09
  - tag: package-preview-2022-07
  - tag: package-preview-2022-06
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/
perform-load: false
```

### Tag: package-preview-2022-09 and python

These settings apply only when `--tag=package-preview-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_09_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_09_02_preview
```

### Tag: package-preview-2022-07 and python

These settings apply only when `--tag=package-preview-2022-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-07' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_07_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_07_02_preview
```
### Tag: package-preview-2022-06 and python

These settings apply only when `--tag=package-preview-2022-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-06' && $(python)
namespace: azure.mgmt.containerservicefleet.v2022_06_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservicefleet/azure/mgmt/containerservicefleet/v2022_06_02_preview
```
