## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_monitor
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-04-01-only
  - tag: package-2016-03-01-only
  - tag: package-2016-09-01-only
  - tag: package-2017-04-01-only
  - tag: package-2017-05-01-preview-only
  - tag: package-2017-11-01-preview-only
```

### Tag: package-2015-04-01-only and ruby

These settings apply only when `--tag=package-2015-04-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-04-01-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2015_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```

### Tag: package-2016-03-01-only and ruby

These settings apply only when `--tag=package-2016-03-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-03-01-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2016_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```

### Tag: package-2016-09-01-only and ruby

These settings apply only when `--tag=package-2016-09-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-09-01-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```

### Tag: package-2017-04-01-only and ruby

These settings apply only when `--tag=package-2017-04-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04-01-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2017_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```

### Tag: package-2017-05-01-preview-only and ruby

These settings apply only when `--tag=package-2017-05-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-05-01-preview-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2017_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```

### Tag: package-2017-11-01-preview-only and ruby

These settings apply only when `--tag=package-2017-11-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-11-01-preview-only' && $(ruby)
namespace: "Azure::Monitor::Mgmt::V2017_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_monitor/lib
```