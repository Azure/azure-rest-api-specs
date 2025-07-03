## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.databoxedge
package-name: azure-mgmt-databoxedge
title: DataBoxEdgeManagementClient
description: The DataBoxEdge Client.
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2019-08-01"
batch:
  - tag: package-2021-02-01-preview
  - tag: package-2019-08
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/
perform-load: false
```

### Tag: package-2021-02-01-preview and python

These settings apply only when `--tag=package-2021-02-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-01-preview' && $(python)
namespace: azure.mgmt.databoxedge.v2021_02_01_preview
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2021_02_01_preview
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08' && $(python)
namespace: azure.mgmt.databoxedge.v2019_08_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_08_01
```
