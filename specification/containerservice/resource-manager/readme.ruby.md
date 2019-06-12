## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_container_service
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-03-only
  - tag: package-2016-09-only
  - tag: package-2017-01-only
```

### Tag: package-2016-03-only and ruby

These settings apply only when `--tag=package-2016-03-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-03-only' && $(ruby)
namespace: "Azure::ContainerService::Mgmt::V2016_03_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_service/lib
title: "ContainerServiceClient"
```

### Tag: package-2016-09-only and ruby

These settings apply only when `--tag=package-2016-09-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-09-only' && $(ruby)
namespace: "Azure::ContainerService::Mgmt::V2016_09_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_service/lib
title: "ContainerServiceClient"
```

### Tag: package-2017-01-only and ruby

These settings apply only when `--tag=package-2017-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-01-only' && $(ruby)
namespace: "Azure::ContainerService::Mgmt::V2017_01_31"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_service/lib
title: "ContainerServiceClient"
```
