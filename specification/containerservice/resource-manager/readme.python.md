## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservice
package-verion: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi) && $(track2)
batch:
  - tag: package-2021-08-01-only
  - tag: package-2021-07-01-only
  - tag: package-2021-05-01-only
  - tag: package-2021-03-01-only
  - tag: package-2021-02-01-only
  - tag: package-2020-12-01-only
  - tag: package-2020-11-01-only
  - tag: package-2020-09-01-only
  - tag: package-2020-07-01-only
  - tag: package-2020-06-01-only
  - tag: package-2020-04-01-only
  - tag: package-2020-03-01-only
  - tag: package-2020-02-01-only
  - tag: package-2020-01-01-only
  - tag: package-2019-11-01-only
  - tag: package-2019-10-27-preview-only
  - tag: package-2019-10-01-only
  - tag: package-2019-08-01-only
  - tag: package-2019-06-01-only
  - tag: package-2019-04-30-only
  - tag: package-2019-04-01-only
  - tag: package-2019-02-only
  - tag: package-2018-09-preview-only
  - tag: package-2019-09-preview-only
  - tag: package-2018-08-preview-only
  - tag: package-2018-03-only
  - tag: package-2017-07-only-extended
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/
clear-output-folder: false
perform-load: false
```

### Tag: package-2021-08-01-only and python

These settings apply only when `--tag=package-2021-08-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-08-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2021_08_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_08_01
```

### Tag: package-2021-07-01-only and python

These settings apply only when `--tag=package-2021-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2021_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_07_01
```

### Tag: package-2021-05-01-only and python

These settings apply only when `--tag=package-2021-05-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-05-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2021_05_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_05_01
```

### Tag: package-2021-03-01-only and python

These settings apply only when `--tag=package-2021-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2021_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_03_01
```

### Tag: package-2021-02-01-only and python

These settings apply only when `--tag=package-2021-02-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2021_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_02_01
```

### Tag: package-2020-12-01-only and python

These settings apply only when `--tag=package-2020-12-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_12_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_12_01
```

### Tag: package-2020-11-01-only and python

These settings apply only when `--tag=package-2020-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_11_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_11_01
```

### Tag: package-2020-09-01-only and python

These settings apply only when `--tag=package-2020-09-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-09-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_09_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_09_01
```

### Tag: package-2020-07-01-only and python

These settings apply only when `--tag=package-2020-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_07_01
```

### Tag: package-2020-06-01-only and python

These settings apply only when `--tag=package-2020-06-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-06-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_06_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_06_01
```

### Tag: package-2020-04-01-only and python

These settings apply only when `--tag=package-2020-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_04_01
```

### Tag: package-2020-03-01-only and python

These settings apply only when `--tag=package-2020-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_03_01
```

### Tag: package-2020-02-01-only and python

These settings apply only when `--tag=package-2020-02-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-02-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_02_01
```

### Tag: package-2020-01-01-only and python

These settings apply only when `--tag=package-2020-01-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-01-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2020_01_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_01_01
```

### Tag: package-2019-11-01-only and python

These settings apply only when `--tag=package-2019-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_11_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_11_01
```

### Tag: package-2019-10-27-preview-only and python

These settings apply only when `--tag=package-2019-10-27-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-10-27-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_10_27_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_10_27_preview
```

### Tag: package-2019-10-01-only and python

These settings apply only when `--tag=package-2019-10-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-10-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_10_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_10_01
```

### Tag: package-2019-08-01-only and python

These settings apply only when `--tag=package-2019-08-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_08_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_08_01
```

### Tag: package-2019-06-01-only and python

These settings apply only when `--tag=package-2019-06-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_06_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_06_01
```

### Tag: package-2019-04-30-only and python

These settings apply only when `--tag=package-2019-04-30-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-30-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_04_30
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_04_30
```

### Tag: package-2019-04-01-only and python

These settings apply only when `--tag=package-2019-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_04_01
```

### Tag: package-2019-02-only and python

These settings apply only when `--tag=package-2019-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-02-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_02_01
```

### Tag: package-2018-09-preview-only and python

These settings apply only when `--tag=package-2018-09-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2018_09_30_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2018_09_30_preview
```

### Tag: package-2018-08-preview-only and python

These settings apply only when `--tag=package-2018-08-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-08-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2018_08_01_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2018_08_01_preview
```

### Tag: package-2018-03-only and python

These settings apply only when `--tag=package-2018-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-03-only' && $(python)
namespace: azure.mgmt.containerservice.v2018_03_31
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2018_03_31
```

### Tag: package-2017-07-only-extended and python

These settings apply only when `--tag=package-2017-07-only-extended --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-07-only-extended' && $(python)
namespace: azure.mgmt.containerservice.v2017_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2017_07_01
```

### Tag: package-2019-09-preview-only and python

These settings apply only when `--tag=package-2019-09-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_09_30_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_09_30_preview
```
