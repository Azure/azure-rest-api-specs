## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_cognitive_services
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2016-02-preview
```

### Tag: package-2017-04 and ruby

These settings apply only when `--tag=package-2017-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-04' && $(ruby)
namespace: "Azure::CognitiveServices::Mgmt::V2017_04_18"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cognitive_services/lib
```

### Tag: package-2016-02-preview and ruby

These settings apply only when `--tag=package-2016-02-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-02-preview' && $(ruby)
namespace: "Azure::CognitiveServices::Mgmt::V2016_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_cognitive_services/lib
```
