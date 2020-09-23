## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_traffic_manager
  package-version: "0.16.0"
  azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-11
  - tag: package-2017-03
  - tag: package-2017-05
  - tag: package-2017-09-preview-only
  - tag: package-2018-03
  - tag: package-2018-04
```

### Tag: package-2015-11 and ruby

These settings apply only when `--tag=package-2015-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-11' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2015_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```

### Tag: package-2017-03 and ruby

These settings apply only when `--tag=package-2017-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-03' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2017_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```

### Tag: package-2017-05 and ruby

These settings apply only when `--tag=package-2017-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-05' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2017_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```

### Tag: package-2017-09-preview-only and ruby

These settings apply only when `--tag=package-2017-09-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-09-preview-only' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2017_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```

### Tag: package-2018-03 and ruby

These settings apply only when `--tag=package-2018-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-03' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2018_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```

### Tag: package-2018-04 and ruby

These settings apply only when `--tag=package-2018-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-04' && $(ruby)
namespace: "Azure::TrafficManager::Mgmt::V2018_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_traffic_manager/lib
```
