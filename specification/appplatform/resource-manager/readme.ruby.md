## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_appplatform
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-preview-2023-09
  - tag: package-preview-2023-07
  - tag: package-preview-2023-05
  - tag: package-preview-2023-03
  - tag: package-preview-2023-01
  - tag: package-2022-12
  - tag: package-preview-2022-11
  - tag: package-preview-2022-09
  - tag: package-preview-2022-05
  - tag: package-2022-04
  - tag: package-preview-2022-03
  - tag: package-preview-2022-01
  - tag: package-preview-2021-09
  - tag: package-preview-2021-06
  - tag: package-preview-2020-11
  - tag: package-2020-07
```

### Tag: package-preview-2023-09 and ruby

These settings apply only when `--tag=package-preview-2023-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2023-09' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2023_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2023-07 and ruby

These settings apply only when `--tag=package-preview-2023-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2023-07' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2023_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2023-05 and ruby

These settings apply only when `--tag=package-preview-2023-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2023-05' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2023_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2023-03 and ruby

These settings apply only when `--tag=package-preview-2023-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2023-03' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2023_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2023-01 and ruby

These settings apply only when `--tag=package-preview-2023-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2023-01' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2023_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-2022-12 and ruby

These settings apply only when `--tag=package-2022-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-12' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2022-11 and ruby

These settings apply only when `--tag=package-preview-2022-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-11' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2022-09 and ruby

These settings apply only when `--tag=package-preview-2022-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-09' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2022-05 and ruby

These settings apply only when `--tag=package-preview-2022-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-05' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-2022-04 and ruby

These settings apply only when `--tag=package-2022-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-04' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2022-03 and ruby

These settings apply only when `--tag=package-preview-2022-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-03' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2022-01 and ruby

These settings apply only when `--tag=package-preview-2022-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2022-01' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2022_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2021-09 and ruby

These settings apply only when `--tag=package-preview-2021-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2021-09' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2021_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2021-06 and ruby

These settings apply only when `--tag=package-preview-2021-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2021-06' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2021_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-preview-2020-11 and ruby

These settings apply only when `--tag=package-preview-2020-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-preview-2020-11' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2020_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```

### Tag: package-2020-07 and ruby

These settings apply only when `--tag=package-2020-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-07' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2020_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```
