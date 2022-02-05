## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_quota
package-version: 2021-03-15
azure-arm: true
```

### Tag: package-2021-03-15 and ruby

These settings apply only when `--tag=package-2021-03-15 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-15' && $(ruby)
namespace: Microsoft.Quota
output-folder: $(ruby-sdks-folder)/quota
```

### Tag: package-2021-03-15-preview and ruby

These settings apply only when `--tag=package-2021-03-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-03-15-preview' && $(ruby)
namespace: Microsoft.Quota
output-folder: $(ruby-sdks-folder)/quota-preview
```
