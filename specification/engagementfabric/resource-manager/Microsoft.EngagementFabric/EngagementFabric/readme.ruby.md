## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_engagementfabric
package-version: "0.16.1"
azure-arm: true
```

### Tag: package-2018-09-preview and ruby

These settings apply only when `--tag=package-2018-09-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-09-preview' && $(ruby)
namespace: "Azure::EngagementFabric::Mgmt::V2018_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_engagementfabric/lib
```