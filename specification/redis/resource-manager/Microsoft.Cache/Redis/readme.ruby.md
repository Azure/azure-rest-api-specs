## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_redis
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-10
  - tag: package-2017-02
  - tag: package-2016-04
  - tag: package-2015-08
```

### Tag: package-2017-10 and ruby

These settings apply only when `--tag=package-2017-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10' && $(ruby)
namespace: "Azure::Redis::Mgmt::V2017_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redis/lib
```

### Tag: package-2017-02 and ruby

These settings apply only when `--tag=package-2017-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-02' && $(ruby)
namespace: "Azure::Redis::Mgmt::V2017_02_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redis/lib
```

### Tag: package-2016-04 and ruby

These settings apply only when `--tag=package-2016-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-04' && $(ruby)
namespace: "Azure::Redis::Mgmt::V2016_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redis/lib
```

### Tag: package-2015-08 and ruby

These settings apply only when `--tag=package-2015-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-08' && $(ruby)
namespace: "Azure::Redis::Mgmt::V2015_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_redis/lib
```
