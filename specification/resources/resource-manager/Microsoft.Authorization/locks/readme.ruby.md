### Ruby multi-api for locks

``` yaml $(multiapi) && $(locks)
package-name: azure_mgmt_locks
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-locks-2016-09
  - tag: package-locks-2015-01
```

### Tag: package-locks-2016-09 and ruby

These settings apply only when `--tag=package-locks-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-locks-2016-09' && $(ruby)
namespace: "Azure::Locks::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_locks/lib
```

### Tag: package-locks-2015-01 and ruby

These settings apply only when `--tag=package-locks-2015-01 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-locks-2015-01' && $(ruby)
namespace: "Azure::Locks::Mgmt::V2015_01_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_locks/lib
```