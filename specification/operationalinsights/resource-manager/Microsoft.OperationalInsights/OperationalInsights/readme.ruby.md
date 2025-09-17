## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_operational_insights
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-11-preview
  - tag: package-2015-03
```

### Tag: package-2015-11-preview and ruby

These settings apply only when `--tag=package-2015-11-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-11-preview' && $(ruby)
namespace: "Azure::OperationalInsights::Mgmt::V2015_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_operational_insights/lib
```

### Tag: package-2015-03 and ruby

These settings apply only when `--tag=package-2015-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-03' && $(ruby)
namespace: "Azure::OperationalInsights::Mgmt::V2015_03_20"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_operational_insights/lib
```
