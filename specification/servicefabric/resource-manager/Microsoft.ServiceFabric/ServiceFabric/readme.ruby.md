## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_service_fabric
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-03
  - tag: package-2019-03-preview
  - tag: package-2017-07
  - tag: package-2016-09
```

### Tag: package-2019-03 and ruby

These settings apply only when `--tag=package-2019-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-03' && $(ruby)
namespace: "Azure::ServiceFabric::Mgmt::V2019_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric/lib
```

### Tag: package-2019-03-preview and ruby

These settings apply only when `--tag=package-2019-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-03-preview' && $(ruby)
namespace: "Azure::ServiceFabric::Mgmt::V2019_03_01-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric/lib
```

### Tag: package-2017-07 and ruby

These settings apply only when `--tag=package-2017-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-07' && $(ruby)
namespace: "Azure::ServiceFabric::Mgmt::V2017_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric/lib
```

### Tag: package-2016-09 and ruby

These settings apply only when `--tag=package-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-09' && $(ruby)
namespace: "Azure::ServiceFabric::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_service_fabric/lib
```
