## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_vmwareonazure
package-version: 2019-12-11-preview
azure-arm: true
```

### Tag: package-2019-12-11-preview and ruby

These settings apply only when `--tag=package-2019-12-11-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-12-11-preview' && $(ruby)
namespace: Microsoft.VMwareOnAzure
output-folder: $(ruby-sdks-folder)/vmwareonazure
```
