### Ruby multi-api for features

``` yaml $(multiapi) && $(features)
package-name: azure_mgmt_features
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-features-2021-07
  - tag: package-features-2015-12
```

### Tag: package-features-2021-07 and ruby

These settings apply only when `--tag=package-features-2021-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-features-2021-07' && $(ruby)
namespace: "Azure::Features::Mgmt::V2021_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_features/lib
```

### Tag: package-features-2015-12 and ruby

These settings apply only when `--tag=package-features-2015-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(ruby)
namespace: "Azure::Features::Mgmt::V2015_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_features/lib
```
