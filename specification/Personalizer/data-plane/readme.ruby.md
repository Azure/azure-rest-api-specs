## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_Personalizer
package-version: 2019-04-25-preview
azure-arm: true
```

### Tag: package-2019-04-25-preview and ruby

These settings apply only when `--tag=package-2019-04-25-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-04-25-preview' && $(ruby)
namespace: Microsoft.Azure.CognitiveServices.Personalizer
output-folder: $(ruby-sdks-folder)/Personalizer
```
