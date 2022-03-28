## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-relay
package-version: 1.0.0b1
no-namespace-folders: true
modelerfour:
  lenient-model-deduplication: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-2021-11
  - tag: package-2018-01-preview
  - tag: package-2017-04
  - tag: package-2016-07
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-11 and python

These settings apply only when `--tag=package-2021-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-11'
namespace: azure.mgmt.relay.v2021_11_01
output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2021_11_01
python:
  namespace: azure.mgmt.relay.v2021_11_01
  output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2021_11_01
```

### Tag: package-2018-01-preview and python

These settings apply only when `--tag=package-2018-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-01-preview'
namespace: azure.mgmt.relay.v2018_01_01_preview
output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2018_01_01_preview
python:
  namespace: azure.mgmt.relay.v2018_01_01_preview
  output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2018_01_01_preview
```

### Tag: package-2017-04 and python

These settings apply only when `--tag=package-2017-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-04'
namespace: azure.mgmt.relay.v2017_04_01
output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2017_04_01
python:
  namespace: azure.mgmt.relay.v2017_04_01
  output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2017_04_01
```

### Tag: package-2016-07 and python

These settings apply only when `--tag=package-2016-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2016-07'
namespace: azure.mgmt.relay.v2016_07_01
output-folder: $(python-sdks-folder)/relay/azure-mgmt-relay/azure/mgmt/relay/v2016_07_01
python:
  namespace: azure.mgmt.relay.v2016_07_01
  output-folder: $(python-sdks-folder)relay/azure-mgmt-relay/azure/mgmt/relay/v2016_07_01
```

