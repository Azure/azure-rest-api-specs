## Go

These settings apply only when `--go` is specified on the command line.

### Fix up regular expressions to support Unicode.

``` yaml 
directive:
  from: swagger-document # do it globally
  where: $.paths..parameters[?(@.name == "resourceGroupName" || @.name == "sourceResourceGroupName")].pattern
  set: ^[-\p{L}\._\(\)\w]+$ 
  reason: Necessary to match Unicode characters in the Go regexp engine.
```

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(package-resources) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resources/armresources
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-templatespecs-2019-06-preview
  - tag: package-features-2015-12
  - tag: package-features-2021-07
  - tag: package-locks-2016-09
  - tag: package-locks-2015-01
  - tag: package-policy-2021-06
  - tag: package-policy-2020-09
  - tag: package-policy-2020-03
  - tag: package-policy-2019-09
  - tag: package-policy-2019-06
  - tag: package-policy-2019-01
  - tag: package-policy-2018-05
  - tag: package-policy-2018-03
  - tag: package-policy-2017-06
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
  - tag: package-resources-2021-01
  - tag: package-resources-2020-10
  - tag: package-resources-2020-06
  - tag: package-resources-2019-10
  - tag: package-resources-2019-05
  - tag: package-resources-2019-03
  - tag: package-resources-2018-05
  - tag: package-resources-2018-02
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-07
  - tag: package-resources-2016-02
  - tag: package-resources-2015-11
  - tag: package-subscriptions-2021-01
  - tag: package-subscriptions-2019-11
  - tag: package-subscriptions-2019-06
  - tag: package-subscriptions-2018-06
  - tag: package-subscriptions-2016-06
  - tag: package-subscriptions-2015-11
  - tag: package-links-2016-09
  - tag: package-managedapplications-2019-07
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2017-09
  - tag: package-managedapplications-2016-09
  - tag: package-resources-2019-07
