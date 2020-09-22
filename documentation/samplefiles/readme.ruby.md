## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_[[ServiceName]]
package-version: [[Version]]
azure-arm: true
```

### Tag: package-[[Version]] and ruby

These settings apply only when `--tag=package-[[Version]] --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-[[Version]]' && $(ruby)
namespace: [[ResourceProviderName]]
output-folder: $(ruby-sdks-folder)/[[ServiceName]]
```
