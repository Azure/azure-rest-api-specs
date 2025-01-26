## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_privatedns
package-version: "0.16.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2024-06
  - tag: package-2018-09
```

### Tag: package-2024-06 and ruby

These settings apply only when `--tag=package-2024-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2024-06' && $(ruby)
namespace: "Azure::PrivateDns::Mgmt::V2024_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_privatedns/lib
```

### Tag: package-2018-09 and ruby

These settings apply only when `--tag=package-2018-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-09' && $(ruby)
namespace: "Azure::PrivateDns::Mgmt::V2018_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_privatedns/lib
```
