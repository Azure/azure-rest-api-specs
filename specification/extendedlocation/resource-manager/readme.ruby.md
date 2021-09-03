## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_extended_location
package-version: 2020-07-15-privatepreview
azure-arm: true
```

### Tag: package-2021-03-15-preview and ruby

These settings apply only when `--tag=package-2021-03-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-15-privatepreview' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::V2021_03_15_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_extended_location/lib
```
