## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_loadtestservice
package-version: 2022-04-15-preview
azure-arm: true
```

### Tag: package-2022-04-15-preview and ruby

These settings apply only when `--tag=package-2022-04-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-04-15-preview' && $(ruby)
namespace: Microsoft.LoadTestService
output-folder: $(ruby-sdks-folder)/loadtestservice
```