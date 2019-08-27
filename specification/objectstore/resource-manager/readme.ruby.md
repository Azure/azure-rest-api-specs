## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_objectstore
package-version: 2019-06-01-preview
azure-arm: true
```

### Tag: package-2019-06-01-preview and ruby

These settings apply only when `--tag=package-2019-06-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-06-01-preview' && $(ruby)
namespace: "Azure::ObjectStore::Mgmt::V2019_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_objectstore/lib
```
