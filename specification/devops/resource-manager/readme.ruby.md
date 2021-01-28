## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_devops
package-version: 2020-07-13-preview
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-07-13-preview
  - tag: package-2019-07-01-preview
```

### Tag: package-2020-07-13-preview and ruby

These settings apply only when `--tag=package-2020-07-13-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-07-13-preview' && $(ruby)
namespace: Azure::DevOps::Mgmt::V2020_07_13_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_devops/lib
```

### Tag: package-2019-07-01-preview and ruby

These settings apply only when `--tag=package-2019-07-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-07-01-preview' && $(ruby)
namespace: Azure::DevOps::Mgmt::V2019_07_01_preview
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_devops/lib
```
