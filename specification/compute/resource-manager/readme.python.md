## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-compute
no-namespace-folders: true
package-version: 1.0.0b1
combine-operation-files: true
only-path-and-body-params-positional: true
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
default-api-version: "2023-09-01"
clear-output-folder: true
batch:
  - tag: package-2023-10-02-only
  - tag: package-2023-09-01-only
  - tag: package-2023-07-01-only
  - tag: package-2023-04-02-only
  - tag: package-2023-03-01-only
  - tag: package-2023-01-02-only
  - tag: package-2022-11-01-only
  - tag: package-2022-09-04-only
  - tag: package-2022-08-03-only
  - tag: package-2022-08-01-only
  - tag: package-2022-07-02-only
  - tag: package-2022-04-04-only
  - tag: package-2022-03-03-only
  - tag: package-2022-03-02-only
  - tag: package-2022-03-01-only
  - tag: package-2022-01-03-only
  - tag: package-2021-12-01-only
  - tag: package-2021-11-01-only
  - tag: package-2021-10-01-only
  - tag: package-2021-08-01-only
  - tag: package-2021-07-01-only
  - tag: package-2021-04-01-only
  - tag: package-2021-03-01-only
  - tag: package-2020-12-01-only
  - tag: package-2020-10-01-preview-only
  - tag: package-2020-09-30-only
  - tag: package-2020-06-30-only
  - tag: package-2020-06-01-only
  - tag: package-2020-05-01-only
  - tag: package-2019-12-01-only
  - tag: package-2019-11-01-only
  - tag: package-2019-07-01-only
  - tag: package-2019-04-01-only
  - tag: package-2019-03-01-only
  - tag: package-2018-10-01-only
  - tag: package-2018-09-30-only
  - tag: package-compute-only-2018-06
  - tag: package-compute-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-compute-2015-06
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/
perform-load: false
clear-output-folder: false
```

### Tag: package-2023-10-02-only

These settings apply only when `--tag=package-2023-10-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-10-02-only'
namespace: azure.mgmt.compute.v2023_10_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_10_02
```

### Tag: package-2023-09-01-only

These settings apply only when `--tag=package-2023-09-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-09-01-only'
namespace: azure.mgmt.compute.v2023_09_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_09_01
```

### Tag: package-2023-07-01-only

These settings apply only when `--tag=package-2023-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-07-01-only'
namespace: azure.mgmt.compute.v2023_07_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_07_01
```

### Tag: package-2023-04-02-only

These settings apply only when `--tag=package-2023-04-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-04-02-only'
namespace: azure.mgmt.compute.v2023_04_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_04_02
```

### Tag: package-2023-03-01-only

These settings apply only when `--tag=package-2023-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-03-01-only'
namespace: azure.mgmt.compute.v2023_03_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_03_01
```

### Tag: package-2023-01-02-only

These settings apply only when `--tag=package-2023-01-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2023-01-02-only'
namespace: azure.mgmt.compute.v2023_01_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2023_01_02
```

### Tag: package-2022-11-01-only

These settings apply only when `--tag=package-2022-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-11-01-only'
namespace: azure.mgmt.compute.v2022_11_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_11_01
```

### Tag: package-2022-09-04-only

These settings apply only when `--tag=package-2022-09-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-09-04-only'
namespace: azure.mgmt.compute.v2022_09_04
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_09_04
```

### Tag: package-2022-08-03-only

These settings apply only when `--tag=package-2022-08-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-08-03-only'
namespace: azure.mgmt.compute.v2022_08_03
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_08_03
```

### Tag: package-2022-08-01-only

These settings apply only when `--tag=package-2022-08-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-08-01-only'
namespace: azure.mgmt.compute.v2022_08_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_08_01
```

### Tag: package-2022-07-02-only

These settings apply only when `--tag=package-2022-07-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-07-02-only'
namespace: azure.mgmt.compute.v2022_07_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_07_02
```

### Tag: package-2022-04-04-only

These settings apply only when `--tag=package-2022-04-04-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-04-04-only'
namespace: azure.mgmt.compute.v2022_04_04
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_04_04
```

### Tag: package-2022-03-03-only

These settings apply only when `--tag=package-2022-03-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03-03-only'
namespace: azure.mgmt.compute.v2022_03_03
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_03_03
```

### Tag: package-2022-03-02-only

These settings apply only when `--tag=package-2022-03-02-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03-02-only'
namespace: azure.mgmt.compute.v2022_03_02
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_03_02
```

### Tag: package-2022-03-01-only

These settings apply only when `--tag=package-2022-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-03-01-only'
namespace: azure.mgmt.compute.v2022_03_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_03_01
```

### Tag: package-2022-01-03-only

These settings apply only when `--tag=package-2022-01-03-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2022-01-03-only'
namespace: azure.mgmt.compute.v2022_01_03
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2022_01_03
```

### Tag: package-2021-12-01-only

These settings apply only when `--tag=package-2021-12-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-12-01-only'
namespace: azure.mgmt.compute.v2021_12_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_12_01
```

### Tag: package-2021-11-01-only

These settings apply only when `--tag=package-2021-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-11-01-only'
namespace: azure.mgmt.compute.v2021_11_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_11_01
```

### Tag: package-2021-10-01-only

These settings apply only when `--tag=package-2021-10-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-10-01-only'
namespace: azure.mgmt.compute.v2021_10_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_10_01
```

### Tag: package-2021-08-01-only

These settings apply only when `--tag=package-2021-08-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-08-01-only'
namespace: azure.mgmt.compute.v2021_08_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_08_01
```

### Tag: package-2021-07-01-only

These settings apply only when `--tag=package-2021-07-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-07-01-only'
namespace: azure.mgmt.compute.v2021_07_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_07_01
```


### Tag: package-2021-04-01-only

These settings apply only when `--tag=package-2021-04-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-04-01-only'
namespace: azure.mgmt.compute.v2021_04_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_04_01
```

### Tag: package-2021-03-01-only

These settings apply only when `--tag=package-2021-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2021-03-01-only'
namespace: azure.mgmt.compute.v2021_03_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2021_03_01
```

### Tag: package-2020-12-01-only and python

These settings apply only when `--tag=package-2020-12-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-12-01-only'
namespace: azure.mgmt.compute.v2020_12_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_12_01
python:
  namespace: azure.mgmt.compute.v2020_12_01
  output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_12_01
