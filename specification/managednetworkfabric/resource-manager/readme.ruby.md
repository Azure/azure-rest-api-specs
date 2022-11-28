## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_managednetworkfabric
package-version: 2022-01-15-privatepreview
azure-arm: true
```

### Tag: package-2022-01-15-privatepreview and ruby

These settings apply only when `--tag=package-2022-01-15-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-01-15-privatepreview' && $(ruby)
namespace: Microsoft.ManagedNetworkFabric
output-folder: $(ruby-sdks-folder)/managednetworkfabric
```
