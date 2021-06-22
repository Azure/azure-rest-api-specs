## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_azurearcdata
package-version: 2021-06-01
azure-arm: true
```

### Tag: package-preview-2021-06-01 and ruby

These settings apply only when `--tag=package-preview-2021-06-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-preview-2021-06-01' && $(ruby)
namespace: Microsoft.AzureArcData
output-folder: $(ruby-sdks-folder)/azurearcdata
```
