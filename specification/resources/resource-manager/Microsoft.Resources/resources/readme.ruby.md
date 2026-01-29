### Ruby multi-api for resources

``` yaml $(multiapi) && $(resources)
package-name: azure_mgmt_resources
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-resources-2019-03
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-07
  - tag: package-resources-2016-02
```

### Tag: package-resources-2019-03 and ruby

These settings apply only when `--tag=package-resources-2019-03 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-resources-2019-03' && $(ruby)
namespace: "Azure::Resources::Mgmt::V2019_03_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources/lib
```

### Tag: package-resources-2017-05 and ruby

These settings apply only when `--tag=package-resources-2017-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-resources-2017-05' && $(ruby)
namespace: "Azure::Resources::Mgmt::V2017_05_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources/lib
```

### Tag: package-resources-2016-09 and ruby

These settings apply only when `--tag=package-resources-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-resources-2016-09' && $(ruby)
namespace: "Azure::Resources::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources/lib
```

### Tag: package-resources-2016-07 and ruby

These settings apply only when `--tag=package-resources-2016-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-resources-2016-07' && $(ruby)
namespace: "Azure::Resources::Mgmt::V2016_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources/lib
```

### Tag: package-resources-2016-02 and ruby

These settings apply only when `--tag=package-resources-2016-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-resources-2016-02' && $(ruby)
namespace: "Azure::Resources::Mgmt::V2016_02_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_resources/lib
```