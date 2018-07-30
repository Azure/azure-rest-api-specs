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
  - tag: package-2018-02-preview
  - tag: package-2017-12-preview
  - tag: package-2017-10-preview
  - tag: package-2017-08-preview
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
