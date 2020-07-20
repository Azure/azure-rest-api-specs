## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_azureiidt
package-version: 2020-07-15-privatepreview
azure-arm: true
```

### Tag: package-2020-06-10-privatepreview and ruby

These settings apply only when `--tag=package-2020-06-10-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-06-10-privatepreview' && $(ruby)
namespace: Microsoft.IntelligentITDigitalTwin
output-folder: $(ruby-sdks-folder)/azureiidt
```

### Tag: package-2020-07-15-privatepreview and ruby

These settings apply only when `--tag=package-2020-07-15-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-15-privatepreview' && $(ruby)
namespace: Microsoft.IntelligentITDigitalTwin
output-folder: $(ruby-sdks-folder)/azureiidt
```
