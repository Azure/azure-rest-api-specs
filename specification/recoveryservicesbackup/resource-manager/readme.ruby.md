## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_recovery_services_backup
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-06
  - tag: package-2016-08
  - tag: package-2016-12
  - tag: package-2017-07-only
```

### Tag: package-2016-06 and ruby

These settings apply only when `--tag=package-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-06' && $(ruby)
namespace: "Azure::RecoveryServicesBackup::Mgmt::V2016_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_recovery_services_backup/lib
```

### Tag: package-2016-08 and ruby

These settings apply only when `--tag=package-2016-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-08' && $(ruby)
namespace: "Azure::RecoveryServicesBackup::Mgmt::V2016_08_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_recovery_services_backup/lib
```

### Tag: package-2016-12 and ruby

These settings apply only when `--tag=package-2016-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-12' && $(ruby)
namespace: "Azure::RecoveryServicesBackup::Mgmt::V2016_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_recovery_services_backup/lib
```

### Tag: package-2017-07-only and ruby

These settings apply only when `--tag=package-2017-07-only --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2017-07-only' && $(ruby)
namespace: "Azure::RecoveryServicesBackup::Mgmt::V2017_07_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_recovery_services_backup/lib
```