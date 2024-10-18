## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-network
no-namespace-folders: true
package-version: 1.0.0b1
combine-operation-files: true
only-path-and-body-params-positional: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2024-03-01"
clear-output-folder: true
batch:
  - tag: package-2024-03
  - tag: package-2024-01
  - tag: package-2023-11
  - tag: package-2023-09
  - tag: package-2023-06
  - tag: package-2023-05
  - tag: package-2023-04
  - tag: package-2023-02
  - tag: package-2021-02
  - tag: package-2021-02-preview-only
  - tag: package-2020-11
  - tag: package-2020-08
  - tag: package-2020-07
  - tag: package-2020-06
  - tag: package-2020-05
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-11
  - tag: package-2019-09
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-12
  - tag: package-2018-11
  - tag: package-2018-04
  - tag: package-2017-10
  - tag: package-2015-06split
  - multiapiscript: true

```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/
perform-load: false
clear-output-folder: false
```

### Tag: package-2024-03 and python

These settings apply only when `--tag=package-2024-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-03'
namespace: azure.mgmt.network.v2024_03_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2024_03_01
```

### Tag: package-2024-01 and python

These settings apply only when `--tag=package-2024-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-01'
namespace: azure.mgmt.network.v2024_01_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2024_01_01
```

### Tag: package-2023-11 and python

These settings apply only when `--tag=package-2023-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-11'
namespace: azure.mgmt.network.v2023_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_11_01
```

### Tag: package-2023-09 and python

These settings apply only when `--tag=package-2023-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-09'
namespace: azure.mgmt.network.v2023_09_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_09_01
```

### Tag: package-2023-06 and python

These settings apply only when `--tag=package-2023-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-06'
namespace: azure.mgmt.network.v2023_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_06_01
```

### Tag: package-2023-05 and python

These settings apply only when `--tag=package-2023-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-05'
namespace: azure.mgmt.network.v2023_05_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_05_01
```

### Tag: package-2023-04 and python

These settings apply only when `--tag=package-2023-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-04'
namespace: azure.mgmt.network.v2023_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_04_01
```

### Tag: package-2023-02 and python

These settings apply only when `--tag=package-2023-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-02'
namespace: azure.mgmt.network.v2023_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2023_02_01
```

### Tag: package-2021-02-preview-only and python

These settings apply only when `--tag=package-2021-02-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02-preview-only'
namespace: azure.mgmt.network.v2021_02_01_preview
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2021_02_01_preview
```


### Tag: package-2021-02 and python

These settings apply only when `--tag=package-2021-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-02'
namespace: azure.mgmt.network.v2021_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2021_02_01
```

### Tag: package-2020-11 and python

These settings apply only when `--tag=package-2020-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-11'
namespace: azure.mgmt.network.v2020_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_11_01
```

### Tag: package-2020-08 and python

These settings apply only when `--tag=package-2020-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-08'
namespace: azure.mgmt.network.v2020_08_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_08_01
```

### Tag: package-2020-07 and python

These settings apply only when `--tag=package-2020-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-07'
namespace: azure.mgmt.network.v2020_07_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_07_01
```

### Tag: package-2020-06 and python

These settings apply only when `--tag=package-2020-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-06'
namespace: azure.mgmt.network.v2020_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_06_01
```

### Tag: package-2020-05 and python

These settings apply only when `--tag=package-2020-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05'
namespace: azure.mgmt.network.v2020_05_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_05_01
```

### Tag: package-2020-04 and python

These settings apply only when `--tag=package-2020-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-04'
namespace: azure.mgmt.network.v2020_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_04_01
```

### Tag: package-2020-03 and python

These settings apply only when `--tag=package-2020-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-03'
namespace: azure.mgmt.network.v2020_03_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2020_03_01
```

### Tag: package-2019-12 and python

These settings apply only when `--tag=package-2019-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12'
namespace: azure.mgmt.network.v2019_12_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_12_01
```

### Tag: package-2019-11 and python

These settings apply only when `--tag=package-2019-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11'
namespace: azure.mgmt.network.v2019_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_11_01
```

### Tag: package-2019-09 and python

These settings apply only when `--tag=package-2019-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-09'
namespace: azure.mgmt.network.v2019_09_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_09_01
```

### Tag: package-2019-08 and python

These settings apply only when `--tag=package-2019-08 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-08'
namespace: azure.mgmt.network.v2019_08_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_08_01
```

### Tag: package-2019-07 and python

These settings apply only when `--tag=package-2019-07 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07'
namespace: azure.mgmt.network.v2019_07_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_07_01
```

### Tag: package-2019-06 and python

These settings apply only when `--tag=package-2019-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-06'
namespace: azure.mgmt.network.v2019_06_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_06_01
```

### Tag: package-2019-04 and python

These settings apply only when `--tag=package-2019-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04'
namespace: azure.mgmt.network.v2019_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_04_01
```

### Tag: package-2019-02 and python

These settings apply only when `--tag=package-2019-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-02'
namespace: azure.mgmt.network.v2019_02_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2019_02_01
```

### Tag: package-2018-12 and python

These settings apply only when `--tag=package-2018-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-12'
namespace: azure.mgmt.network.v2018_12_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_12_01
```

### Tag: package-2018-11 and python

These settings apply only when `--tag=package-2018-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-11'
namespace: azure.mgmt.network.v2018_11_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_11_01
```

### Tag: package-2018-04 and python

These settings apply only when `--tag=package-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-04'
namespace: azure.mgmt.network.v2018_04_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2018_04_01
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10'
namespace: azure.mgmt.network.v2017_10_01
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2017_10_01
```

### Tag: package-2015-06split and python

These settings apply only when `--tag=package-2015-06split --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2015-06split'
namespace: azure.mgmt.network.v2015_06_15
output-folder: $(python-sdks-folder)/network/azure-mgmt-network/azure/mgmt/network/v2015_06_15
```
