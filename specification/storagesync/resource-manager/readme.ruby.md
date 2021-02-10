## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_storagesync_management
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-03-01
  - tag: package-2019-02-01
  - tag: package-2018-10-01
  - tag: package-2018-07-01
  - tag: package-2018-04-02
```

### Tag: package-2020-03-01 and ruby

These settings apply only when `--tag=package-2020-03-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-03-01' && $(ruby)
namespace: "Azure::StorageSync::Mgmt::V2020_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagesync_management/lib
```

### Tag: package-2019-02-01 and ruby

These settings apply only when `--tag=package-2019-02-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-02-01' && $(ruby)
namespace: "Azure::StorageSync::Mgmt::V2019_02_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagesync_management/lib
```

### Tag: package-2018-10-01 and ruby

These settings apply only when `--tag=package-2018-10-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(ruby)
namespace: "Azure::StorageSync::Mgmt::V2018_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagesync_management/lib
```

### Tag: package-2018-07-01 and ruby

These settings apply only when `--tag=package-2018-07-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-07-01' && $(ruby)
namespace: "Azure::StorageSync::Mgmt::V2018_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagesync_management/lib
```

### Tag: package-2018-04-02 and ruby

These settings apply only when `--tag=package-2018-04-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-04-02' && $(ruby)
namespace: "Azure::StorageSync::Mgmt::V2018_04_02"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagesync_management/lib
```
