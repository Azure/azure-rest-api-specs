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
  - tag: package-2021-09
  - tag: package-2021-08-preview
  - tag: package-2021-06-preview
  - tag: package-2020-11-preview
  - tag: package-2019-12-preview
  - tag: package-2017-10
  - tag: package-2017-06-preview
  - tag: package-2017-03
  - tag: package-2016-06-preview
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

### Tag: package-2017-06-preview and ruby

These settings apply only when `--tag=package-2017-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-06-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2017_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2017-03 and ruby

These settings apply only when `--tag=package-2017-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-03' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2017_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

### Tag: package-2016-06-preview and ruby

These settings apply only when `--tag=package-2016-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-06-preview' && $(ruby)
namespace: "Azure::ContainerRegistry::Mgmt::V2016_06_27_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_registry/lib
```

