## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_msi
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-11-30
  - tag: package-2015-08-31-preview
```

### Tag: package-2018-11-30 and ruby

These settings apply only when `--tag=package-2018-11-30 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-11-30' && $(ruby)
namespace: "Azure::ManagedServiceIdentity::Mgmt::V2018-11-30"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_msi/lib
```

### Tag: package-2015-08-31-preview and ruby

These settings apply only when `--tag=package-2015-08-31-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-08-31-preview' && $(ruby)
namespace: "Azure::ManagedServiceIdentity::Mgmt::V2015_08_31_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_msi/lib
```
