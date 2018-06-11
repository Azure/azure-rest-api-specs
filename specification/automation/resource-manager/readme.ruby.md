## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_automation
  package-version: "0.16.0"
  azure-arm: true  
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-10
```

### Tag: package-2015-10 and ruby

These settings apply only when `--tag=package-2015-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-10' && $(ruby)
namespace: "Azure::Automation::Mgmt::V2015_10_31"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_automation/lib
```
