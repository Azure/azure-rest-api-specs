## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_healthbot
package-version: 2020-12-10
azure-arm: true
```

### Tag: package-2020-12-10 and ruby

These settings apply only when `--tag=package-2020-12-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-12-10' && $(ruby)
namespace: Microsoft.HealthcareBot
output-folder: $(ruby-sdks-folder)/healthbot
```
