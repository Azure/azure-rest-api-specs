## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 0
  namespace: azure.mgmt.databoxedge
  package-name: azure-mgmt-databoxedge
  title: DataBoxEdgeManagementClient
  description: The DataBoxEdge Client.
  clear-output-folder: true
  no-namespace-folders: true
```
``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.databoxedge
package-name: azure-mgmt-databoxedge
title: DataBoxEdgeManagementClient
description: The DataBoxEdge Client.
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && !$(track2)
batch:
  - tag: package-2021-02-01
  - tag: package-2021-02-01-preview
  - tag: package-2020-12-01
  - tag: package-2020-09-01-preview
  - tag: package-2020-09-01
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03
```
```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-2021-02-01
  - tag: package-2021-02-01-preview
  - tag: package-2020-12-01
  - tag: package-2020-09-01-preview
  - tag: package-2020-09-01
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/
clear-output-folder: false
perform-load: false
```
### Tag: package-2021-02-01 and python

These settings apply only when `--tag=package-2021-02-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-01' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2021_02_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2021_02_01
```
``` yaml $(tag) == 'package-2021-02-01' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2021_02_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2021_02_01
```
### Tag: package-2021-02-01-preview and python

These settings apply only when `--tag=package-2021-02-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-01-preview' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2021_02_01_preview
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2021_02_01_preview
```
``` yaml $(tag) == 'package-2021-02-01-preview' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2021_02_01_preview
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2021_02_01_preview
```

### Tag: package-2020-12-01 and python

These settings apply only when `--tag=package-2020-12-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12-01' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2020_12_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_12_01
```
``` yaml $(tag) == 'package-2020-12-01' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2020_12_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/datab
```

### Tag: package-2020-09-01-preview and python

These settings apply only when `--tag=package-2020-09-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-09-01' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2020_09_01_preview
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_09_01_preview
```
``` yaml $(tag) == 'package-2020-09-01-preview' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2020_09_01_preview
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_09_01_preview
```

### Tag: package-2020-09-01 and python

These settings apply only when `--tag=package-2020-09-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-09-01' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2020_09_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_09_01
```
``` yaml $(tag) == 'package-2020-09-01' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2020_09_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_09_01
```

### Tag: package-2020-05-preview and python

These settings apply only when `--tag=package-2020-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05-preview' && $(python) & !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2020_05_01_preview
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_05_01_preview
```
``` yaml $(tag) == 'package-2020-05-preview' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2020_05_01_preview
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2020_05_01_preview
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2019_08_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_08_01
```
``` yaml $(tag) == 'package-2019-08' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2019_08_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_08_01
```

### Tag: package-2019-07 and python

These settings apply only when `--tag=package-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2019_07_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_07_01
```
``` yaml $(tag) == 'package-2019-07' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2019_07_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_07_01
```

### Tag: package-2019-03 and python

These settings apply only when `--tag=package-2019-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.databoxedge.v2019_03_01
  output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_03_01
```
``` yaml $(tag) == 'package-2019-03' && $(python) && $(track2)
namespace: azure.mgmt.databoxedge.v2019_03_01
output-folder: $(python-sdks-folder)/databoxedge/azure-mgmt-databoxedge/azure/mgmt/databoxedge/v2019_03_01
```
