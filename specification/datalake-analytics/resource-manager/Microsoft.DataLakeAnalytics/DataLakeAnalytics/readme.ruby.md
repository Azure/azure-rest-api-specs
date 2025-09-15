## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_datalake_analytics
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-11
  - tag: package-2015-10-preview
```

### Tag: package-2016-11 and ruby

These settings apply only when `--tag=package-2016-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-11' && $(ruby)
namespace: "Azure::DataLakeAnalytics::Mgmt::V2016_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_datalake_analytics/lib
```

### Tag: package-2015-10-preview and ruby

These settings apply only when `--tag=package-2015-10-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-10-preview' && $(ruby)
namespace: "Azure::DataLakeAnalytics::Mgmt::V2015_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_datalake_analytics/lib
```
