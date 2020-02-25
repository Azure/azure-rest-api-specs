## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_authorization
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-07-01
  - tag: package-2015-06-01-preview
  - tag: package-2017-10-01-preview-only
  - tag: package-2018-01-01-preview-only
```

### Tag: package-2015-07-01 and ruby

These settings apply only when `--tag=package-2015-07-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-07-01' && $(ruby)
namespace: "Azure::Authorization::Mgmt::V2015_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_authorization/lib
```

### Tag: package-2015-06-01-preview and ruby

These settings apply only when `--tag=package-2015-06-01-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06-01-preview' && $(ruby)
namespace: "Azure::Authorization::Mgmt::V2015_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_authorization/lib
```

### Tag: package-2017-10-01-preview-only and ruby

These settings apply only when `--tag=package-2017-10-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10-01-preview-only' && $(ruby)
namespace: "Azure::Authorization::Mgmt::V2017_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_authorization/lib
```

### Tag: package-2018-01-01-preview-only and ruby

These settings apply only when `--tag=package-2018-01-01-preview-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01-01-preview-only' && $(ruby)
namespace: "Azure::Authorization::Mgmt::V2018_01_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_authorization/lib
```
