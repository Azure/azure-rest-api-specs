## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_dns
package-version: "0.16.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-03-preview
  - tag: package-2017-10
  - tag: package-2017-09
  - tag: package-2016-04
```

### Tag: package-2018-03-preview and ruby

These settings apply only when `--tag=package-2018-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(ruby)
namespace: "Azure::Dns::Mgmt::V2018_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_dns/lib
```

### Tag: package-2017-10 and ruby

These settings apply only when `--tag=package-2017-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10' && $(ruby)
namespace: "Azure::Dns::Mgmt::V2017_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_dns/lib
```

### Tag: package-2017-09 and ruby

These settings apply only when `--tag=package-2017-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-09' && $(ruby)
namespace: "Azure::Dns::Mgmt::V2017_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_dns/lib
```

### Tag: package-2016-04 and ruby

These settings apply only when `--tag=package-2016-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-04' && $(ruby)
namespace: "Azure::Dns::Mgmt::V2016_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_dns/lib
```
