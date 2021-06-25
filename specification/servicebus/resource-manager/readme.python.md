## Python


These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-servicebus
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package


```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2021-01-preview
  - tag: package-2018-01-preview
  - tag: package-2017-04
  - tag: package-2015-08
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-01-preview and python

These settings apply only when `--tag=package-2021-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-preview'
namespace: azure.mgmt.servicebus.v2021_01_01_preview
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2021_01_01_preview
```

### Tag: package-2018-01-preview and python

These settings apply only when `--tag=package-2018-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01-preview'
namespace: azure.mgmt.servicebus.v2018_01_01_preview
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2018_01_01_preview
```

### Tag: package-2017-04 and python

These settings apply only when `--tag=package-2017-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-04'
namespace: azure.mgmt.servicebus.v2017_04_01
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2017_04_01
```

### Tag: package-2015-08 and python

These settings apply only when `--tag=package-2015-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-08'
namespace: azure.mgmt.servicebus.v2015_08_01
output-folder: $(python-sdks-folder)/servicebus/azure-mgmt-servicebus/azure/mgmt/servicebus/v2015_08_01
```
