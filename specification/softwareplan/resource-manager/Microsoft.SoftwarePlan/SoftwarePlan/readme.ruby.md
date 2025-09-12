## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_softwareplan
package-version: 2019-06-01-preview
azure-arm: true
```

### Tag: package-2019-06-01-preview and ruby

These settings apply only when `--tag=package-2019-06-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-06-01-preview' && $(ruby)
namespace: Microsoft.SoftwarePlan
output-folder: $(ruby-sdks-folder)/softwareplan
```

### Tag: package-2019-12-01 and ruby

These settings apply only when `--tag=package-2019-12-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-12-01' && $(ruby)
namespace: Microsoft.SoftwarePlan
output-folder: $(ruby-sdks-folder)/softwareplan
```