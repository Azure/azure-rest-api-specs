## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_data_protection
package-version: "0.1.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2022-10-preview
  - tag: package-preview-2022-09
  - tag: package-2021-06-preview
  - tag: package-2021-02-preview
  - tag: package-2022-03
  - tag: package-2023-01
  - tag: package-2023-05
```

### Tag:  package-2023-05 and ruby

These settings apply only when `--tag= package-2023-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == ' package-2023-05' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2023_05_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag:  package-2023-01 and ruby

These settings apply only when `--tag= package-2023-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == ' package-2023-01' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2023_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag:  package-2022-03 and ruby

These settings apply only when `--tag= package-2022-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == ' package-2022-03' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2022_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag: package-2021-02-preview and ruby

These settings apply only when `--tag=package-2021-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-02-preview' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2021_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag: package-2021-06-preview and ruby

These settings apply only when `--tag=package-2021-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2021_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag: package-2022-10-preview and ruby

These settings apply only when `--tag=package-2022-10-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-10-preview' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2022_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```

### Tag: package-preview-2022-09 and ruby

These settings apply only when `--tag=package-preview-2022-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(ruby)
namespace: "Azure::DataProtection::Mgmt::V2022_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_data_protection/lib
```