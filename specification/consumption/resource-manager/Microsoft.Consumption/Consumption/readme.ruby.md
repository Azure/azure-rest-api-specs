## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_consumption
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-01
  - tag: package-2018-01
  - tag: package-2017-12-preview
  - tag: package-2017-11
  - tag: package-2017-04-preview
```

### Tag: package-2019-01 and ruby

These settings apply only when `--tag=package-2019-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-01' && $(ruby)
namespace: "Azure::Consumption::Mgmt::V2019_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_consumption/lib
```

### Tag: package-2018-01 and ruby

These settings apply only when `--tag=package-2018-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01' && $(ruby)
namespace: "Azure::Consumption::Mgmt::V2018_01_31"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_consumption/lib
```

### Tag: package-2017-12-preview and ruby

These settings apply only when `--tag=package-2017-12-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(ruby)
namespace: "Azure::Consumption::Mgmt::V2017_12_30_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_consumption/lib
```

### Tag: package-2017-11 and ruby

These settings apply only when `--tag=package-2017-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-11' && $(ruby)
namespace: "Azure::Consumption::Mgmt::V2017_11_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_consumption/lib
```

### Tag: package-2017-04-preview and ruby

These settings apply only when `--tag=package-2017-04-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(ruby)
namespace: "Azure::Consumption::Mgmt::V2017_04_24_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_consumption/lib
```
