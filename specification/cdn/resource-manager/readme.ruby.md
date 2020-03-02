## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_cdn
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2017-10
  - tag: package-2017-04
  - tag: package-2016-10
  - tag: package-2016-04
  - tag: package-2015-06
```

### Tag: package-2019-06 and ruby

These settings apply only when `--tag=package-2019-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-06' && $(ruby)
namespace: "Azure::CDN::Mgmt::V2019_06_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```

### Tag: package-2019-04 and ruby

These settings apply only when `--tag=package-2019-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-04' && $(ruby)
namespace: "Azure::CDN::Mgmt::V2019_04_15"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```

### Tag: package-2017-10 and ruby

These settings apply only when `--tag=package-2017-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-10' && $(ruby)
namespace: "Azure::CDN::Mgmt::V2017_10_12"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```


### Tag: package-2017-04 and ruby

These settings apply only when `--tag=package-2017-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04' && $(ruby)
namespace: "Azure::CDN::Mgmt::V2017_04_02"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```

### Tag: package-2016-10 and ruby

These settings apply only when `--tag=package-2016-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-10'  && $(ruby)
namespace: "Azure::CDN::Mgmt::V2016_10_02"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```

### Tag: package-2016-04 and ruby

These settings apply only when `--tag=package-2016-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-04'  && $(ruby)
namespace: "Azure::CDN::Mgmt::V2016_04_02"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```

### Tag: package-2015-06 and ruby

These settings apply only when `--tag=package-2015-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-06' && $(ruby)
namespace: "Azure::CDN::Mgmt::V2015_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cdn/lib
```
