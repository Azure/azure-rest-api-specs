## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_batch
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-09
  - tag: package-2017-05
  - tag: package-2017-01
  - tag: package-2015-12
```

### Tag: package-2017-09 and ruby

These settings apply only when `--tag=package-2017-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-09' && $(ruby)
namespace: "Azure::Batch::Mgmt::V2017_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_batch/lib
```

### Tag: package-2017-05 and ruby

These settings apply only when `--tag=package-2017-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-05' && $(ruby)
namespace: "Azure::Batch::Mgmt::V2017_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_batch/lib
```

### Tag: package-2017-01 and ruby

These settings apply only when `--tag=package-2017-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-01' && $(ruby)
namespace: "Azure::Batch::Mgmt::V2017_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_batch/lib
```

### Tag: package-2015-12 and ruby

These settings apply only when `--tag=package-2015-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-12' && $(ruby)
namespace: "Azure::Batch::Mgmt::V2015_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_batch/lib
```
