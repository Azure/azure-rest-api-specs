## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_billing
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-10
  - tag: package-2020-05
  - tag: package-2017-04-preview
  - tag: package-2017-02-preview
```

### Tag: package-2020-10 and ruby

These settings apply only when `--tag=package-2020-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-10' && $(ruby)
namespace: "Azure::Billing::Mgmt::V2020_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_billing/lib
```

### Tag: package-2020-05 and ruby

These settings apply only when `--tag=package-2020-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-05' && $(ruby)
namespace: "Azure::Billing::Mgmt::V2020_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_billing/lib
```

### Tag: package-2017-04-preview and ruby

These settings apply only when `--tag=package-2017-04-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(ruby)
namespace: "Azure::Billing::Mgmt::V2017_04_24_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_billing/lib
```

### Tag: package-2017-02-preview and ruby

These settings apply only when `--tag=package-2017-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-02-preview' && $(ruby)
namespace: "Azure::Billing::Mgmt::V2017_02_27_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_billing/lib
```
