## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_vmware
package-version: 2019-12-20-privatepreview
azure-arm: true
```

### Tag: package-2019-12-20-privatepreview and ruby

These settings apply only when `--tag=package-2019-12-20-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-12-20-privatepreview' && $(ruby)
namespace: Microsoft.VMware
output-folder: $(ruby-sdks-folder)/vmware
```
