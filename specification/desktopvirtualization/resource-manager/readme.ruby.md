## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_desktop_virtualization
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-01-23-preview
  - tag: package-2019-09-24-preview
  - tag: package-2019-12-10-preview
  - tag: package-2020-09-21-preview
  - tag: package-2020-10-19-preview
```
### Tag: package-2020-10-19-preview and ruby

These settings apply only when `--tag=package-2020-10-19-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-10-19-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2020_10_19_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_desktop_virtualization/lib
```

### Tag: package-2020-10-19-preview and ruby

These settings apply only when `--tag=package-2020-09-21-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-09-21-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2020_09_21_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_desktop_virtualization/lib
```

### Tag: package-2019-12-10-preview and ruby

These settings apply only when `--tag=package-2019-12-10-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-12-10-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2019_12_10_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_desktop_virtualization/lib
```

### Tag: package-2019-09-24-preview and ruby

These settings apply only when `--tag=package-2019-09-24-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-09-24-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2019_09_24_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_desktop_virtualization/lib
```

### Tag: package-2019-01-23-preview and ruby

These settings apply only when `--tag=package-2019-01-23-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-01-23-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2019_01_23_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_desktop_virtualization/lib
```