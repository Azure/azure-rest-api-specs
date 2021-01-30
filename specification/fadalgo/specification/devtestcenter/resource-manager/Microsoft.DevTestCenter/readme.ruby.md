## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_devtestcenter
package-version: 2021-01-01-alpha
azure-arm: true
```

### Tag: package-2021-01-01-alpha and ruby

These settings apply only when `--tag=package-2021-01-01-alpha --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-01-01-alpha' && $(ruby)
namespace: Microsoft.DevTestCenter
output-folder: $(ruby-sdks-folder)/devtestcenter
```