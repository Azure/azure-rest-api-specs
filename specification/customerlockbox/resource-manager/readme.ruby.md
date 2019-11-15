## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_customerlockbox
package-version: 2018-02-28-preview
azure-arm: true
```

### Tag: package-2018-02-28-preview and ruby

These settings apply only when `--tag=package-2018-02-28-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2018-02-28-preview' && $(ruby)
namespace: Microsoft.CustomerLockbox
output-folder: $(ruby-sdks-folder)/customerlockbox
```
