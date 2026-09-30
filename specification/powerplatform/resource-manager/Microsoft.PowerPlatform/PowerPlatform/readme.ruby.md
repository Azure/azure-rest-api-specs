## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_powerplatform
package-version: 2020-10-30-preview
azure-arm: true
```

### Tag: package-2020-10-30-preview and ruby

These settings apply only when `--tag=package-2020-10-30-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-10-30-preview' && $(ruby)
namespace: Microsoft.PowerPlatform
output-folder: $(ruby-sdks-folder)/powerplatform
```
