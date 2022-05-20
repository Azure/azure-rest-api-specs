## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-digitaltwins
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2021-06-30-preview
  - tag: package-2020-12
  - tag: package-2020-10
  - tag: package-2020-03-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/
perform-load: false
```

### Tag: package-2021-06-30-preview and python

These settings apply only when `--tag=package-2021-06-30-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-06-30-preview' && $(python)
namespace: azure.mgmt.digitaltwins.v2021_06_30_preview
output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2021_06_30_preview
```

### Tag: package-2020-12 and python

These settings apply only when `--tag=package-2020-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12' && $(python)
namespace: azure.mgmt.digitaltwins.v2020_12_01
output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2020_12_01
```

### Tag: package-2020-10 and python

These settings apply only when `--tag=package-2020-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10' && $(python)
namespace: azure.mgmt.digitaltwins.v2020_10_31
output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2020_10_31
```

### Tag: package-2020-03-01-preview and python

These settings apply only when `--tag=package-2020-03-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03-01-preview' && $(python)
namespace: azure.mgmt.digitaltwins.v2020_03_01_preview
output-folder: $(python-sdks-folder)/digitaltwins/azure-mgmt-digitaltwins/azure/mgmt/digitaltwins/v2020_03_01_preview
```


```yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
