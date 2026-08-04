## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
title: FeatureClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-resource-features
package-version: 1.0.0b1
no-namespace-folders: true
reformat-next-link: false
combine-operation-files: true
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true
```

``` yaml $(python)
namespace: azure.mgmt.resource.features
output-folder: $(python-sdks-folder)/resources/azure-mgmt-resource-features/azure/mgmt/resource/features
```
