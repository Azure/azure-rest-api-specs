## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_azuredata
package-version: 2019-07-24
azure-arm: true
```

### Tag: package-2019-07-24 and ruby

These settings apply only when `--tag=package-2019-07-24 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-07-24' && $(ruby)
namespace: Microsoft.AzureData
output-folder: $(ruby-sdks-folder)/azuredata
```