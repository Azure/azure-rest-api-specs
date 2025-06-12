## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_container_registry
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2025-05-preview
  - tag: package-2025-04
  - tag: package-2025-03-preview
  - tag: package-2024-11-preview
  - tag: package-2023-11-preview
  - tag: package-2023-08-preview
  - tag: package-2023-07
  - tag: package-2023-01-preview
  - tag: package-2022-12
  - tag: package-2022-02-preview
  - tag: package-2021-12-preview
  - tag: package-2021-09
  - tag: package-2021-08-preview
  - tag: package-2021-06-preview
  - tag: package-2020-11-preview
  - tag: package-2019-12-preview
  - tag: package-2017-10
  - tag: package-2017-03
```

### Tag: package-2025-05-preview and ruby

These settings apply only when `--tag=package-2025-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2025-05-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2025_05_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2025-04 and ruby

These settings apply only when `--tag=package-2025-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2025-04' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2025_04_01"
```

### Tag: package-2025-03-preview and ruby

These settings apply only when `--tag=package-2025-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2025-03-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2025_03_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2024-11-preview and ruby

These settings apply only when `--tag=package-2024-11-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2024-11-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2024_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2023-11-preview and ruby

These settings apply only when `--tag=package-2023-11-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2023-11-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2023_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2023-08-preview and ruby

These settings apply only when `--tag=package-2023-08-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2023-08-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2023_08_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2023-07 and ruby

These settings apply only when `--tag=package-2023-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2023-07' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2023_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2023-01-preview and ruby

These settings apply only when `--tag=package-2023-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2023-01-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2023_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2022-12 and ruby

These settings apply only when `--tag=package-2022-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-12' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2022_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2022-02-preview and ruby

These settings apply only when `--tag=package-2022-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2022-02-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2022_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2021-12-preview and ruby

These settings apply only when `--tag=package-2021-12-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-12-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2021_12_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2021-09 and ruby

These settings apply only when `--tag=package-2021-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-09' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2021_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2021-08-preview and ruby

These settings apply only when `--tag=package-2021-08-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-08-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2021_08_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2021-06-preview and ruby

These settings apply only when `--tag=package-2021-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2021-06-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2021_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2020-11-preview and ruby

These settings apply only when `--tag=package-2020-11-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-11-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2020_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2019-12-preview and ruby

These settings apply only when `--tag=package-2019-12-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-12-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2019_12_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2017-10 and ruby

These settings apply only when `--tag=package-2017-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2017_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2017-03 and ruby

These settings apply only when `--tag=package-2017-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-03' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2017_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

