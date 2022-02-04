## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-dashboard
package-version: 1.0.0
no-namespace-folders: true
```

### Python Multi API Generation

Generate all API versions currently shipped for this package. These settings apply only when `--multiapi` is specified on the command line.

```yaml $(python) && $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2021-09-01-preview
  - multiapiscript: true
```

```yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/dashboard/azure-mgmt-dashboard/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-09-01-preview and python

These settings apply only when `--tag=package-2021-09-01-preview --python` is specified on the command line. Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(python)
namespace: azure.mgmt.dashboard.v2021_09_01_preview
output-folder: $(python-sdks-folder)/dashboard/azure-mgmt-dashboard/v2021_09_01_preview
```

