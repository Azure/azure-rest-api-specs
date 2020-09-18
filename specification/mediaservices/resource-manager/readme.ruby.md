## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_media_services
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2018-07
  - tag: package-2018-06-preview
  - tag: package-2018-03-preview
  - tag: package-2015-10
```

### Tag: package-2018-07 and ruby

These settings apply only when `--tag=package-2018-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-07' && $(ruby)
namespace: "Azure::MediaServices::Mgmt::V2018_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_media_services/lib
```


### Tag: package-2018-06-preview and ruby

These settings apply only when `--tag=package-2018-06-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(ruby)
namespace: "Azure::MediaServices::Mgmt::V2018_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_media_services/lib
```

### Tag: package-2018-03-preview and ruby

These settings apply only when `--tag=package-2018-03-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2018-03-preview' && $(ruby)
namespace: "Azure::MediaServices::Mgmt::V2018_03_30_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_media_services/lib
```

### Tag: package-2015-10 and ruby

These settings apply only when `--tag=package-2015-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-10' && $(ruby)
namespace: "Azure::MediaServices::Mgmt::V2015_10_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_media_services/lib
```
