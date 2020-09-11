## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_stream_analytics
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-pure-2017-04-preview
  --tag: package-pure-2020-03-preview
```

### Tag: package-pure-2016-03 and ruby

These settings apply only when `--tag=package-pure-2016-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-2016-03' && $(ruby)
namespace: "Azure::StreamAnalytics::Mgmt::V2016_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_stream_analytics/lib
```

### Tag: package-pure-2017-04-preview and ruby

These settings apply only when `--tag=package-pure-2017-04-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-2017-04-preview' && $(ruby)
namespace: "Azure::StreamAnalytics::Mgmt::V2017_04_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_stream_analytics/lib
```

### Tag: package-2020-03-preview and ruby

These settings apply only when `--tag=package-2020-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(ruby)
namespace: "Azure::StreamAnalytics::Mgmt::V2020_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_stream_analytics/lib