## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
package-name: azure_mgmt_databox
package-version: "0.0.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2019-09
  - tag: package-2020-04
  - tag: package-2020-11
```

### Tag: package-2018-01 and ruby

These settings apply only when `--tag=package-2018-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2018_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databox/lib
```

### Tag: package-2019-09 and ruby

These settings apply only when `--tag=package-2019-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-09' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2019_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databox/lib
```

### Tag: package-2020-04 and ruby

These settings apply only when `--tag=package-2020-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-04' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2020_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databox/lib
```

### Tag: package-2020-11 and ruby

These settings apply only when `--tag=package-2020-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-11' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2020_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_databox/lib
```