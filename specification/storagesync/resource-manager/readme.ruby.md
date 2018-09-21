## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_storagesync_management
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-04-02
```

### Tag: package-2018-04-02 and ruby

These settings apply only when `--tag=package-2018-04-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-04-02' && $(ruby)
namespace: "Azure::ServerManagement::Mgmt::V2016_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_server_management/lib
```
