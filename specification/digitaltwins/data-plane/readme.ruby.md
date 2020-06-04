## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: digitaltwins
package-version: 2020-05-31-preview
azure-arm: true
```

### Tag: package-2020-05-31-preview and ruby

These settings apply only when `--tag=package-2020-05-31-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-05-31-preview' && $(ruby)
namespace: Azure.DigitalTwins.Core
output-folder: $(ruby-sdks-folder)/digitaltwins
```
