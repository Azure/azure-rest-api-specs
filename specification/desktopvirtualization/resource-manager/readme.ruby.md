## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_DesktopVirtualization
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-01-23-preview
```

### Tag: package-2019-01-23-preview and ruby

These settings apply only when `--tag=package-2019-01-23-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-01-23-preview' && $(ruby)
namespace: "Azure::DesktopVirtualization::Mgmt::V2017_04_24_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_DesktopVirtualization/lib
```
