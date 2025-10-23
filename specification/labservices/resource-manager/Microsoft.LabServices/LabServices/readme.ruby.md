## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_LabServices
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-10
```

### Tag: package-2018-10 and ruby

These settings apply only when `--tag=package-2018-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-10' && $(ruby)
namespace: "Azure::LabServices::Mgmt::V2018_10_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_LabServices/lib
```
