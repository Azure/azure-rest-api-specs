## Python

These settings apply only when `--python` is specified on the command line.


```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerregistry
clear-output-folder: true
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-2021-08-preview-only
  - tag: package-2021-06-preview-only
  - tag: package-2020-11-preview-only
  - tag: package-2019-12-preview-only
  - tag: package-2019-06-preview-only
  - tag: package-2019-05-only
  - tag: package-2019-05-preview-only
  - tag: package-2019-04-only
  - tag: package-2018-09-only
  - tag: package-2018-02-preview-only
  - tag: package-2017-10
  - tag: package-2017-03
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-08-preview-only and python

These settings apply only when `--tag=package-2021-08-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-08-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2021_08_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2021_08_01_preview
```

### Tag: package-2021-06-preview-only and python

These settings apply only when `--tag=package-2021-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-06-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2021_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2021_06_01_preview
```

### Tag: package-2021-06-preview and python

These settings apply only when `--tag=package-2021-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2021_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2021_06_01_preview
```

### Tag: package-2020-11-preview-only and python

These settings apply only when `--tag=package-2020-11-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2020_11_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2020_11_01_preview
```

### Tag: package-2020-11-preview and python

These settings apply only when `--tag=package-2020-11-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2020_11_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2020_11_01_preview
```

### Tag: package-2019-12-preview-only and python

These settings apply only when `--tag=package-2019-12-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_12_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_12_01_preview
```

### Tag: package-2019-12-preview and python

These settings apply only when `--tag=package-2019-12-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2019_12_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_12_01_preview
```

### Tag: package-2019-06-preview-only and python

These settings apply only when `--tag=package-2019-06-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_06_01_preview
```

### Tag: package-2019-06-preview and python

These settings apply only when `--tag=package-2019-06-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2019_06_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_06_01_preview
```

### Tag: package-2019-05-only and python

These settings apply only when `--tag=package-2019-05-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01
```

### Tag: package-2019-05 and python

These settings apply only when `--tag=package-2019-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01
```

### Tag: package-2019-05-preview-only and python

These settings apply only when `--tag=package-2019-05-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01_preview
```

### Tag: package-2019-05-preview and python

These settings apply only when `--tag=package-2019-05-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-05-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2019_05_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_05_01_preview
```

### Tag: package-2019-04-only and python

These settings apply only when `--tag=package-2019-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-only' && $(python)
namespace: azure.mgmt.containerregistry.v2019_04_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_04_01
```

### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04' && $(python)
namespace: azure.mgmt.containerregistry.v2019_04_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2019_04_01
```

### Tag: package-2018-09-only and python

These settings apply only when `--tag=package-2018-09-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-only' && $(python)
namespace: azure.mgmt.containerregistry.v2018_09_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_09_01
```

### Tag: package-2018-09 and python

These settings apply only when `--tag=package-2018-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09' && $(python)
namespace: azure.mgmt.containerregistry.v2018_09_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_09_01
```

### Tag: package-2018-02-preview-only and python

These settings apply only when `--tag=package-2018-02-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02-preview-only' && $(python)
namespace: azure.mgmt.containerregistry.v2018_02_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_02_01_preview
```

### Tag: package-2018-02-preview and python

These settings apply only when `--tag=package-2018-02-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(python)
namespace: azure.mgmt.containerregistry.v2018_02_01_preview
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2018_02_01_preview
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10' && $(python)
namespace: azure.mgmt.containerregistry.v2017_10_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_10_01
```

### Tag: package-2017-03 and python

These settings apply only when `--tag=package-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03' && $(python)
namespace: azure.mgmt.containerregistry.v2017_03_01
output-folder: $(python-sdks-folder)/containerregistry/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_03_01
```


``` yaml $(python) && $(track2)
directive:
  - from: swagger-document
    where: $.definitions.BuildStepProperties
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.BuildStepPropertiesUpdateParameters
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.QueueBuildRequest
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.RunRequest
    transform: >
        $['required'] = ['type'];
  - from: swagger-document
    where: $.definitions.TaskStepProperties
    transform: >
        $['required'] = ['type']; 
  - from: swagger-document
    where: $.definitions.TaskStepUpdateParameters
    transform: >
        $['required'] = ['type'];
```