## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_datadog
package-version: 2022-06-01
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2022-06-01
  - tag: package-2021-03-01
  - tag: package-2020-02-01-preview
```

### Tag: package-2022-06-01 and ruby

These settings apply only when `--tag=package-2022-06-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-06-01' && $(ruby)
namespace: "Azure::Datadog::Mgmt::V2022_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_datadog/lib
```

### Tag: package-2021-03-01 and ruby

These settings apply only when `--tag=package-2021-03-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-03-01' && $(ruby)
namespace: "Azure::Datadog::Mgmt::V2021_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_datadog/lib
```

### Tag: package-2020-02-01-preview and ruby

These settings apply only when `--tag=package-2020-02-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-02-01-preview' && $(ruby)
namespace: "Azure::Datadog::Mgmt::V2020_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_datadog/lib
```