## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.kubernetesconfiguration
package-name: azure-mgmt-kubernetesconfiguration
no-namespace-folders: true
package-version: 1.1.0
clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi)
clear-output-folder: true
batch: 
  - tag: package-preview-2021-11
  - tag: package-2021-09
  - tag: package-preview-2021-05
  - tag: package-2021-03
  - tag: package-preview-2020-10
  - tag: package-2020-07-01-preview
  - tag: package-2019-11-01-preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/
clear-output-folder: false
perform-load: false
```

### Tag: package-preview-2021-11 and python

These settings apply only when `--tag=package-preview-2021-11 --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
namespace: azure.mgmt.kubernetesconfiguration.v2021_11_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2021_11_01_preview
```

### Tag: package-2021-09 and python

These settings apply only when `--tag=package-2021-09 --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
namespace: azure.mgmt.kubernetesconfiguration.v2021_09_01
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2021_09_01
```

### Tag: package-preview-2021-05 and python

These settings apply only when `--tag=package-preview-2021-05 --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-05'
namespace: azure.mgmt.kubernetesconfiguration.v2021_05_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2021_05_01_preview
```

### Tag: package-2021-03 and python

These settings apply only when `--tag=package-2021-03 --python` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
namespace: azure.mgmt.kubernetesconfiguration.v2021_03_01
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2021_03_01
```

### Tag: package-preview-2020-10 and python

These settings apply only when `--tag=package-preview-2020-10 --python` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-10'
namespace: azure.mgmt.kubernetesconfiguration.v2020_10_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2020_10_01_preview
```

### Tag: package-2020-07-01-preview and python

These settings apply only when `--tag=package-2020-07-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-preview'
namespace: azure.mgmt.kubernetesconfiguration.v2020_07_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2020_07_01_preview
```

### Tag: package-2019-11-01-preview  and python

These settings apply only when `--tag=package-2019-11-01-preview  --python` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01-preview '
namespace: azure.mgmt.kubernetesconfiguration.v2019_11_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/v2019_11_01_preview
```