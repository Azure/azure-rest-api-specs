## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_iot_hub
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-07
  - tag: package-2017-01
  - tag: package-2016-02
```

### Tag: package-2017-07 and ruby

These settings apply only when `--tag=package-2017-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-07' && $(ruby)
namespace: "Azure::IotHub::Mgmt::V2017_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_iot_hub/lib
```

### Tag: package-2017-01 and ruby

These settings apply only when `--tag=package-2017-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-01' && $(ruby)
namespace: "Azure::IotHub::Mgmt::V2017_01_19"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_iot_hub/lib
```

### Tag: package-2016-02 and ruby

These settings apply only when `--tag=package-2016-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-02' && $(ruby)
namespace: "Azure::IotHub::Mgmt::V2016_02_03"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_iot_hub/lib
```
