## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_vmware
package-version: 2020-10-01-preview
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-10-01-preview
  - tag: package-2022-01-10-preview
  - tag: package-2022-07-15-preview
```

### Tag: package-2020-10-01-preview and ruby

These settings apply only when `--tag=package-2020-10-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(ruby)
namespace: "Azure::VMware::Mgmt::V2020-10-01-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vmware/lib
```
### Tag: package-2022-01-10-preview and ruby

These settings apply only when `--tag=package-2022-01-10-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-01-10-preview' && $(ruby)
namespace: "Azure::VMware::Mgmt::V2022-01-10-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vmware/lib
```
### Tag: package-2022-07-15-preview and ruby

These settings apply only when `--tag=package-2022-07-15-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2022-07-15-preview' && $(ruby)
namespace: "Azure::VMware::Mgmt::V2022-07-15-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vmware/lib
```