## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_providerhub
package-version: 2020-11-20
azure-arm: true
```

### Tag: package-2020-11-20 and ruby

These settings apply only when `--tag=package-2020-11-20 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-11-20' && $(ruby)
namespace: Microsoft.ProviderHub
output-folder: $(ruby-sdks-folder)/providerhub
```
