## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_key_vault
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-10
  - tag: package-2015-06
```

### Tag: package-2016-10 and ruby

These settings apply only when `--tag=package-2016-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-10' && $(ruby)
namespace: "Azure::KeyVault::Mgmt::V2016_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_key_vault/lib
```

### Tag: package-2015-06 and ruby

These settings apply only when `--tag=package-2015-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06' && $(ruby)
namespace: "Azure::KeyVault::Mgmt::V2015_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_key_vault/lib
```
