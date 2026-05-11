## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_event_grid
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-01
```

### Tag: package-2018-01 and ruby

These settings apply only when `--tag=package-2018-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-01' && $(ruby)
namespace: "Azure::EventGrid::V2018_01_01"
output-folder: $(ruby-sdks-folder)/data/azure_event_grid/lib
```
