## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_saas
package-version: 2018-03-01-beta
azure-arm: true
```

### Tag: package-2018-03-01-beta and ruby

These settings apply only when `--tag=package-2018-03-01-beta --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2018-03-01-beta' && $(ruby)
namespace: saas
output-folder: $(ruby-sdks-folder)/management/$(namespace)
```
