## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_compute
package-version: "0.17.1"
azure-arm: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: ComputeRP/virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-ruby
    where: $ 
    transform: >-
      return $.
        replace(/, 'DummyOrchestrationServiceName'/g,'').
        replace(/DummyOrchestrationServiceName = "DummyOrchestrationServiceName"/g,'');
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-compute-2019-12
  - tag: package-disks-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-compute-2015-06
```

### Tag: package-compute-2019-12 and ruby

These settings apply only when `--tag=package-compute-2019-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-2019-12' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2019_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-disks-2018-04 and ruby

These settings apply only when `--tag=package-disks-2018-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-disks-2018-04' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2018_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-compute-only-2017-12 and ruby

These settings apply only when `--tag=package-compute-only-2017-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2017_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-skus-2017-09 and ruby

These settings apply only when `--tag=package-skus-2017-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2017_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-compute-2017-03 and ruby

These settings apply only when `--tag=package-compute-2017-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2017_03_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-compute-2016-04-preview and ruby

These settings apply only when `--tag=package-compute-2016-04-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-2016-04-preview' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2016_04_30_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-compute-2016-03 and ruby

These settings apply only when `--tag=package-compute-2016-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-2016-03' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2016_03_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```

### Tag: package-compute-2015-06 and ruby

These settings apply only when `--tag=package-compute-2015-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-compute-2015-06' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2015_06_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_compute/lib
```
