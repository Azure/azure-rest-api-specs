## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservice
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
default-api-version: "2025-04-01"
multiapi: true
batch:
  - tag: package-2025-04
  - tag: package-preview-2025-04
  - tag: package-2020-11
  - tag: package-2020-03-01-only
  - tag: package-2019-09-preview-only
  - tag: package-2017-07
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/
perform-load: false
```

### Tag: package-preview-2025-04 and python

These settings apply only when `--tag=package-preview-2025-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2025-04' && $(python)
namespace: azure.mgmt.containerservice.v2025_04_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2025_04_02_preview
```

### Tag: package-2025-04 and python

These settings apply only when `--tag=package-2025-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-04' && $(python)
namespace: azure.mgmt.containerservice.v2025_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2025_04_01
```

### Tag: package-2020-11 and python

These settings apply only when `--tag=package-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11' && $(python)
namespace: azure.mgmt.containerservice.v2020_11_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_11_01
```

### Tag: package-2020-03-01-only and python

These settings apply only when `--tag=package-2020-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_03_01
```

### Tag: package-2019-09-preview-only and python

These settings apply only when `--tag=package-2019-09-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2019_09_30_preview namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2019-09-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_09_30_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_09_30_preview
```

### Tag: package-2017-07 and python

These settings apply only when `--tag=package-2017-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2017_07_01 namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2017-07' && $(python)
namespace: azure.mgmt.containerservice.v2017_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2017_07_01
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.ManagedClusterLoadBalancerProfile.properties.managedOutboundIPs.properties["countIPv6"]
    transform: $["x-ms-client-name"] = "count_ipv6"
```
