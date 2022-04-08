## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-managedapplication
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(python)
clear-output-folder: true
batch:
  - tag: package-managedapplications-2021-07
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/
perform-load: false
```

### Tag: package-managedapplications-2021-07 and python

These settings apply only when `--tag=package-managedapplications-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07'
namespace: azure.mgmt.managedapplication.v2021_07_01
output-folder: $(python-sdks-folder)/managedapplication/azure-mgmt-managedapplication/azure/mgmt/managedapplication/v2021_07_01
```
