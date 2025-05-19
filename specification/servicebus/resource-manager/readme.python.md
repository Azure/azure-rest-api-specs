## Python


These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-servicebus
package-version: 1.0.0b1
no-namespace-folders: true
clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(python)
multiapi: true
default-api-version: "2021-11-01"
clear-output-folder: true
batch:
  - tag: package-2022-10-preview
  - tag: package-2021-11
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/
perform-load: false
```

### Tag: package-2022-10-preview and python

These settings apply only when `--tag=package-2022-10-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-10-preview'
namespace: azure.mgmt.servicebus.v2022_10_01_preview
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2022_10_01_preview
```

### Tag: package-2021-11 and python

These settings apply only when `--tag=package-2021-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-11'
namespace: azure.mgmt.servicebus.v2021_11_01
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2021_11_01
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
