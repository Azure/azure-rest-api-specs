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
  - tag: package-preview-2021-06
  - tag: package-preview-2020-11
  - tag: package-2020-07
  - tag: package-2019-05-01-preview
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

### Tag: package-2019-05-01-preview and ruby

These settings apply only when `--tag=package-2019-05-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-05-01-preview' && $(ruby)
namespace: "Azure::AppPlatform::Mgmt::V2019_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_appplatform/lib
```
