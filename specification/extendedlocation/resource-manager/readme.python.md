## Python

These settings apply only when `--track2` is specified on the command line.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-extendedlocation
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

``` yaml $(python) && $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2021-03-15-preview
  - tag: package-2021-08-15
  - multiapiscript: true
```

```yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/extendedlocation/azure-mgmt-extendedlocation/azure/mgmt/extendedlocation/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-03-15-preview and python

These settings apply only when `--tag=package-2021-03-15-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2021-03-15-preview' && $(python)
namespace: azure.mgmt.extendedlocation.v2021_03_15_preview
output-folder: $(python-sdks-folder)/extendedlocation/azure-mgmt-extendedlocation/azure/mgmt/extendedlocation/v2021_03_15_preview
```

### Tag: package-2021-08-15 and python

These settings apply only when `--tag=package-2021-08-15 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2021-08-15' && $(python)
namespace: azure.mgmt.extendedlocation.v2021_08_15
output-folder: $(python-sdks-folder)/extendedlocation/azure-mgmt-extendedlocation/azure/mgmt/extendedlocation/v2021_08_15
```
