## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_peering
package-version: "2020-04-01"
azure-arm: true
```
or
``` yaml
package-name: azure_mgmt_peering
package-version: "2020-01-01-preview"
azure-arm: true
```
or
``` yaml
package-name: azure_mgmt_peering
package-version: "2019-09-01-preview"
azure-arm: true
```
or
``` yaml
package-name: azure_mgmt_peering
package-version: "2019-08-01-preview"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-04-01
```
or
``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
```
or
``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-09-01-preview
```
or
``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-08-01-preview
```

### Tag: package-2020-04-01 and ruby

These settings apply only when `--tag=package-2020-04-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-04-01' && $(ruby)
namespace: "Azure::Peering::Mgmt::V2020_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_peering/lib
```

### Tag: package-2020-01-01-preview and ruby

These settings apply only when `--tag=package-2020-01-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-01-01-preview' && $(ruby)
namespace: "Azure::Peering::Mgmt::V2020_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_peering/lib
```

### Tag: package-2019-09-01-preview and ruby

These settings apply only when `--tag=package-2019-09-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-09-01-preview' && $(ruby)
namespace: "Azure::Peering::Mgmt::V2019_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_peering/lib
```

### Tag: package-2019-08-01-preview and ruby

These settings apply only when `--tag=package-2019-08-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-08-01-preview' && $(ruby)
namespace: "Azure::Peering::Mgmt::V2019_08_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_peering/lib
```