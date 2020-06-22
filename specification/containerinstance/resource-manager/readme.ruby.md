## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_container_instance
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-12
  - tag: package-2018-10
  - tag: package-2018-09
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2018-02-preview
  - tag: package-2017-12-preview
  - tag: package-2017-10-preview
  - tag: package-2017-08-preview
```

### Tag: package-2019-12 and ruby

These settings apply only when `--tag=package-2019-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-12' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2019_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2018-09 and ruby

These settings apply only when `--tag=package-2018-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-10' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2018_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2018-09 and ruby

These settings apply only when `--tag=package-2018-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-09' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2018_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2018-06 and ruby

These settings apply only when `--tag=package-2018-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-06' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2018_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2018-04 and ruby

These settings apply only when `--tag=package-2018-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-04' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2018_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2018-02-preview and ruby

These settings apply only when `--tag=package-2018-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-02-preview' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2018_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2017-12-preview and ruby

These settings apply only when `--tag=package-2017-12-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-12-preview' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2017_12_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2017-10-preview and ruby

These settings apply only when `--tag=package-2017-10-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10-preview' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2017_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```

### Tag: package-2017-08-preview and ruby

These settings apply only when `--tag=package-2017-08-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08-preview' && $(ruby)
namespace: "Azure::ContainerInstance::Mgmt::V2017_08_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_container_instance/lib
```
