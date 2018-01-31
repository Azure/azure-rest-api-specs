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
tag: package-management-2017-11
```

### Tag: package-features-2015-12
These settings apply only when `--tag=package-features-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-features-2015-12'
input-file:
- Microsoft.Features/stable/2015-12-01/features.json
```

### Tag: package-locks-2016-09
These settings apply only when `--tag=package-locks-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-locks-2016-09'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
```

### Tag: package-locks-2015-01
These settings apply only when `--tag=package-locks-2015-01` is specified on the command line.

``` yaml $(tag) == 'package-locks-2015-01'
input-file:
- Microsoft.Authorization/stable/2015-01-01/locks.json
```

### Tag: package-policy-2017-06
These settings apply only when `--tag=package-policy-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2017-06'
input-file:
- Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
- Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-12
These settings apply only when `--tag=package-policy-2016-12` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-12'
input-file:
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2016-04
These settings apply only when `--tag=package-policy-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-policy-2016-04'
input-file:
- Microsoft.Authorization/stable/2016-04-01/policy.json
```

### Tag: package-policy-2015-10
These settings apply only when `--tag=package-policy-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-policy-2015-10'
input-file:
- Microsoft.Authorization/preview/2015-10-01-preview/policy.json
```

### Tag: package-resources-2017-05
These settings apply only when `--tag=package-resources-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-resources-2017-05'
input-file:
- Microsoft.Resources/stable/2017-05-10/resources.json
```

### Tag: package-resources-2016-09
These settings apply only when `--tag=package-resources-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-09'
input-file:
- Microsoft.Resources/stable/2016-09-01/resources.json
```

### Tag: package-resources-2016-07
These settings apply only when `--tag=package-resources-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-07'
input-file:
- Microsoft.Resources/stable/2016-07-01/resources.json
```

### Tag: package-resources-2016-02
These settings apply only when `--tag=package-resources-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-resources-2016-02'
input-file:
- Microsoft.Resources/stable/2016-02-01/resources.json
```

### Tag: package-resources-2015-11
These settings apply only when `--tag=package-resources-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-resources-2015-11'
input-file:
- Microsoft.Resources/stable/2015-11-01/resources.json
```

### Tag: package-subscriptions-2016-06
These settings apply only when `--tag=package-subscriptions-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2016-06'
input-file:
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
```

### Tag: package-subscriptions-2015-11
These settings apply only when `--tag=package-subscriptions-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2015-11'
input-file:
- Microsoft.Resources/stable/2015-11-01/subscriptions.json
```

### Tag: package-links-2016-09
These settings apply only when `--tag=package-links-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-links-2016-09'
input-file:
- Microsoft.Resources/stable/2016-09-01/links.json
```

### Tag: package-managedapplications-2017-09
These settings apply only when `--tag=package-managedapplications-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-managedapplications-2017-09'
input-file:
- Microsoft.Solutions/stable/2017-09-01/managedapplications.json
```

### Tag: package-managedapplications-2016-09
These settings apply only when `--tag=package-managedapplications-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-managedapplications-2016-09'
input-file:
- Microsoft.Solutions/preview/2016-09-01-preview/managedapplications.json
```

### Tag: package-management-2017-11
These settings apply only when `--tag=package-management-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-management-2017-11'
input-file:
- Microsoft.Management/preview/2017-11-01-preview/management.json
```

### Tag: package-management-2017-08
These settings apply only when `--tag=package-management-2017-08` is specified on the command line.

``` yaml $(tag) == 'package-management-2017-08'
input-file:
- Microsoft.Management/preview/2017-08-31-preview/management.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-go
```


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


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-features-2015-12
  - tag: package-locks-2016-09
  - tag: package-locks-2015-01
  - tag: package-policy-2017-06
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-07
  - tag: package-resources-2016-02
  - tag: package-resources-2015-11
  - tag: package-subscriptions-2016-06
  - tag: package-subscriptions-2015-11
  - tag: package-links-2016-09
  - tag: package-managedapplications-2016-09
  - tag: package-management-2017-11
  - tag: package-management-2017-08
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

