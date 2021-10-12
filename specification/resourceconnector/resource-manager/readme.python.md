## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.


These settings apply only when `--python` is specified on the command line.

``` yaml !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-resourceconnector
  clear-output-folder: true
  no-namespace-folders: true
```

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resourceconnector
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-2021-10-31-preview
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2021-10-31-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-10-31-preview and python

These settings apply only when `--tag=package-2021-10-31-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10-31-preview'
namespace: azure.mgmt.resourceconnector.v2020_07_15_privatepreview
output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/v2021-10-31-preview
python:
  namespace: azure.mgmt.resourceconnector.v2020_07_15_privatepreview
  output-folder: $(python-sdks-folder)/resourceconnector/azure-mgmt-resourceconnector/azure/mgmt/resourceconnector/v2021-10-31-preview
```
