## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_extended_location
package-version: 2021-08-15
azure-arm: true
```

### Tag: package-2021-03-15-preview and ruby

These settings apply only when `--tag=package-2021-03-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-15-preview' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::V2021_03_15_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_extended_location/lib
```

### Tag: package-2021-08-15 and ruby

These settings apply only when `--tag=package-2021-08-15 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-08-15' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::V2021_08_15
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_extended_location/lib
```

### Tag: package-2021-08-31-preview and ruby

These settings apply only when `--tag=package-2021-08-31-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-08-31-preview' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::V2021_08_31_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_extended_location/lib
```