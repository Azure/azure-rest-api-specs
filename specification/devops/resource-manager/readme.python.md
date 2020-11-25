## Python

These settings apply only when `--python` is specified on the command line.

```yaml
package-name: azure-mgmt-devops
package-version: 2020-07-13-preview
namespace: azure.mgmt.devops
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
output-folder: $(python-sdks-folder)/devops/azure-mgmt-devops/azure/mgmt/devops
```

### Tag: package-2019-07-01-preview and python

These settings apply only when `--tag=package-2019-07-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml $(tag) == 'package-2019-07-01-preview' && $(python)
namespace: azure.mgmt.devops
output-folder: $(python-sdks-folder)//devops/azure-mgmt-devops/azure/mgmt/devops
```
