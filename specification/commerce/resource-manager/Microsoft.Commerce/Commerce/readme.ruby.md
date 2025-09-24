## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_commerce
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-06-preview
```

### Tag: package-2015-06-preview and ruby

These settings apply only when `--tag=package-2015-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06-preview' && $(ruby)
namespace: "Azure::Commerce::Mgmt::V2015_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_commerce/lib
```
