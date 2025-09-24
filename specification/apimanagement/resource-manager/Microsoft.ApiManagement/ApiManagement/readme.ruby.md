## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_api_management
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-01
  - tag: package-2016-10
  - tag: package-2016-07
```

### Tag: package-2018-01 and ruby

These settings apply only when `--tag=package-2018-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01' && $(ruby)
namespace: "Azure::ApiManagement::Mgmt::V2018_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_api_management/lib
```

### Tag: package-2016-10 and ruby

These settings apply only when `--tag=package-2016-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-10' && $(ruby)
namespace: "Azure::ApiManagement::Mgmt::V2016_10_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_api_management/lib
```

### Tag: package-2016-07 and ruby

These settings apply only when `--tag=package-2016-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-07' && $(ruby)
namespace: "Azure::ApiManagement::Mgmt::V2016_07_07"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_api_management/lib
```
