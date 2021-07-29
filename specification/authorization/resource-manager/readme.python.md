## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-authorization
no-namespace-folders: true
package-version: 1.0.0b1
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch:
  - tag: package-2021-07-01-preview-only
  - tag: package-2021-03-01-preview-only
  - tag: package-2021-01-01-preview-only
  - tag: package-2020-04-01-preview-only
  - tag: package-2020-10-01-preview
  - tag: package-2018-09-01-preview-only
  - tag: package-2018-07-01-preview-only
  - tag: package-2018-05-01-preview
  - tag: package-2018-01-01-preview-only
  - tag: package-2015-07-01
  - tag: package-2015-06-01-preview
  - multiapiscript: true
```
``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-07-01-preview-only and python

These settings apply only when `--tag=package-2021-07-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-01-preview-only' && $(python)
python:
  namespace: azure.mgmt.authorization.v2021_07_01_preview
  output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2021_07_01_preview
```

### Tag: package-2021-03-01-preview-only and python

These settings apply only when `--tag=package-2021-03-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2021_03_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2021_03_01_preview
```

### Tag: package-2020-04-01-preview-only and python

These settings apply only when `--tag=package-2020-04-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2020_04_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2020_04_01_preview
```

### Tag: package-2018-09-01-preview-only and python

These settings apply only when `--tag=package-2018-09-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2018_09_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_09_01_preview
```

### Tag: package-2018-07-01-preview-only and python

These settings apply only when `--tag=package-2018-07-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-07-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2018_07_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_07_01_preview
```

### Tag: package-2018-05-01-preview and python

These settings apply only when `--tag=package-2018-05-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-01-preview' && $(python)
namespace: azure.mgmt.authorization.v2018_05_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_05_01_preview
```

### Tag: package-2018-01-01-preview-only and python

These settings apply only when `--tag=package-2018-01-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2018_01_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2018_01_01_preview
```

### Tag: package-2015-07-01 and python

These settings apply only when `--tag=package-2015-07-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-01' && $(python)
namespace: azure.mgmt.authorization.v2015_07_01
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2015_07_01
```

### Tag: 2015-06-01-preview and python

These settings apply only when `--tag=2015-06-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview' && $(python)
namespace: azure.mgmt.authorization.v2015_06_01
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2015_06_01
```

### Tag: package-2021-01-01-preview-only and python

These settings apply only when `--tag=package-2021-01-01-preview-only --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-01-preview-only' && $(python)
namespace: azure.mgmt.authorization.v2021_01_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2021_01_01_preview
```
### Tag: package-2020-10-01-preview and python

These settings apply only when `--tag=package-2020-10-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01-preview' && $(python)
namespace: azure.mgmt.authorization.v2020_10_01_preview
output-folder: $(python-sdks-folder)/authorization/azure-mgmt-authorization/azure/mgmt/authorization/v2020_10_01_preview
```