### Tag: package-management-2017-11 and go

These settings apply only when `--tag=package-management-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-management-2017-11' && $(go)
namespace: management
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-11-01-preview/management
```

### Tag: package-management-2017-08 and go

These settings apply only when `--tag=package-management-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-management-2017-08' && $(go)
namespace: management
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-08-31-preview/management
```

## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: azure-mgmt-resource
  payload-flattening-threshold: 2
  clear-output-folder: true
  no-namespace-folders: true
  verbose: true
  debug: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-features-2015-12
  - tag: package-links-2016-09
  - tag: package-locks-2016-09
  - tag: package-locks-2015-01
  - tag: package-managedapplications-2017-09
  - tag: package-policy-2017-06
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-02
  - tag: package-subscriptions-2016-06
  - tag: package-management-2017-11
```

### Tag: package-features-2015-12 and python

These settings apply only when `--tag=package-features-2015-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(python)
python:
  namespace: azure.mgmt.resource.features.v2015_12_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/features/v2015_12_01
```

### Tag: package-links-2016-09 and python

These settings apply only when `--tag=package-links-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-links-2016-09' && $(python)
python:
  namespace: azure.mgmt.resource.links.v2016_09_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/links/v2016_09_01
```

### Tag: package-locks-2016-09 and python

These settings apply only when `--tag=package-locks-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-locks-2016-09' && $(python)
python:
  namespace: azure.mgmt.resource.locks.v2016_09_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/locks/v2016_09_01
```

### Tag: package-locks-2015-01 and python

These settings apply only when `--tag=package-locks-2015-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-locks-2015-01' && $(python)
python:
  namespace: azure.mgmt.resource.locks.v2015_01_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/locks/v2015_01_01
```

### Tag: package-managedapplications-2017-09 and python

These settings apply only when `--tag=package-managedapplications-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(python)
python:
  namespace: azure.mgmt.resource.managedapplications
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/managedapplications
```

### Tag: package-policy-2017-06 and python

These settings apply only when `--tag=package-policy-2017-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2017-06' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2017_06_01_preview
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2017_06_01_preview
```

### Tag: package-policy-2016-12 and python

These settings apply only when `--tag=package-policy-2016-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2016-12' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2016_12_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2016_12_01
```

### Tag: package-policy-2016-04 and python

These settings apply only when `--tag=package-policy-2016-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2016-04' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2016_04_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2016_04_01
```

### Tag: package-policy-2015-10 and python

These settings apply only when `--tag=package-policy-2015-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2015-10' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2015_10_01_preview
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2015_10_01_preview
```

### Tag: package-resources-2017-05 and python

These settings apply only when `--tag=package-resources-2017-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2017-05' && $(python)
python:
  namespace: azure.mgmt.resource.resources.v2017_05_10
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/resources/v2017_05_10
```

### Tag: package-resources-2016-09 and python

These settings apply only when `--tag=package-resources-2016-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-09' && $(python)
python:
  namespace: azure.mgmt.resource.resources.v2016_09_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_09_01
```

### Tag: package-resources-2016-02 and python

These settings apply only when `--tag=package-resources-2016-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2016-02' && $(python)
python:
  namespace: azure.mgmt.resource.resources.v2016_02_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/resources/v2016_02_01
```

### Tag: package-subscriptions-2016-06 and python

These settings apply only when `--tag=package-subscriptions-2016-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(python)
python:
  namespace: azure.mgmt.resource.subscriptions.v2016_06_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/subscriptions/v2016_06_01
```

### Tag: package-management-2017-11 and python

These settings apply only when `--tag=package-management-2017-11 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-management-2017-11' && $(python)
python:
  namespace: azure.mgmt.resource.managementgroups
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/managementgroups
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
