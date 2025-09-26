## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_recovery_services_site_recovery
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2016-08
```

### Tag: package-2016-08 and ruby

These settings apply only when `--tag=package-2016-08 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-08' && $(ruby)
namespace: "Azure::RecoveryServicesSiteRecovery::Mgmt::V2016_08_10"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_recovery_services_site_recovery/lib
```
