## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_hybriddatamanager
  package-version: "0.0.1"
  azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2016-06
```

### Tag: package-2019-06 and ruby

These settings apply only when `--tag=package-2019-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-06' && $(ruby)
namespace: "Azure::HybridDataManager::Mgmt::V2019-06-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybriddatamanager/lib
```

### Tag: package-2016-06 and ruby

These settings apply only when `--tag=package-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-06' && $(ruby)
namespace: "Azure::HybridDataManager::Mgmt::V2016-06-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_hybriddatamanager/lib
```