```

### Tag: package-templatespecs-2019-06-preview and go

These settings apply only when `--tag=package-templatespecs-2019-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-templatespecs-2019-06-preview' && $(go)
namespace: templatespecs
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2019-06-01-preview/$(namespace)
```

### Tag: package-resources-2019-07 and go

These settings apply only when `--tag=package-resources-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2019-07' && $(go)
namespace: features
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-07-01/$(namespace)
```

### Tag: package-features-2021-07 and go

These settings apply only when `--tag=package-features-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-features-2021-07' && $(go)
namespace: features
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-07-01/$(namespace)
```

### Tag: package-features-2015-12 and go

These settings apply only when `--tag=package-features-2015-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(go)
namespace: features
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-12-01/$(namespace)
```

### Tag: package-locks-2016-09 and go

These settings apply only when `--tag=package-locks-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-locks-2016-09' && $(go)
namespace: locks
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-09-01/locks
```

### Tag: package-locks-2015-01 and go

These settings apply only when `--tag=package-locks-2015-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-locks-2015-01' && $(go)
namespace: locks
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-01-01/locks
```

### Tag: package-policy-2021-06 and go

These settings apply only when `--tag=package-policy-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2021-06' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2021-06-01-preview/policy
```

### Tag: package-policy-2020-09 and go

These settings apply only when `--tag=package-policy-2020-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2020-09' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2020-09-01-preview/policy
```

### Tag: package-policy-2019-09 and go

These settings apply only when `--tag=package-policy-2019-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2019-09' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-09-01/policy
```

### Tag: package-policy-2020-03 and go

These settings apply only when `--tag=package-policy-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2020-03' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2020-03-01-preview/policy
```

### Tag: package-policy-2019-06 and go

These settings apply only when `--tag=package-policy-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2019-06' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-06-01/policy
```

### Tag: package-policy-2019-01 and go

These settings apply only when `--tag=package-policy-2019-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2019-01' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-01-01/policy
```

### Tag: package-policy-2018-05 and go

These settings apply only when `--tag=package-policy-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2018-05' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-05-01/policy
```

### Tag: package-policy-2018-03 and go

These settings apply only when `--tag=package-policy-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2018-03' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-03-01/policy
```

### Tag: package-policy-2017-06 and go

These settings apply only when `--tag=package-policy-2017-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2017-06' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2017-06-01-preview/policy
```

### Tag: package-policy-2016-12 and go

These settings apply only when `--tag=package-policy-2016-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2016-12' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-12-01/policy
```

### Tag: package-policy-2016-04 and go

These settings apply only when `--tag=package-policy-2016-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2016-04' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-04-01/policy
```

### Tag: package-policy-2015-10 and go

These settings apply only when `--tag=package-policy-2015-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2015-10' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2015-10-01-preview/policy
```

### Tag: package-resources-2021-01 and go

These settings apply only when `--tag=package-resources-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2021-01' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-01-01/resources
```

### Tag: package-resources-2020-10 and go

These settings apply only when `--tag=package-resources-2020-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2020-10' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2020-10-01/resources
```

### Tag: package-resources-2020-06 and go

These settings apply only when `--tag=package-resources-2020-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2020-06' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2020-06-01/resources
```

### Tag: package-resources-2019-10 and go

These settings apply only when `--tag=package-resources-2019-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2019-10' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-10-01/resources
```

### Tag: package-resources-2019-05 and go

These settings apply only when `--tag=package-resources-2019-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2019-05' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-05-01/resources
```

### Tag: package-resources-2019-03 and go

These settings apply only when `--tag=package-resources-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2019-03' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-03-01/resources
```

### Tag: package-resources-2018-05 and go

These settings apply only when `--tag=package-resources-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2018-05' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-05-01/resources
```

### Tag: package-resources-2018-02 and go

These settings apply only when `--tag=package-resources-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2018-02' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-02-01/resources
```

### Tag: package-resources-2017-05 and go

These settings apply only when `--tag=package-resources-2017-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2017-05' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-05-10/resources
```

### Tag: package-resources-2016-09 and go

These settings apply only when `--tag=package-resources-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2016-09' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-09-01/resources
```

### Tag: package-resources-2016-07 and go

These settings apply only when `--tag=package-resources-2016-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2016-07' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-07-01/resources
```

### Tag: package-resources-2016-02 and go

These settings apply only when `--tag=package-resources-2016-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2016-02' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-02-01/resources
```

### Tag: package-resources-2015-11 and go

These settings apply only when `--tag=package-resources-2015-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-resources-2015-11' && $(go)
namespace: resources
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-11-01/resources
```

### Tag: package-subscriptions-2021-01 and go

These settings apply only when `--tag=package-subscriptions-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2021-01' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-01-01/subscriptions
```

### Tag: package-subscriptions-2019-11 and go

These settings apply only when `--tag=package-subscriptions-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-11' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-11-01/subscriptions
```

### Tag: package-subscriptions-2019-06 and go

These settings apply only when `--tag=package-subscriptions-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2019-06' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-06-01/subscriptions
```

### Tag: package-subscriptions-2018-06 and go

These settings apply only when `--tag=package-subscriptions-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2018-06' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-06-01/subscriptions
```

### Tag: package-subscriptions-2016-06 and go

These settings apply only when `--tag=package-subscriptions-2016-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-06-01/subscriptions
```

### Tag: package-subscriptions-2015-11 and go

These settings apply only when `--tag=package-subscriptions-2015-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-subscriptions-2015-11' && $(go)
namespace: subscriptions
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-11-01/subscriptions
```

### Tag: package-links-2016-09 and go

These settings apply only when `--tag=package-links-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-links-2016-09' && $(go)
namespace: links
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-09-01/links
```

### Tag: package-managedapplications-2019-07 and go

These settings apply only when `--tag=package-managedapplications-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-07-01/managedapplications
```

### Tag: package-managedapplications-2018-06 and go

These settings apply only when `--tag=package-managedapplications-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-06-01/managedapplications
```

### Tag: package-managedapplications-2017-09 and go

These settings apply only when `--tag=package-managedapplications-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-09-01/managedapplications
```

### Tag: package-managedapplications-2016-09 and go

These settings apply only when `--tag=package-managedapplications-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2016-09' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/preview/resources/mgmt/2016-09-01-preview/managedapplications
```