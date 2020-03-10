## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_search
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-08
  - tag: package-2020-03
```

### Tag: package-2015-08 and ruby

These settings apply only when `--tag=package-2015-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-08' && $(ruby)
namespace: "Azure::Search::Mgmt::V2015_08_19"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_search/lib
```

### Tag: package-2020-03 and ruby

These settings apply only when `--tag=package-2020-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2020-03' && $(ruby)
namespace: "Azure::Search::Mgmt::V2020_03_13"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_search/lib
```