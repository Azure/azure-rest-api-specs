## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_customer_insights
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2017-01
```

### Tag: package-2017-04 and ruby

These settings apply only when `--tag=package-2017-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04' && $(ruby)
namespace: "Azure::CustomerInsights::Mgmt::V2017_04_26"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_customer_insights/lib
```

### Tag: package-2017-01 and ruby

These settings apply only when `--tag=package-2017-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-01' && $(ruby)
namespace: "Azure::CustomerInsights::Mgmt::V2017_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_customer_insights/lib
```
