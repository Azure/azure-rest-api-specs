## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_confluent
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2021-12-01
  - tag: package-2020-03-01
  - tag: package-2020-03-01-preview
```

### Tag: package-2021-12-01 and ruby

These settings apply only when `--tag=package-2021-12-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-12-01' && $(ruby)
namespace: "Azure::Confluent::Mgmt::V2021_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_confluent/lib
```

### Tag: package-2020-03-01 and ruby

These settings apply only when `--tag=package-2020-03-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-03-01' && $(ruby)
namespace: "Azure::Confluent::Mgmt::V2020_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_confluent/lib
```

### Tag: package-2020-03-01-preview and ruby

These settings apply only when `--tag=package-2020-03-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-03-01-preview' && $(ruby)
namespace: "Azure::Confluent::Mgmt::V2020_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_confluent/lib
```
