## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_signalr
package-version: "0.16.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-03-01-preview
  - tag: package-2018-10-01
  - tag: package-2020-05-01
  - tag: package-2020-07-01-preview
  - tag: package-2021-04-01-preview
  - tag: package-2021-06-01-preview
  - tag: package-2021-09-01-preview
```

### Tag: package-2021-09-01-preview and ruby

These settings apply only when `--tag=package-2021-09-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-09-01-preview' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2021_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```

### Tag: package-2021-06-01-preview and ruby

These settings apply only when `--tag=package-2021-06-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-06-01-preview' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2021_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```


### Tag: package-2021-04-01-preview and ruby

These settings apply only when `--tag=package-2021-04-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-04-01-preview' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2021_04_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```

### Tag: package-2020-07-01-preview and ruby

These settings apply only when `--tag=package-2020-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2020_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```

### Tag: package-2020-05-01 and ruby

These settings apply only when `--tag=package-2020-05-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-05-01' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2020_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```

### Tag: package-2018-10-01 and ruby

These settings apply only when `--tag=package-2018-10-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-10-01' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2018_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```

### Tag: package-2018-03-01-preview and ruby

These settings apply only when `--tag=package-2018-03-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-03-01-preview' && $(ruby)
namespace: "Azure::Signalr::Mgmt::V2018_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_signalr/lib
```
