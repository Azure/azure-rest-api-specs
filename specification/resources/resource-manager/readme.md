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
  - package-links: true
  - package-management: true
#  - package-managedapplications: true
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
  - package-links: true
  - package-managedapplications: true
  - package-management: true
```
