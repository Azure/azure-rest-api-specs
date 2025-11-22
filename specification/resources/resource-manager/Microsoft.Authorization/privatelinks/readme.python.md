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
  - tag: package-privatelinks-2020-05
```

### Tag: package-privatelinks-2020-05 and python

These settings apply only when `--tag=package-privatelinks-2020-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-privatelinks-2020-05'
title: ResourcePrivateLinkClient
namespace: azure.mgmt.resource.privatelinks
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource/azure/mgmt/resource/privatelinks
```