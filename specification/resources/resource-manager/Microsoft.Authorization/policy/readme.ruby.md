### Ruby multi-api for policy

``` yaml $(multiapi) && $(policy)
package-name: azure_mgmt_policy
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-pure-policy-2017-06
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
```

### Tag: package-pure-policy-2017-06 and ruby

These settings apply only when `--tag=package-pure-policy-2017-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-pure-policy-2017-06' && $(ruby)
namespace: "Azure::Policy::Mgmt::V2017_06_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_policy/lib
```

### Tag: package-policy-2016-12 and ruby

These settings apply only when `--tag=package-policy-2016-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-policy-2016-12' && $(ruby)
namespace: "Azure::Policy::Mgmt::V2016_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_policy/lib
```

### Tag: package-policy-2016-04 and ruby

These settings apply only when `--tag=package-policy-2016-04 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-policy-2016-04' && $(ruby)
namespace: "Azure::Policy::Mgmt::V2016_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_policy/lib
```

### Tag: package-policy-2015-10 and ruby

These settings apply only when `--tag=package-policy-2015-10 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-policy-2015-10' && $(ruby)
namespace: "Azure::Policy::Mgmt::V2015_10_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_policy/lib
```