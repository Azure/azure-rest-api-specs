## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_resource_connector
package-version: 2022-10-27
azure-arm: true
```

### Tag: package-2021-10-31-preview and ruby

These settings apply only when `--tag=package-2021-10-31-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-10-31-preview' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::V2021-10-31-preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resource_connector/lib
```

### Tag: package-2022-04-15-preview and ruby

These settings apply only when `--tag=package-2022-04-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-04-15-preview' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::2022-04-15-preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resource_connector/lib
```

### Tag: package-2022-10-27 and ruby

These settings apply only when `--tag=package-2022-10-27 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-10-27' && $(ruby)
namespace: Azure::ExtendedLocation::Mgmt::2022-10-27
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resource_connector/lib
```