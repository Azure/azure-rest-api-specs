## Python

These settings apply only when `--python` is specified on the command line.

```yaml !$(track2)
python:
  python-mode: create
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.kubernetesconfiguration
  package-name: azure-mgmt-kubernetesconfiguration
  package-version: 0.1.2
  clear-output-folder: true
  no-namespace-folders: true
  verbose: true
  debug: true
```

``` yaml $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-kubernetesconfiguration
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-source-control-configurations-2021-03
  - tag: package-source-control-configurations-preview-2020-10
  - tag: package-source-control-configurations-preview-2020-07
  - tag: package-source-control-configurations-preview-2019-11
  - tag: package-extensions-preview-2020-07
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-source-control-configurations-2021-03
  - tag: package-source-control-configurations-preview-2020-10
  - tag: package-source-control-configurations-preview-2020-07
  - tag: package-source-control-configurations-preview-2019-11
  - multiapiscript-source-control-configurations: true
  - tag: package-extensions-preview-2020-07
  - multiapiscript-extensions: true
```

```yaml $(multiapiscript-source-control-configurations)
multiapiscript: true
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations
clear-output-folder: false
perform-load: false
```

```yaml $(multiapiscript-extensions)
multiapiscript: true
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/extensions
clear-output-folder: false
perform-load: false
```

### Tag: package-source-control-configurations-2021-03 and python

These settings apply only when `--tag=package-source-control-configurations-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-source-control-configurations-2021-03'
namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2021_03_01
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2021_03_01
python:
  namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2021_03_01
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2021_03_01
```

### Tag: package-source-control-configurations-preview-2020-10 and python

These settings apply only when `--tag=package-source-control-configurations-preview-2020-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-10'
namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2020_10_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2020_10_01_preview
python:
  namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2020_10_01_preview
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2020_10_01_preview
```

### Tag: package-source-control-configurations-preview-2020-07 and python

These settings apply only when `--tag=package-source-control-configurations-preview-2020-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2020-07'
namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2020_07_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2020_07_01_preview
python:
  namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2020_07_01_preview
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2020_07_01_preview
```

### Tag: package-source-control-configurations-preview-2019-11 and python

These settings apply only when `--tag=package-source-control-configurations-preview-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-source-control-configurations-preview-2019-11'
namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2019_11_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2019_11_01_preview
python:
  namespace: azure.mgmt.kubernetesconfiguration.source_control_configurations.v2019_11_01_preview
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/source_control_configurations/v2019_11_01_preview
```

### Tag: package-extensions-preview-2020-07 and python

These settings apply only when `--tag=package-extensions-preview-2020-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-extensions-preview-2020-07'
namespace: azure.mgmt.kubernetesconfiguration.extensions.v2020_07_01_preview
output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/extensions/v2020_07_01_preview
python:
  namespace: azure.mgmt.kubernetesconfiguration.extensions.v2020_07_01_preview
  output-folder: $(python-sdks-folder)/kubernetesconfiguration/azure-mgmt-kubernetesconfiguration/azure/mgmt/kubernetesconfiguration/extensions/v2020_07_01_preview
```