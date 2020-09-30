## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml $(ruby)
namespace: "Azure::Falcon::Mgmt::V2020_09_02_preview"
package-name: azure_mgmt_falcon
package-version: 2020-09-02-preview
azure-arm: true
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_falcon/lib
```

### Tag: package-2020-01-20-preview and ruby

These settings apply only when `--tag=package-2020-01-20-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-01-20-preview' && $(ruby)
namespace: "Azure::Falcon::Mgmt::V2020_01_20_preview"
```
