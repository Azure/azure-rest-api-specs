## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-containerservice
package-version: 1.0.0b1
clear-output-folder: true
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
default-api-version: "2023-08-01"
multiapi: true
batch:
  - tag: package-2023-08
  - tag: package-preview-2023-08
  - tag: package-2023-07
  - tag: package-preview-2023-07
  - tag: package-2023-06
  - tag: package-preview-2023-06
  - tag: package-2023-05
  - tag: package-preview-2023-05
  - tag: package-2023-04
  - tag: package-preview-2023-04
  - tag: package-2023-03
  - tag: package-preview-2023-03
  - tag: package-2023-02
  - tag: package-preview-2023-02
  - tag: package-2023-01
  - tag: package-preview-2023-01-only
  - tag: package-2022-11
  - tag: package-preview-2022-11-only
  - tag: package-preview-2022-10-only
  - tag: package-2022-09
  - tag: package-preview-2022-09
  - tag: package-preview-2022-08-03-only
  - tag: package-preview-2022-08-only
  - tag: package-2022-07
  - tag: package-preview-2022-07
  - tag: package-2022-06
  - tag: package-preview-2022-06
  - tag: package-preview-2022-05
  - tag: package-2022-04
  - tag: package-preview-2022-04
  - tag: package-2022-03
  - tag: package-preview-2022-03
  - tag: package-2022-02
  - tag: package-preview-2022-02
  - tag: package-2022-01
  - tag: package-preview-2022-01
  - tag: package-preview-2021-11
  - tag: package-2021-10
  - tag: package-2021-09
  - tag: package-2021-08
  - tag: package-2021-07
  - tag: package-2021-05
  - tag: package-2021-03
  - tag: package-2021-02
  - tag: package-2020-12
  - tag: package-2020-11
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
  - tag: package-2018-08-preview-only
  - tag: package-2018-03-only
  - tag: package-2019-09-preview-only
  - tag: package-2017-07
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/
perform-load: false
clear-output-folder: false
```

### Tag: package-2023-08 and python

These settings apply only when `--tag=package-2023-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-08' && $(python)
namespace: azure.mgmt.containerservice.v2023_08_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_08_01
```

### Tag: package-preview-2023-08 and python

These settings apply only when `--tag=package-preview-2023-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-08' && $(python)
namespace: azure.mgmt.containerservice.v2023_08_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_08_02_preview
```

### Tag: package-2023-07 and python

These settings apply only when `--tag=package-2023-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-07' && $(python)
namespace: azure.mgmt.containerservice.v2023_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_07_01
```

### Tag: package-preview-2023-07 and python

These settings apply only when `--tag=package-preview-2023-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-07' && $(python)
namespace: azure.mgmt.containerservice.v2023_07_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_07_02_preview
```

### Tag: package-2023-06 and python

These settings apply only when `--tag=package-2023-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-06' && $(python)
namespace: azure.mgmt.containerservice.v2023_06_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_06_01
```

### Tag: package-preview-2023-06 and python

These settings apply only when `--tag=package-preview-2023-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-06' && $(python)
namespace: azure.mgmt.containerservice.v2023_06_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_06_02_preview
```

### Tag: package-2023-05 and python

These settings apply only when `--tag=package-2023-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-05' && $(python)
namespace: azure.mgmt.containerservice.v2023_05_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_05_01
```

### Tag: package-preview-2023-05 and python

These settings apply only when `--tag=package-preview-2023-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-05' && $(python)
namespace: azure.mgmt.containerservice.v2023_05_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_05_02_preview
```

### Tag: package-2023-04 and python

These settings apply only when `--tag=package-2023-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-04' && $(python)
namespace: azure.mgmt.containerservice.v2023_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_04_01
```

### Tag: package-preview-2023-04 and python

These settings apply only when `--tag=package-preview-2023-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-04' && $(python)
namespace: azure.mgmt.containerservice.v2023_04_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_04_02_preview
```

### Tag: package-2023-03 and python

These settings apply only when `--tag=package-2023-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-03' && $(python)
namespace: azure.mgmt.containerservice.v2023_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_03_01
```

### Tag: package-preview-2023-03 and python

These settings apply only when `--tag=package-preview-2023-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-03' && $(python)
namespace: azure.mgmt.containerservice.v2023_03_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_03_02_preview
```

### Tag: package-2023-02 and python

These settings apply only when `--tag=package-2023-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-02' && $(python)
namespace: azure.mgmt.containerservice.v2023_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_02_01
```

### Tag: package-preview-2023-02 and python

These settings apply only when `--tag=package-preview-2023-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-02' && $(python)
namespace: azure.mgmt.containerservice.v2023_02_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_02_02_preview
```

### Tag: package-preview-2023-01-only and python

These settings apply only when `--tag=package-preview-2023-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2023-01-only' && $(python)
namespace: azure.mgmt.containerservice.v2023_01_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_01_02_preview
```

### Tag: package-2023-01 and python

These settings apply only when `--tag=package-2023-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-01' && $(python)
namespace: azure.mgmt.containerservice.v2023_01_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2023_01_01
```

### Tag: package-2022-11 and python

These settings apply only when `--tag=package-2022-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-11' && $(python)
namespace: azure.mgmt.containerservice.v2022_11_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_11_01
```

### Tag: package-preview-2022-11-only and python

These settings apply only when `--tag=package-preview-2022-11-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-11-only' && $(python)
namespace: azure.mgmt.containerservice.v2022_11_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_11_02_preview
```

### Tag: package-preview-2022-10-only and python

These settings apply only when `--tag=package-preview-2022-10-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-10-only' && $(python)
namespace: azure.mgmt.containerservice.v2022_10_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_10_02_preview
```

### Tag: package-2022-09 and python

These settings apply only when `--tag=package-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-09' && $(python)
namespace: azure.mgmt.containerservice.v2022_09_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_09_01
```

### Tag: package-preview-2022-09 and python

These settings apply only when `--tag=package-preview-2022-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(python)
namespace: azure.mgmt.containerservice.v2022_09_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_09_02_preview
```

### Tag: package-preview-2022-08-03-only and python

These settings apply only when `--tag=package-preview-2022-08-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-08-03-only' && $(python)
namespace: azure.mgmt.containerservice.v2022_08_03_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_08_03_preview
```

### Tag: package-preview-2022-08-only and python

These settings apply only when `--tag=package-preview-2022-08-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-08-only' && $(python)
namespace: azure.mgmt.containerservice.v2022_08_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_08_02_preview
```

### Tag: package-2022-07 and python

These settings apply only when `--tag=package-2022-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-07' && $(python)
namespace: azure.mgmt.containerservice.v2022_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_07_01
```

### Tag: package-preview-2022-07 and python

These settings apply only when `--tag=package-preview-2022-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-07' && $(python)
namespace: azure.mgmt.containerservice.v2022_07_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_07_02_preview
```

### Tag: package-2022-06 and python

These settings apply only when `--tag=package-2022-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-06' && $(python)
namespace: azure.mgmt.containerservice.v2022_06_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_06_01
```

### Tag: package-preview-2022-06 and python

These settings apply only when `--tag=package-preview-2022-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-06' && $(python)
namespace: azure.mgmt.containerservice.v2022_06_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_06_02_preview
```

### Tag: package-preview-2022-05 and python

These settings apply only when `--tag=package-preview-2022-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(python)
namespace: azure.mgmt.containerservice.v2022_05_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_05_02_preview
```

### Tag: package-2022-04 and python

These settings apply only when `--tag=package-2022-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-04' && $(python)
namespace: azure.mgmt.containerservice.v2022_04_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_04_01
```

### Tag: package-preview-2022-04 and python

These settings apply only when `--tag=package-preview-2022-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-04' && $(python)
namespace: azure.mgmt.containerservice.v2022_04_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_04_02_preview
```

### Tag: package-2022-03 and python

These settings apply only when `--tag=package-2022-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03' && $(python)
namespace: azure.mgmt.containerservice.v2022_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_03_01
```

### Tag: package-preview-2022-03 and python

These settings apply only when `--tag=package-preview-2022-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-03' && $(python)
namespace: azure.mgmt.containerservice.v2022_03_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_03_02_preview
```

### Tag: package-2022-02 and python

These settings apply only when `--tag=package-2022-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-02' && $(python)
namespace: azure.mgmt.containerservice.v2022_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_02_01
```

### Tag: package-preview-2022-02 and python

These settings apply only when `--tag=package-preview-2022-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-02' && $(python)
namespace: azure.mgmt.containerservice.v2022_02_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_02_02_preview
```

### Tag: package-2022-01 and python

These settings apply only when `--tag=package-2022-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-01' && $(python)
namespace: azure.mgmt.containerservice.v2022_01_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_01_01
```

### Tag: package-preview-2022-01 and python

These settings apply only when `--tag=package-preview-2022-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2022-01' && $(python)
namespace: azure.mgmt.containerservice.v2022_01_02_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2022_01_02_preview
```

### Tag: package-preview-2021-11 and python

These settings apply only when `--tag=package-preview-2021-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-preview-2021-11' && $(python)
namespace: azure.mgmt.containerservice.v2021_11_01_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_11_01_preview
```

### Tag: package-2021-10 and python

These settings apply only when `--tag=package-2021-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10' && $(python)
namespace: azure.mgmt.containerservice.v2021_10_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_10_01
```

### Tag: package-2021-09 and python

These settings apply only when `--tag=package-2021-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-09' && $(python)
namespace: azure.mgmt.containerservice.v2021_09_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_09_01
```

### Tag: package-2021-08 and python

These settings apply only when `--tag=package-2021-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-08' && $(python)
namespace: azure.mgmt.containerservice.v2021_08_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_08_01
```

### Tag: package-2021-07 and python

These settings apply only when `--tag=package-2021-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07' && $(python)
namespace: azure.mgmt.containerservice.v2021_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_07_01
```

### Tag: package-2021-05 and python

These settings apply only when `--tag=package-2021-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-05' && $(python)
namespace: azure.mgmt.containerservice.v2021_05_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_05_01
```

### Tag: package-2021-03 and python

These settings apply only when `--tag=package-2021-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03' && $(python)
namespace: azure.mgmt.containerservice.v2021_03_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_03_01
```

### Tag: package-2021-02 and python

These settings apply only when `--tag=package-2021-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02' && $(python)
namespace: azure.mgmt.containerservice.v2021_02_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2021_02_01
```

### Tag: package-2020-12 and python

These settings apply only when `--tag=package-2020-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12' && $(python)
namespace: azure.mgmt.containerservice.v2020_12_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2020_12_01
```

### Tag: package-2020-11 and python

These settings apply only when `--tag=package-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11' && $(python)
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

### Tag: package-2019-09-preview-only and python

These settings apply only when `--tag=package-2019-09-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2019_09_30_preview namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2019-09-preview-only' && $(python)
namespace: azure.mgmt.containerservice.v2019_09_30_preview
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2019_09_30_preview
```

### Tag: package-2017-07 and python

These settings apply only when `--tag=package-2017-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2017_07_01 namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2017-07' && $(python)
namespace: azure.mgmt.containerservice.v2017_07_01
output-folder: $(python-sdks-folder)/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice/v2017_07_01
```

``` yaml $(python)
directive:
  - from: swagger-document
    where: $.definitions.ManagedClusterLoadBalancerProfile.properties.managedOutboundIPs.properties["countIPv6"]
    transform: $["x-ms-client-name"] = "count_ipv6"
```
