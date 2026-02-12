## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_logic
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-05
  - tag: package-2018-07-preview
  - tag: package-2016-06
  - tag: package-2015-02-preview
```

### Tag: package-2019-05 and ruby

These settings apply only when `--tag=package-2019-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-05' && $(ruby)
namespace: "Azure::Logic::Mgmt::V2019-05-01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_logic/lib
```

### Tag: package-2018-07-preview and ruby

These settings apply only when `--tag=package-2018-07-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-07-preview' && $(ruby)
namespace: "Azure::Logic::Mgmt::V2018_07_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_logic/lib
```

### Tag: package-2016-06 and ruby

These settings apply only when `--tag=package-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-06' && $(ruby)
namespace: "Azure::Logic::Mgmt::V2016_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_logic/lib
```

### Tag: package-2015-02-preview and ruby

These settings apply only when `--tag=package-2015-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-02-preview' && $(ruby)
namespace: "Azure::Logic::Mgmt::V2015_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_logic/lib
```
