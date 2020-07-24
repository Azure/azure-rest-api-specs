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

### Ruby multi-api for subscriptions

``` yaml $(multiapi) && $(subscriptions)
package-name: azure_mgmt_subscriptions
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
  - tag: package-subscriptions-2015-11
```

### Tag: package-subscriptions-2019-06 and ruby

These settings apply only when `--tag=package-subscriptions-2019-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2019_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2018-06 and ruby

These settings apply only when `--tag=package-subscriptions-2018-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2018-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2018_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2016-06 and ruby

These settings apply only when `--tag=package-subscriptions-2016-06 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2016_06_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Tag: package-subscriptions-2015-11 and ruby

These settings apply only when `--tag=package-subscriptions-2015-11 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-subscriptions-2015-11' && $(ruby)
namespace: "Azure::Subscriptions::Mgmt::V2015_11_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_subscriptions/lib
```

### Ruby multi-api for features

``` yaml $(multiapi) && $(features)
package-name: azure_mgmt_features
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-features-2015-12
```

### Tag: package-features-2015-12 and ruby

These settings apply only when `--tag=package-features-2015-12 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(ruby)
namespace: "Azure::Features::Mgmt::V2015_12_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_features/lib
```

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

### Ruby multi-api for links

``` yaml $(multiapi) && $(links)
package-name: azure_mgmt_links
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-links-2016-09
```

### Tag: package-links-2016-09 and ruby

These settings apply only when `--tag=package-links-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-links-2016-09' && $(ruby)
namespace: "Azure::Links::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_links/lib
```

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