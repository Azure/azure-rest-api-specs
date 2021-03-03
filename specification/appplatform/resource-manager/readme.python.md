## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && !$(track2)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-appplatform
  clear-output-folder: true
  no-namespace-folders: true
```
``` yaml $(python) && $(track2)
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-appplatform
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && !$(track2)
batch:
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - tag: package-2019-05-01-preview
```

```yaml $(python) && $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - tag: package-2019-05-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/
clear-output-folder: false
perform-load: false
```

### Tag: package-preview-2020-11 and python

These settings apply only when `--tag=package-preview-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2020-11' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.appplatform.v2020_11_01_preview
  output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_11_01_preview
```
``` yaml $(tag) == 'package-preview-2020-11' && $(python) && $(track2)
namespace: azure.mgmt.appplatform.v2020_11_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_11_01_preview
```

### Tag: package-2020-07 and python

These settings apply only when `--tag=package-2020-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.appplatform.v2020_07_01
  output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_07_01
```
``` yaml $(tag) == 'package-2020-07' && $(python) && $(track2)
namespace: azure.mgmt.appplatform.v2020_07_01
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2020_07_01
```

### Tag: package-2019-05-01-preview and python

These settings apply only when `--tag=package-2019-05-01-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-01-preview' && $(python) && !$(track2)
python:
  namespace: azure.mgmt.appplatform.v2019_05_01_preview
  output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2019_05_01_preview
```

``` yaml $(tag) == 'package-2019-05-01-preview' && $(python) && $(track2)
namespace: azure.mgmt.appplatform.v2019_05_01_preview
output-folder: $(python-sdks-folder)/appplatform/azure-mgmt-appplatform/azure/mgmt/appplatform/v2019_05_01_preview
```
