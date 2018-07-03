## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_server_management
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-07-preview
```

### Tag: package-2016-07-preview and ruby

These settings apply only when `--tag=package-2016-07-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-07-preview' && $(ruby)
namespace: "Azure::ServerManagement::Mgmt::V2016_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_server_management/lib
```
