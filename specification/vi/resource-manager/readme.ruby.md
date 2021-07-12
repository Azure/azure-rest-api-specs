## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_vi
package-version: 2021-04-01-preview
azure-arm: true
```

Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(ruby)
namespace: Azure::VideoIndexer::Mgmt::V$(version-with-underscores)
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vi/lib
```
