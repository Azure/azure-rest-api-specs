## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-compute
no-namespace-folders: true
package-version: 1.0.0b1
modelerfour:
  lenient-model-deduplication: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: compute.json
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

```yaml $(multiapi)
clear-output-folder: true
batch:
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
clear-output-folder: false
perform-load: false
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
