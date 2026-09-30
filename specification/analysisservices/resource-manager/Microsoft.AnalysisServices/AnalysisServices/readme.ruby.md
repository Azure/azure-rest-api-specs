## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_analysis_services
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2017-08
  - tag: package-2017-08-beta
  - tag: package-2017-07
  - tag: package-2016-05
```

### Tag: package-2017-08 and ruby

These settings apply only when `--tag=package-2017-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08' && $(ruby)
namespace: "Azure::AnalysisServices::Mgmt::V2017_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_analysis_services/lib
```

### Tag: package-2017-08-beta and ruby

These settings apply only when `--tag=package-2017-08-beta --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-08-beta' && $(ruby)
namespace: "Azure::AnalysisServices::Mgmt::V2017_08_01_beta"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_analysis_services/lib
```

### Tag: package-2017-07 and ruby

These settings apply only when `--tag=package-2017-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-07' && $(ruby)
namespace: "Azure::AnalysisServices::Mgmt::V2017_07_14"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_analysis_services/lib
```

### Tag: package-2016-05 and ruby

These settings apply only when `--tag=package-2016-05 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-05' && $(ruby)
namespace: "Azure::AnalysisServices::Mgmt::V2016_05_16"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_analysis_services/lib
```
