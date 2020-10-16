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
  - tag: package-2019-12-20-privatepreview
```

### Tag: package-2020-10-01-preview and ruby

These settings apply only when `--tag=package-2020-10-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(ruby)
namespace: "Azure::VMware::Mgmt::V2020-10-01-preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vmware/lib

### Tag: package-2019-12-20-privatepreview and ruby

These settings apply only when `--tag=package-2019-12-20-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2019-12-20-privatepreview' && $(ruby)
namespace: "Azure::VMware::Mgmt::V2019-12-20-privatepreview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_vmware/lib
```
