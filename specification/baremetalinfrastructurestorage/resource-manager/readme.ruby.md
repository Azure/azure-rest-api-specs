## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_baremetalinfrastructurestorage
package-version: 2023-04-06
azure-arm: true
```

### Tag: package-2023-04-06 and ruby

These settings apply only when `--tag=package-2023-04-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2023-04-06' && $(ruby)
namespace: Microsoft.BareMetalInfrastructureStorage
output-folder: $(ruby-sdks-folder)/baremetalinfrastructurestorage
```
