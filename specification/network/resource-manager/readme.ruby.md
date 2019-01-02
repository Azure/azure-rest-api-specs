## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_network
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-05-preview
  - tag: package-2015-06split
  - tag: package-2016-03
  - tag: package-2016-06
  - tag: package-2016-09
  - tag: package-2016-12
  - tag: package-2017-03-only
  - tag: package-2017-03-30-only
  - tag: package-2017-09-only
  - tag: package-2017-10-only
  - tag: package-2017-11-only
  - tag: package-2018-01-only
```

### Tag: package-2015-05-preview and ruby

These settings apply only when `--tag=package-2015-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(ruby)
namespace: "Azure::Network::Mgmt::V2015_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2015-06split and ruby

These settings apply only when `--tag=package-2015-06split --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06split' && $(ruby)
namespace: "Azure::Network::Mgmt::V2015_06_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2016-03 and ruby

These settings apply only when `--tag=package-2016-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-03' && $(ruby)
namespace: "Azure::Network::Mgmt::V2016_03_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2016-06 and ruby

These settings apply only when `--tag=package-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-06' && $(ruby)
namespace: "Azure::Network::Mgmt::V2016_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2016-09 and ruby

These settings apply only when `--tag=package-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-09' && $(ruby)
namespace: "Azure::Network::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2016-12 and ruby

These settings apply only when `--tag=package-2016-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-12' && $(ruby)
namespace: "Azure::Network::Mgmt::V2016_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2017-03-only and ruby

These settings apply only when `--tag=package-2017-03-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-03-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2017_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2017-03-30-only and ruby

These settings apply only when `--tag=package-2017-03-30-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-03-30-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2017_03_30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2017-09-only and ruby

These settings apply only when `--tag=package-2017-09-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-09-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2017_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2017-10-only and ruby

These settings apply only when `--tag=package-2017-10-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2017_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2017-11-only and ruby

These settings apply only when `--tag=package-2017-11-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-11-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2017_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```

### Tag: package-2018-01-only and ruby

These settings apply only when `--tag=package-2018-01-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01-only' && $(ruby)
namespace: "Azure::Network::Mgmt::V2018_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_network/lib
```