```

### Tag: package-2020-10-01-preview-only and python

These settings apply only when `--tag=package-2020-10-01-preview-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-10-01-preview-only'
namespace: azure.mgmt.compute.v2020_10_01_preview
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_10_01_preview
```

### Tag: package-2020-09-30-only and python

These settings apply only when `--tag=package-2020-09-30-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-09-30-only'
namespace: azure.mgmt.compute.v2020_09_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_09_30
```

### Tag: package-2020-06-30-only and python

These settings apply only when `--tag=package-2020-06-30-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2020-06-30-only'
namespace: azure.mgmt.compute.v2020_06_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2020_06_30
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

### Tag: package-2019-11-01-only and python

These settings apply only when `--tag=package-2019-11-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-11-01-only'
namespace: azure.mgmt.compute.v2019_11_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2019_11_01
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

### Tag: package-2019-03-01-only and python

These settings apply only when `--tag=package-2019-03-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2019-03-01-only'
namespace: azure.mgmt.compute.v2019_03_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2019_03_01
```

### Tag: package-2018-10-01-only and python

These settings apply only when `--tag=package-2018-10-01-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-10-01-only'
namespace: azure.mgmt.compute.v2018_10_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2018_10_01
```

### Tag: package-2018-09-30-only and python

These settings apply only when `--tag=package-2018-09-30-only --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2018-09-30-only'
namespace: azure.mgmt.compute.v2018_09_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2018_09_30
```

### Tag: package-compute-only-2018-06 and python

These settings apply only when `--tag=package-compute-only-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-only-2018-06'
namespace: azure.mgmt.compute.v2018_06_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2018_06_01
```

### Tag: package-compute-2018-04 and python

These settings apply only when `--tag=package-compute-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2018-04'
namespace: azure.mgmt.compute.v2018_04_01
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2018_04_01
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

### Tag: package-compute-2016-04-preview and python

These settings apply only when `--tag=package-compute-2016-04-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-04-preview'
namespace: azure.mgmt.compute.v2016_04_30_preview
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2016_04_30_preview
```

### Tag: package-compute-2016-03 and python

These settings apply only when `--tag=package-compute-2016-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-03'
namespace: azure.mgmt.compute.v2016_03_30
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2016_03_30
```

### Tag: package-compute-2015-06 and python

These settings apply only when `--tag=package-compute-2015-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2015-06'
namespace: azure.mgmt.compute.v2015_06_15
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute/v2015_06_15
```
