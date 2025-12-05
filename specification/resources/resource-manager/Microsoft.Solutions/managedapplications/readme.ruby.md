### Ruby multi-api for managedapplications

``` yaml $(multiapi) && $(managedapplications)
package-name: azure_mgmt_managed_applications
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-managedapplications-2019-07
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2017-09
  - tag: package-managedapplications-2016-09
```

### Tag: package-managedapplications-2019-07 and ruby

These settings apply only when `--tag=package-managedapplications-2019-07 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07' && $(ruby)
namespace: "Azure::ManagedApplications::Mgmt::V2019_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_managed_applications/lib
```

### Tag: package-managedapplications-2018-06 and ruby

These settings apply only when `--tag=package-managedapplications-2018-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06' && $(ruby)
namespace: "Azure::ManagedApplications::Mgmt::V2018_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_managed_applications/lib
```

### Tag: package-managedapplications-2017-09 and ruby

These settings apply only when `--tag=package-managedapplications-2017-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(ruby)
namespace: "Azure::ManagedApplications::Mgmt::V2017_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_managed_applications/lib
```

### Tag: package-managedapplications-2016-09 and ruby

These settings apply only when `--tag=package-managedapplications-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-managedapplications-2016-09' && $(ruby)
namespace: "Azure::ManagedApplications::Mgmt::V2016_09_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_managed_applications/lib
```