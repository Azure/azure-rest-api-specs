## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
title: ResourcePrivateLinkClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resource-privatelinks
package-version: 1.0.0b1
no-namespace-folders: true
reformat-next-link: false
combine-operation-files: true
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(python)
namespace: azure.mgmt.resource.privatelinks
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource-privatelinks/azure/mgmt/resource/privatelinks
```