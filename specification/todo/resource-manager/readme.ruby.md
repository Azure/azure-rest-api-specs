## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_todo
package-version: 2020-05-01
azure-arm: true
```

### Tag: package-2020-05-01 and ruby

These settings apply only when `--tag=package-2020-05-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-05-01' && $(ruby)
namespace: Microsoft.SampleRP
output-folder: $(ruby-sdks-folder)/todo
```
