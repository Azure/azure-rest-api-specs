## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_stor_simple8000_series
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-06
```

### Tag: package-2017-06 and ruby

These settings apply only when `--tag=package-2017-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-06' && $(ruby)
namespace: "Azure::StorSimple8000Series::Mgmt::V2017_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_stor_simple8000_series/lib
```
