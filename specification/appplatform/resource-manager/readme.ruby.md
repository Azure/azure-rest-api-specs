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
  - tag: package-preview-2022-01
  - tag: package-preview-2021-09
  - tag: package-preview-2021-06
  - tag: package-preview-2020-11
  - tag: package-2020-07
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
