## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_resources_management
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-11
  - tag: package-2017-08
```

### Tag: package-2017-11 and ruby

These settings apply only when `--tag=package-2017-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-11' && $(ruby)
namespace: "Azure::ResourcesManagement::Mgmt::V2017_11_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources_management/lib
```

### Tag: package-2017-08 and ruby

These settings apply only when `--tag=package-2017-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08' && $(ruby)
namespace: "Azure::ResourcesManagement::Mgmt::V2017_08_31_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources_management/lib
```