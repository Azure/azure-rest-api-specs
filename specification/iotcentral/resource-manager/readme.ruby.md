## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
ruby:
  package-name: azure_mgmt_iotcentral
  package-version: "0.0.1"
  azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-07-01-privatepreview
```

### Tag: package-2017-07-01-privatepreview and ruby

These settings apply only when `--tag=package-2017-07-01-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-07-01-privatepreview' && $(ruby)
namespace: "Azure::IotCentral::Mgmt::V2017_07_01_privatepreview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_iotcentral/lib
```
