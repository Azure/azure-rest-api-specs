## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_bing
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2020-06
  - tag: package-2020-06-preview
```

### Tag: package-2020-06 and ruby

These settings apply only when `--tag=package-2020-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-06' && $(ruby)
namespace: "Azure::Bing::Mgmt::V2020_06_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_bing/lib
```

### Tag: package-2020-06-preview and ruby

These settings apply only when `--tag=package-2020-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-06-preview' && $(ruby)
namespace: "Azure::Bing::Mgmt::V2020_06_10_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_bing/lib
```
