## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-computetest
no-namespace-folders: true
package-version: 1.0.0b1
combine-operation-files: true
only-path-and-body-params-positional: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2023-03-01"
clear-output-folder: true
batch:
  - tag: package-2023-03-01-only
  - tag: package-2023-01-02-only
  - multiclient: true
```

``` yaml $(multiclient)
output-folder: $(python-sdks-folder)/compute/azure-mgmt-computetest/azure/mgmt/computetest/
perform-load: false
```

### Tag: package-2023-03-01-only

These settings apply only when `--tag=package-2023-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-03-01-only'
namespace: azure.mgmt.computetest.v2023_03_01
output-folder: $(python-sdks-folder)/computetest/azure-mgmt-computetest/azure/mgmt/computetest/_generate/v2023_03_01
```

### Tag: package-2023-01-02-only

These settings apply only when `--tag=package-2023-01-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-01-02-only'
namespace: azure.mgmt.computetest.v2023_01_02
output-folder: $(python-sdks-folder)/computetest/azure-mgmt-computetest/azure/mgmt/computetest/_generate/v2023_01_02
```
