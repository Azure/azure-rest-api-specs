## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_storagecache
package-version: 2019-08
azure-arm: true
```

### Tag: package-2019-08 and ruby

These settings apply only when `--tag=package-2019-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-08' && $(ruby)
namespace: "Azure::StorageCache::Mgmt::V2019_08"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_storagecache/lib
```
