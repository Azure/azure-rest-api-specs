## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-mgmt-authorization
no-namespace-folders: true
clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
batch:
  - tag: package-2018-09-01-preview-only
  - tag: package-2018-07-01-preview-only
  - tag: package-2018-01-01-preview-only
  - tag: package-2015-07-01
  - tag: package-2015-06-01-preview
  - multiapiscript: true
```

### Multi-api script

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/
clear-output-folder: false
perform-load: false
default-api: 2018-09-01-preview
```

### Tag: package-2018-09-01-preview-only

These settings apply only when `--tag=package-2018-09-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-01-preview-only'

namespace: azure.mgmt.authorization.v2018_09_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_09_01_preview
```

### Tag: package-2018-07-01-preview-only

These settings apply only when `--tag=package-2018-07-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview-only'

namespace: azure.mgmt.authorization.v2018_07_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_07_01_preview
```

### Tag: package-2018-01-01-preview-only

These settings apply only when `--tag=package-2018-01-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview-only'

namespace: azure.mgmt.authorization.v2018_01_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_01_01_preview
```

### Tag: package-2015-07-01

These settings apply only when `--tag=package-2015-07-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-01'

namespace: azure.mgmt.authorization.v2015_07_01
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2015_07_01
```

### Tag: 2015-06-01-preview

These settings apply only when `--tag=2015-06-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview'

namespace: azure.mgmt.authorization.v2015_06_01
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2015_06_01
```
