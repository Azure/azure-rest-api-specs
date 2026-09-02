### Ruby multi-api for subscriptions

``` yaml $(multiapi) && $(subscriptions)
package-name: azure_mgmt_subscriptions
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
  - tag: package-subscriptions-2015-11
```

### Tag: package-subscriptions-2019-06 and ruby

These settings apply only when `--tag=package-subscriptions-2019-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2019_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2018-06 and ruby

These settings apply only when `--tag=package-subscriptions-2018-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2018-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2018_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2016-06 and ruby

These settings apply only when `--tag=package-subscriptions-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2016_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2015-11 and ruby

These settings apply only when `--tag=package-subscriptions-2015-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2015-11' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2015_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```
