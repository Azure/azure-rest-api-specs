## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_relay
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2016-07
```

### Tag: package-2017-04 and ruby

These settings apply only when `--tag=package-2017-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04' && $(ruby)
namespace: "Azure::Relay::Mgmt::V2017_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_relay/lib
```

### Tag: package-2016-07 and ruby

These settings apply only when `--tag=package-2016-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-07' && $(ruby)
namespace: "Azure::Relay::Mgmt::V2016_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_relay/lib
```
