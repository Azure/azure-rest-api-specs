## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_maintenance
  package-version: "1.10.0"
  azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-04
  - tag: package-2018-06-preview
```

### Tag: package-2020-04 and ruby

These settings apply only when `--tag=package-2020-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-04' && $(ruby)
namespace: "Azure::Maintenance::Mgmt::V2020_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_maintenance/lib
```

### Tag: package-2018-06-preview and ruby

These settings apply only when `--tag=package-2017-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-06-preview' && $(ruby)
namespace: "Azure::Maintenance::Mgmt::V2018_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_maintenance/lib
```
