## Python

These settings apply only when `--python` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-storage
package-version: 1.0.0b1
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2024-01-01"
clear-output-folder: true
batch:
  - tag: package-2024-01
  - tag: package-2023-05
  - tag: package-2019-06
  - tag: package-2017-10
  - tag: package-2016-01
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/
perform-load: false
```

### Tag: package-2024-01 and python

These settings apply only when `--tag=package-2024-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-01'
namespace: azure.mgmt.storage.v2024_01_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2024_01_01
```

### Tag: package-2023-05 and python

These settings apply only when `--tag=package-2023-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-05'
namespace: azure.mgmt.storage.v2023_05_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2023_05_01
```

### Tag: package-2019-06 and python

These settings apply only when `--tag=package-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06'
namespace: azure.mgmt.storage.v2019_06_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2019_06_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10'
namespace: azure.mgmt.storage.v2017_10_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2017_10_01
```

### Tag: package-2016-01 and python

These settings apply only when `--tag=package-2016-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-01'
namespace: azure.mgmt.storage.v2016_01_01
output-folder: $(python-sdks-folder)/storage/azure-mgmt-storage/azure/mgmt/storage/v2016_01_01
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.LeaseContainerRequest
    transform: $['properties']['action']['x-ms-enum']['name'] = 'LeaseContainerRequestEnum'
```
