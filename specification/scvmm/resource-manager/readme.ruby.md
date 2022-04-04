## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_scvmm
package-version: 2020-06-05-preview
azure-arm: true
```

### Tag: package-2020-06-05-preview and ruby

These settings apply only when `--tag=package-2020-06-05-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-06-05-preview' && $(ruby)
namespace: Microsoft.SCVMM
output-folder: $(ruby-sdks-folder)/scvmm
```
