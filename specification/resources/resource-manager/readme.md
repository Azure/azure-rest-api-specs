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
tag: package-policy-2018-05
```

``` yaml $(package-resources)
tag: package-resources-2018-05
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

### Tag: package-policy-2018-05
These settings apply only when `--tag=package-policy-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-policy-2018-05'
input-file:
- Microsoft.Authorization/stable/2018-05-01/policyAssignments.json
- Microsoft.Authorization/stable/2018-05-01/policyDefinitions.json
- Microsoft.Authorization/stable/2018-05-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2018-03
These settings apply only when `--tag=package-policy-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-policy-2018-03'
input-file:
- Microsoft.Authorization/stable/2018-03-01/policyAssignments.json
- Microsoft.Authorization/stable/2018-03-01/policyDefinitions.json
- Microsoft.Authorization/stable/2018-03-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
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

### Tag: package-pure-policy-2017-06
These settings apply only when `--tag=package-pure-policy-2017-06` is specified on the command line.

``` yaml $(tag) == 'package-pure-policy-2017-06'
input-file:
- Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
- Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json

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

### Tag: package-resources-2018-05
These settings apply only when `--tag=package-resources-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-resources-2018-05'
input-file:
- Microsoft.Resources/stable/2018-05-01/resources.json
```

### Tag: package-resources-2018-02
These settings apply only when `--tag=package-resources-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-resources-2018-02'
input-file:
- Microsoft.Resources/stable/2018-02-01/resources.json
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

### Tag: package-managedapplications-2018-06
These settings apply only when `--tag=package-managedapplications-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-managedapplications-2018-06'
input-file:
- Microsoft.Solutions/stable/2018-06-01/managedapplications.json
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

## Suppression
``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: policySetDefinitions.json
    where: $.paths
    reason: policy set definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyDefinitions.json
    where: $.paths
    reason: policy definition under an extension resource with Microsoft.Management
  - suppress: OperationsAPIImplementation
    from: policyAssignments.json
    where: $.paths
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policyDefinitions.json
    where: $.paths
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: policySetDefinitions.json
    where: $.paths
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.ResourceGroup.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.GenericResource.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.TagDetails.properties
    reason: TagDetails is a top level property
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.TagValue.properties
    reason: TagValue is a top level property
  - suppress: BodyTopLevelProperties
    from: managedapplications.json
    where: $.definitions.Appliance.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: managedapplications.json
    where: $.definitions.ApplianceDefinition.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: managedapplications.json
    where: $.definitions.AppliancePatchable.properties
    reason: managedBy is a top level property
  - suppress: BodyTopLevelProperties
    from: managedapplications.json
    where: $.definitions.GenericResource.properties
    reason: managedBy is a top level property
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#features
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#locks
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#policy
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#resources
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#subscriptions
      - python ./scripts/multiapi_init_gen.py azure-mgmt-resource#links
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
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
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2017-09
  - tag: package-policy-2018-05
  - tag: package-policy-2018-03
  - tag: package-policy-2017-06
  - tag: package-policy-2016-12
  - tag: package-policy-2016-04
  - tag: package-policy-2015-10
  - tag: package-resources-2018-05
  - tag: package-resources-2018-02
  - tag: package-resources-2017-05
  - tag: package-resources-2016-09
  - tag: package-resources-2016-02
  - tag: package-subscriptions-2016-06
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

### Tag: package-managedapplications-2018-06 and python

These settings apply only when `--tag=package-managedapplications-2018-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06' && $(python)
python:
  namespace: azure.mgmt.resource.managedapplications
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/managedapplications
```

### Tag: package-managedapplications-2017-09 and python

These settings apply only when `--tag=package-managedapplications-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(python)
python:
  namespace: azure.mgmt.resource.managedapplications
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/managedapplications
```

### Tag: package-policy-2018-05 and python

These settings apply only when `--tag=package-policy-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2018-05' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2018_05_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2018_05_01
```

### Tag: package-policy-2018-03 and python

These settings apply only when `--tag=package-policy-2018-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-policy-2018-03' && $(python)
python:
  namespace: azure.mgmt.resource.policy.v2018_03_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/policy/v2018_03_01
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

### Tag: package-resources-2018-05 and python

These settings apply only when `--tag=package-resources-2018-05 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-05' && $(python)
python:
  namespace: azure.mgmt.resource.resources.v2018_05_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_05_01
```

### Tag: package-resources-2018-02 and python

These settings apply only when `--tag=package-resources-2018-02 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-resources-2018-02' && $(python)
python:
  namespace: azure.mgmt.resource.resources.v2018_02_01
  output-folder: $(python-sdks-folder)/azure-mgmt-resource/azure/mgmt/resource/resources/v2018_02_01
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

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.resources
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-resources
```

### Java multi-api

Generate all API versions currently shipped for this package

```yaml $(java) && $(multiapi)
batch:
  - tag: package-features-2015-12
  - tag: package-locks-2016-09
  - tag: package-policy-2018-05
  - tag: package-policy-2018-03
  - tag: package-policy-2016-12
  - tag: package-resources-2018-02
  - tag: package-resources-2016-09
  - tag: package-subscriptions-2016-06
```

### Tag: package-features-2015-12 and java

These settings apply only when `--tag=package-features-2015-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-features-2015-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.features.v2015_12_01
  output-folder: $(azure-libraries-for-java-folder)/features/resource-manager/v2015_12_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Features"}'
```

### Tag: package-locks-2016-09 and java

These settings apply only when `--tag=package-locks-2016-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-locks-2016-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.locks.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/locks/resource-manager/v2016_09_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Locks"}'
```

### Tag: package-policy-2018-05 and java

These settings apply only when `--tag=package-policy-2018-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2018-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2018_05_01
  output-folder: $(azure-libraries-for-java-folder)/policy/resource-manager/v2018_05_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2018-03 and java

These settings apply only when `--tag=package-policy-2018-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2018-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2018_03_01
  output-folder: $(azure-libraries-for-java-folder)/policy/resource-manager/v2018_03_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-policy-2016-12 and java

These settings apply only when `--tag=package-policy-2016-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-policy-2016-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.policy.v2016_12_01
  output-folder: $(azure-libraries-for-java-folder)/policy/resource-manager/v2016_12_01
regenerate-manager: true
generate-interface: true
fconfig: '{"moduleName": "Policy"}'
directive:
  from: policyAssignments.json
  where: $.definitions.PolicyAssignmentProperties.properties.scope
  transform: $['x-ms-client-name'] = 'scopeProperty'
```

### Tag: package-resources-2018-02 and java

These settings apply only when `--tag=package-resources-2018-02 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2018-02' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2018_02_01
  output-folder: $(azure-libraries-for-java-folder)/resources/resource-manager/v2018_02_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-resources-2016-09 and java

These settings apply only when `--tag=package-resources-2016-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-resources-2016-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2016_09_01
  output-folder: $(azure-libraries-for-java-folder)/resources/resource-manager/v2016_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-subscriptions-2016-06 and java

These settings apply only when `--tag=package-subscriptions-2016-06--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(tag) == 'package-subscriptions-2016-06' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.resources.v2016_06_01
  output-folder: $(azure-libraries-for-java-folder)/resources/resource-manager/v2016_06_01
regenerate-manager: true
generate-interface: true
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
```
