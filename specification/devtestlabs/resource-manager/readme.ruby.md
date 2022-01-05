## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_devtestlabs
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-09
  - tag: package-2016-05
```

### Tag: package-2018-09 and ruby

These settings apply only when `--tag=package-2018-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-09' && $(ruby)
namespace: "Azure::DevTestLabs::Mgmt::V2018_09_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_devtestlabs/lib
```

### Tag: package-2016-05 and ruby

These settings apply only when `--tag=package-2016-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-05' && $(ruby)
namespace: "Azure::DevTestLabs::Mgmt::V2016_05_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_devtestlabs/lib
```
