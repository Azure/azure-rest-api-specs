## Python

These settings apply only when `--python` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-mgmt-eventhub
clear-output-folder: false
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
batch:
  - tag: package-2018-01-preview
  - tag: package-2017-04
  - tag: package-2015-08
  - multiapi: true
```

```yaml $(python-mode) == 'update'
clear-output-folder: false
no-namespace-folders: true
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub/azure/mgmt/eventhub
```

```yaml $(python-mode) == 'create'
basic-setup-py: true
package-version: 1.0.0
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub
```

### Multi-api script

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub/azure/mgmt/eventhub/
clear-output-folder: false
perform-load: false
```


### Tag: package-2018-01-preview and python

These settings apply only when `--tag=package-2018-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01-preview'
namespace: azure.mgmt.eventhub.v2018_01_01_preview
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub/azure/mgmt/eventhub/v2018_01_01_preview
```

### Tag: package-2017-04 and python

These settings apply only when `--tag=package-2017-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-04'
namespace: azure.mgmt.eventhub.v2017_04_01
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub/azure/mgmt/eventhub/v2017_04_01
```

### Tag: package-2015-08 and python

These settings apply only when `--tag=package-2015-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-08'
namespace: azure.mgmt.eventhub.v2015_08_01
output-folder: $(python-sdks-folder)/eventhub/azure-mgmt-eventhub/azure/mgmt/eventhub/v2015_08_01
```
