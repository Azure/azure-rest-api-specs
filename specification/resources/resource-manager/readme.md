# Resource
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Resource.



---
## Getting Started 
To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Resource API.

``` yaml
openapi-type: arm
```

``` yaml $(package-features)
tag: package-features-2015-12
```

``` yaml $(package-locks)
tag: package-locks-2016-09
```

``` yaml $(package-policy)
tag: package-policy-2017-06
```

``` yaml $(package-resources)
tag: package-resources-2017-05
```

``` yaml $(package-subscriptions)
tag: package-subscriptions-2016-06
```

``` yaml $(package-subscriptionDefinitions)
tag: package-subscriptionDefinitions-2017-11-preview
```

``` yaml $(package-links)
tag: package-links-2016-09
```

``` yaml $(package-managedapplications)
tag: package-managedapplications-2016-09
```

``` yaml $(package-management)
tag: package-management-2017-08
```

### Tag: package-features-2015-12
These settings apply only when `--tag=package-features-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-features-2015-12'
input-file:
- Microsoft.Features/2015-12-01/features.json
```

### Tag: package-locks-2016-09
These settings apply only when `--tag=package-locks-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-locks-2016-09'
input-file:
- Microsoft.Authorization/2016-09-01/locks.json
```

### Tag: package-locks-2015-01
These settings apply only when `--tag=package-locks-2015-01` is specified on the command line.

``` yaml $(tag) == 'package-locks-2015-01'
input-file:
- Microsoft.Authorization/2015-01-01/locks.json
```

### Tag: package-policy-2017-06
These settings apply only when `--tag=package-policy-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2017-06'
input-file:
- Microsoft.Authorization/2017-06-01-preview/policyAssignments.json
- Microsoft.Authorization/2017-06-01-preview/policySetDefinitions.json
- Microsoft.Authorization/2016-12-01/policyDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-12
These settings apply only when `--tag=package-policy-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-12'
input-file:
- Microsoft.Authorization/2016-12-01/policyDefinitions.json
- Microsoft.Authorization/2016-12-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-04
These settings apply only when `--tag=package-policy-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-04'
input-file:
- Microsoft.Authorization/2016-04-01/policy.json
```

### Tag: package-policy-2015-10
These settings apply only when `--tag=package-policy-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-policy-2015-10'
input-file:
- Microsoft.Authorization/2015-10-01-preview/policy.json
```

### Tag: package-resources-2017-05
These settings apply only when `--tag=package-resources-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-resources-2017-05'
input-file:
- Microsoft.Resources/2017-05-10/resources.json
```

### Tag: package-resources-2016-09
These settings apply only when `--tag=package-resources-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-09'
input-file:
- Microsoft.Resources/2016-09-01/resources.json
```

### Tag: package-resources-2016-07
These settings apply only when `--tag=package-resources-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-07'
input-file:
- Microsoft.Resources/2016-07-01/resources.json
```

### Tag: package-resources-2016-02
These settings apply only when `--tag=package-resources-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-02'
input-file:
- Microsoft.Resources/2016-02-01/resources.json
```

### Tag: package-resources-2015-11
These settings apply only when `--tag=package-resources-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-resources-2015-11'
input-file:
- Microsoft.Resources/2015-11-01/resources.json
```

### Tag: package-subscriptions-2016-06
These settings apply only when `--tag=package-subscriptions-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2016-06'
input-file:
- Microsoft.Resources/2016-06-01/subscriptions.json
```

### Tag: package-subscriptions-2015-11
These settings apply only when `--tag=package-subscriptions-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2015-11'
input-file:
- Microsoft.Resources/2015-11-01/subscriptions.json
```

### Tag: package-subscriptionDefinitions-2017-11-preview
These settings apply only when `--tag=package-subscriptionDefinitions-2017-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-subscriptionDefinitions-2017-11-preview'
input-file:
- Microsoft.Subscription/2017-11-01-preview/subscriptionDefinitions.json
```

### Tag: package-links-2016-09
These settings apply only when `--tag=package-links-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-links-2016-09'
input-file:
- Microsoft.Resources/2016-09-01/links.json
```

### Tag: package-managedapplications-2016-09
These settings apply only when `--tag=package-managedapplications-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-managedapplications-2016-09'
input-file:
- Microsoft.Solutions/2016-09-01-preview/managedapplications.json
```

### Tag: package-management-2017-08
These settings apply only when `--tag=package-management-2017-08` is specified on the command line.

``` yaml $(tag) == 'package-management-2017-08'
input-file:
- Microsoft.Management/2017-08-31-preview/management.json
```

---
# Code Generation


## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  namespace: Microsoft.Azure.Management.ResourceManager
  license-header: MICROSOFT_MIT_NO_VERSION
  output-folder: $(csharp-sdks-folder)/Resource/Management.ResourceManager/Generated
batch:
  - package-features: true
    clear-output-folder: true # clear output folder on first run
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-subscriptionDefinitions: true  
  - package-links: true
  - package-management: true
#  - package-managedapplications: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-features-2015-12 and go

These settings apply only when `--tag=package-features-2015-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(go)
namespace: features
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-12-01/features
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

### Tag: package-policy-2017-06 and go

These settings apply only when `--tag=package-policy-2017-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-policy-2017-06' && $(go)
namespace: policy
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-06-01-preview/policy
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
output-folder: $(go-sdk-folder)/services/resources/mgmt/2015-10-01-preview/policy
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

### Tag: package-managedapplications-2016-09 and go

These settings apply only when `--tag=package-managedapplications-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2016-09' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2016-09-01-preview/managedapplications
```

### Tag: package-management-2017-08 and go

These settings apply only when `--tag=package-management-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-management-2017-08' && $(go)
namespace: management
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-08-31-preview/management
```


# Validation

Since this RP has no unique default package, iterate over all of them for validation:

``` yaml $(validation)
batch:
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-subscriptionDefinitions: true  
  - package-links: true
  - package-managedapplications: true
  - package-management: true
```
