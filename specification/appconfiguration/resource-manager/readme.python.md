## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-appconfiguration
package-version: 1.0.0b1
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
default-api-version: "2024-05-01"
multiapi: true
batch:
  - tag: package-2024-05-01
  - tag: package-2023-03-01
  - tag: package-2022-05-01
  - tag: package-2022-03-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration/
perform-load: false
```

### Tag: package-2024-05-01 and python

These settings apply only when `--tag=package-2024-05-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-05-01' && $(python)
namespace: azure.mgmt.appconfiguration.v2024_05_01
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration/v2024_05_01
```

### Tag: package-2023-03-01 and python

These settings apply only when `--tag=package-2023-03-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-03-01' && $(python)
namespace: azure.mgmt.appconfiguration.v2023_03_01
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration/v2023_03_01
```

### Tag: package-2022-05-01 and python

These settings apply only when `--tag=package-2022-05-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-05-01' && $(python)
namespace: azure.mgmt.appconfiguration.v2022_05_01
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration/v2022_05_01
```

### Tag: package-2022-03-01-preview and python

These settings apply only when `--tag=package-2022-03-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03-01-preview' && $(python)
namespace: azure.mgmt.appconfiguration.v2022_03_01_preview
output-folder: $(python-sdks-folder)/appconfiguration/azure-mgmt-appconfiguration/azure/mgmt/appconfiguration/v2022_03_01_preview
```
