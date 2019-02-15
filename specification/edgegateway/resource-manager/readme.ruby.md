## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml $(ruby)
package-name: azure_mgmt_edgegateway
package-version: "0.0.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-03
```

### Tag: package-2019-03 and ruby

These settings apply only when `--tag=package-2019-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-03' && $(ruby)
namespace: "Azure::Compute::Mgmt::V2019_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_edgegateway/lib
```
