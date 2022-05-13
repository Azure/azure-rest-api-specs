## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.edgeorder
package-name: azure-mgmt-edgeorder
package-version: 1.0.0b1
title: EdgeOrderManagementClient
description: The EdgeOrder Client.
clear-output-folder: true
no-namespace-folders: true
```
### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && $(python)
batch:
  - tag: package-2020-12-preview
  - tag: package-2021-12
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/edgeorder/azure-mgmt-edgeorder/azure/mgmt/edgeorder/
perform-load: false
```
### Tag: package-2020-12-preview and python

These settings apply only when `--tag=package-2020-12-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12-preview' && $(python)
namespace: azure.mgmt.edgeorder.v2020_12_01_preview
output-folder: $(python-sdks-folder)/edgeorder/azure-mgmt-edgeorder/azure/mgmt/edgeorder/v2020_12_01_preview
```

### Tag: package-2021-12 and python

These settings apply only when `--tag=package-2021-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-12' && $(python)
namespace: azure.mgmt.edgeorder.v2021_12_01
output-folder: $(python-sdks-folder)/edgeorder/azure-mgmt-edgeorder/azure/mgmt/edgeorder/v2021_12_01
```