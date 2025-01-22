## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-web
package-version: 0.42.0
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2024-04-01"
clear-output-folder: true
batch:
  - tag: package-2024-04
  - tag: package-2023-01
  - tag: package-2022-09
  - tag: package-2018-02-only
  - tag: package-2016-03-only
  - multiapiscript: true
```

```yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/
perform-load: false
```

### Tag: package-2024-04 and python

These settings apply only when `--tag=package-2024-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-04' && $(python)
namespace: azure.mgmt.web.v2024_04_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2024_04_01
```

### Tag: package-2023-01 and python

These settings apply only when `--tag=package-2023-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2023-01' && $(python)
namespace: azure.mgmt.web.v2023_01_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2023_01_01
```

### Tag: package-2022-09 and python

These settings apply only when `--tag=package-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2022-09' && $(python)
namespace: azure.mgmt.web.v2022_09_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2022_09_01
```

### Tag: package-2018-02-only and python

These settings apply only when `--tag=package-2018-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2018-02-only' && $(python)
namespace: azure.mgmt.web.v2018_02_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2018_02_01
```

### Tag: package-2016-03-only and python

These settings apply only when `--tag=package-2016-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2016-03-only' && $(python)
namespace: azure.mgmt.web.v2016_03_01
output-folder: $(python-sdks-folder)/appservice/azure-mgmt-web/azure/mgmt/web/v2016_03_01
```

