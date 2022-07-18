## Python

These settings apply only when `--python` is specified on the command line.


``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-security
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
multiapi: true
batch:
  - tag: package-2021-07-only
  - tag: package-2021-05-preview-only
  - tag: package-2021-01-only
  - tag: package-2021-01-preview-only
  - tag: package-2020-07-preview-only
  - tag: package-2020-01-only
  - tag: package-2020-01-preview-only
  - tag: package-2019-08-only
  - tag: package-2019-01-only
  - tag: package-2019-01-preview-only
  - tag: package-2018-06-only
  - tag: package-2017-08-only
  - tag: package-2017-08-preview-only
  - tag: package-2015-06-preview-only
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/
perform-load: false
```

### Tag: package-2021-07-only and python

These settings apply only when `--tag=package-2021-07-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-only' && $(python)
namespace: azure.mgmt.security.v2021_07_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_07_01
```

### Tag: package-2021-05-preview-only and python

These settings apply only when `--tag=package-2021-05-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-05-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_05_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_05_01_preview
```

### Tag: package-2021-01-only and python

These settings apply only when `--tag=package-2021-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-only' && $(python)
namespace: azure.mgmt.security.v2021_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_01_01
```

### Tag: package-2021-01-preview-only and python

These settings apply only when `--tag=package-2021-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-01-preview-only' && $(python)
namespace: azure.mgmt.security.v2021_01_15_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2021_01_15_preview
```

### Tag: package-2020-07-preview-only and python

These settings apply only when `--tag=package-2020-07-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07-preview-only' && $(python)
namespace: azure.mgmt.security.v2020_07_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_07_01_preview
```

### Tag: package-2020-01-only and python

These settings apply only when `--tag=package-2020-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-only' && $(python)
namespace: azure.mgmt.security.v2020_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_01_01
```

### Tag: package-2020-01-preview-only and python

These settings apply only when `--tag=package-2020-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-preview-only' && $(python)
namespace: azure.mgmt.security.v2020_01_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2020_01_01_preview
```

### Tag: package-2019-08-only and python

These settings apply only when `--tag=package-2019-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-only' && $(python)
namespace: azure.mgmt.security.v2019_08_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_08_01
```

### Tag: package-2019-01-only and python

These settings apply only when `--tag=package-2019-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-01-only' && $(python)
namespace: azure.mgmt.security.v2019_01_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_01_01
```

### Tag: package-2019-01-preview-only and python

These settings apply only when `--tag=package-2019-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-01-preview-only' && $(python)
namespace: azure.mgmt.security.v2019_01_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2019_01_01_preview
```

### Tag: package-2018-06-only and python

These settings apply only when `--tag=package-2018-06-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-06-only' && $(python)
namespace: azure.mgmt.security.v2018_06_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2018_06_01
```

### Tag: package-2017-08-only and python

These settings apply only when `--tag=package-2017-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08-only' && $(python)
namespace: azure.mgmt.security.v2017_08_01
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2017_08_01
```

### Tag: package-2017-08-preview-only and python

These settings apply only when `--tag=package-2017-08-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-08-preview-only' && $(python)
namespace: azure.mgmt.security.v2017_08_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2017_08_01_preview
```

### Tag: package-2015-06-preview-only and python

These settings apply only when `--tag=package-2015-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06-preview-only' && $(python)
namespace: azure.mgmt.security.v2015_06_01_preview
output-folder: $(python-sdks-folder)/security/azure-mgmt-security/azure/mgmt/security/v2015_06_01_preview
```
