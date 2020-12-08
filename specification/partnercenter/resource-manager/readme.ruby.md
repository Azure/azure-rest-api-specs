## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_partnercenter
package-version: 2020-12-07
azure-arm: true
```

### Tag: package-2020-12-07 and ruby

These settings apply only when `--tag=package-2020-12-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-12-07' && $(ruby)
namespace: Microsoft.PartnerCenter
output-folder: $(ruby-sdks-folder)/partnercenter
```
