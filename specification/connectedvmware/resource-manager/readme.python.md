## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-connectedvmware
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2020-10-01-preview
  - multiapiscript: true
```

```yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/connectedvmware/azure-mgmt-vmware/azure/mgmt/vmware/
clear-output-folder: false
perform-load: false
```

### Tag: package-2020-10-01-preview and python

These settings apply only when `--tag=package-2020-10-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10-01-preview' && $(python)
namespace: azure.mgmt.vmware.v2020_10_01_preview
output-folder: $(python-sdks-folder)/connectedvmware/azure-mgmt-vmware/azure/mgmt/vmware/v2020_10_01_preview
```

