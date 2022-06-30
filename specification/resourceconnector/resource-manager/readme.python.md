## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resourceconnector
no-namespace-folders: true
package-version: 1.0.0b1
clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
clear-output-folder: true
batch:
  - tag: package-2022-04-15-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/
perform-load: false
```

### Tag: package-2022-04-15-preview and python

These settings apply only when `--tag=package-2022-04-15-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-04-15-preview'
namespace: azure.mgmt.resourceconnector.2022_04_15_preview
output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/2022_04_15_preview
```

### Tag: package-2021-10-31-preview and python

These settings apply only when `--tag=package-2021-10-31-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10-31-preview'
namespace: azure.mgmt.resourceconnector.v2021_10_31_preview
output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/v2021_10_31_preview
```


