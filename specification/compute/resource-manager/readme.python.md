## Python

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-compute
no-namespace-folders: true
package-version: 1.0.0b1
combine-operation-files: true
only-path-and-body-params-positional: true
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-python
    where: $ 
    transform: >-
      return $.
        replace(/, 'DummyOrchestrationServiceName'/g,'').
        replace(/dummy_orchestration_service_name = "DummyOrchestrationServiceName"/g,'');
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
multiapi: true
default-api-version: "2024-11-01"
batch:
  - tag: package-2024-11-04-only
  - tag: package-2024-11-01-only
  - tag: package-2024-03-02-only
  - tag: package-2023-10-02-only
  - tag: package-2023-07-03-only
  - tag: package-2023-04-02-only
  - tag: package-2022-09-04-only
  - tag: package-2022-03-02-only
  - tag: package-2022-01-03-only
  - tag: package-2021-10-01-only
  - tag: package-2021-07-01-only
  - tag: package-2020-06-01-only
  - tag: package-2020-05-01-only
  - tag: package-2019-12-01-only
  - tag: package-2019-07-01-only
  - tag: package-2019-04-01-only
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
  - tag: package-compute-2016-03
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/
perform-load: false
```

### Tag: package-2024-11-04-only

These settings apply only when `--tag=package-2024-11-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-11-04-only'
namespace: azure.mgmt.compute.v2024_11_04
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2024_11_04
```

### Tag: package-2024-11-01-only

These settings apply only when `--tag=package-2024-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-11-01-only'
namespace: azure.mgmt.compute.v2024_11_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2024_11_01
```

### Tag: package-2024-03-02-only

These settings apply only when `--tag=package-2024-03-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2024-03-02-only'
namespace: azure.mgmt.compute.v2024_03_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2024_03_02
```


### Tag: package-2023-10-02-only

These settings apply only when `--tag=package-2023-10-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-10-02-only'
namespace: azure.mgmt.compute.v2023_10_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_10_02
```

### Tag: package-2023-07-03-only

These settings apply only when `--tag=package-2023-07-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-07-03-only'
namespace: azure.mgmt.compute.v2023_07_03
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_07_03
```

### Tag: package-2023-04-02-only

These settings apply only when `--tag=package-2023-04-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-04-02-only'
namespace: azure.mgmt.compute.v2023_04_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_04_02
```

### Tag: package-2022-09-04-only

These settings apply only when `--tag=package-2022-09-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-09-04-only'
namespace: azure.mgmt.compute.v2022_09_04
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_09_04
```

### Tag: package-2022-03-02-only

These settings apply only when `--tag=package-2022-03-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03-02-only'
namespace: azure.mgmt.compute.v2022_03_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_03_02
```

### Tag: package-2022-01-03-only

These settings apply only when `--tag=package-2022-01-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-01-03-only'
namespace: azure.mgmt.compute.v2022_01_03
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_01_03
```

### Tag: package-2021-10-01-only

These settings apply only when `--tag=package-2021-10-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10-01-only'
namespace: azure.mgmt.compute.v2021_10_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_10_01
```

### Tag: package-2021-07-01-only

These settings apply only when `--tag=package-2021-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-01-only'
namespace: azure.mgmt.compute.v2021_07_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_07_01
```

### Tag: package-2020-06-01-only and python

These settings apply only when `--tag=package-2020-06-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-06-01-only'
namespace: azure.mgmt.compute.v2020_06_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_06_01
```

### Tag: package-2020-05-01-only and python

These settings apply only when `--tag=package-2020-05-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-05-01-only'
namespace: azure.mgmt.compute.v2020_05_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_05_01
```

### Tag: package-2019-12-01-only and python

These settings apply only when `--tag=package-2019-12-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-12-01-only'
namespace: azure.mgmt.compute.v2019_12_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2019_12_01
```

### Tag: package-2019-07-01-only and python

These settings apply only when `--tag=package-2019-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-07-01-only'
namespace: azure.mgmt.compute.v2019_07_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2019_07_01
```

### Tag: package-2019-04-01-only and python

These settings apply only when `--tag=package-2019-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-04-01-only'
namespace: azure.mgmt.compute.v2019_04_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2019_04_01
```

### Tag: package-compute-only-2017-12 and python

These settings apply only when `--tag=package-compute-only-2017-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12'
namespace: azure.mgmt.compute.v2017_12_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2017_12_01
```

### Tag: package-skus-2017-09 and python

These settings apply only when `--tag=package-skus-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-skus-2017-09'
namespace: azure.mgmt.compute.v2017_09_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2017_09_01
```

### Tag: package-compute-2017-03 and python

These settings apply only when `--tag=package-compute-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2017-03'
namespace: azure.mgmt.compute.v2017_03_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2017_03_30
```

### Tag: package-compute-2016-03 and python

These settings apply only when `--tag=package-compute-2016-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-03'
namespace: azure.mgmt.compute.v2016_03_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2016_03_30
```
