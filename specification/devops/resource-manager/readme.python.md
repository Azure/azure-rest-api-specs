## Python

These settings apply only when `--python` is specified on the command line.

```yaml
package-name: azure_mgmt_devops
package-version: 2020-07-13-preview
azure-arm: true
```

### Python multi-api

``` yaml $(python) && $(multiapi)
batch:
  - tag: package-2020-07-13-preview
  - tag: package-2019-07-01-preview
```

### Tag: package-2020-07-13-preview and python

These settings apply only when `--tag=package-2020-07-13-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2020-07-13-preview' && $(python)
namespace: Azure::DevOps::Mgmt::V2020_07_13_preview
output-folder: $(python-sdks-folder)/management/azure_mgmt_devops/lib
```

### Tag: package-2019-07-01-preview and python

These settings apply only when `--tag=package-2019-07-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2019-07-01-preview' && $(python)
namespace: Azure::DevOps::Mgmt::V2019_07_01_preview
output-folder: $(python-sdks-folder)/management/azure_mgmt_devops/lib
```
