## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resource
package-version: 1.0.0b1
no-namespace-folders: true
reformat-next-link: false
combine-operation-files: true
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

### Python batch

```yaml $(python)
batch:
  - tag: package-managedapplications-2019-07
```

### Tag: package-managedapplications-2019-07 and python

These settings apply only when `--tag=package-managedapplications-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07'
title: ApplicationClient
namespace: azure.mgmt.resource.managedapplications
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/managedapplications
```
