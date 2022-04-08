## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_support
  package-version": "0.16.0"
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-04
  - tag: package-2019-05-preview
```

### Tag: package-2020-04 and ruby

These settings apply only when `--tag=package-2020-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-04' && $(ruby)
namespace: "Azure::Support::Mgmt::V2020_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_support/lib/2020-04-01
```

### Tag: package-2019-05-preview and ruby

These settings apply only when `--tag=package-2019-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-05-preview' && $(ruby)
namespace: "Azure::Support::Mgmt::V2019_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_support/lib/2019-05-01-preview
```
