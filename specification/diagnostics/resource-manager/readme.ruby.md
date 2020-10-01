## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_diagnostics
package-version: 2021-01-01
azure-arm: true
```

### Tag: package-2021-01-01 and ruby

These settings apply only when `--tag=package-2021-01-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-01-01' && $(ruby)
namespace: Microsoft.Diagnostics
output-folder: $(ruby-sdks-folder)/diagnostics
```
