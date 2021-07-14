## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_arcopenstack
package-version: 2021-05-31-privatepreview
azure-arm: true
```

### Tag: package-2021-05-31-privatepreview and ruby

These settings apply only when `--tag=package-2021-05-31-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-05-31-privatepreview' && $(ruby)
namespace: Microsoft.ConnectedOpenStack
output-folder: $(ruby-sdks-folder)/arcopenstack
```
