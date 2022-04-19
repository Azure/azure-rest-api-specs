## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_redisenterprise
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2021-08
  - tag: package-2021-03
  - tag: package-2020-10-01-preview
```

### Tag: package-2021-08 and ruby

These settings apply only when `--tag=package-2021-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-08' && $(ruby)
namespace: "Azure::RedisEnterprise::Mgmt::V2021_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redisenterprise/lib
```

### Tag: package-2021-03 and ruby

These settings apply only when `--tag=package-2021-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03' && $(ruby)
namespace: "Azure::RedisEnterprise::Mgmt::V2021_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redisenterprise/lib
```

### Tag: package-2020-10-01-preview and ruby

These settings apply only when `--tag=package-2020-10-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(ruby)
namespace: "Azure::RedisEnterprise::Mgmt::V2020_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redisenterprise/lib
```
