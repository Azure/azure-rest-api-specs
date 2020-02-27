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
tag: package-policy-2019-09
```

``` yaml $(package-resources)
tag: package-resources-2019-10
```

``` yaml $(package-subscriptions)
tag: package-subscriptions-2019-11
```

``` yaml $(package-links)
tag: package-links-2016-09
```

``` yaml $(package-managedapplications)
tag: package-managedapplications-2018-06
```

``` yaml $(package-deploymentscripts)
tag: package-deploymentscripts-2019-10-preview
```

### Tag: package-deploymentscripts-2019-10-preview

These settings apply only when `--tag=package-deploymentscripts-2019-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-deploymentscripts-2019-10-preview'
input-file:
- Microsoft.Resources/preview/2019-10-01-preview/deploymentScripts.json
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

### Tag: package-policy-2019-09

These settings apply only when `--tag=package-policy-2019-09` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-09'
input-file:
- Microsoft.Authorization/stable/2019-09-01/policyAssignments.json
- Microsoft.Authorization/stable/2019-09-01/policyDefinitions.json
- Microsoft.Authorization/stable/2019-09-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2019-06

These settings apply only when `--tag=package-policy-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-06'
input-file:
- Microsoft.Authorization/stable/2019-06-01/policyAssignments.json
- Microsoft.Authorization/stable/2019-06-01/policyDefinitions.json
- Microsoft.Authorization/stable/2019-06-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-policy-2019-01

These settings apply only when `--tag=package-policy-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-policy-2019-01'
input-file:
- Microsoft.Authorization/stable/2019-01-01/policyAssignments.json
- Microsoft.Authorization/stable/2019-01-01/policyDefinitions.json
- Microsoft.Authorization/stable/2019-01-01/policySetDefinitions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
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

### Tag: package-resources-2019-10

These settings apply only when `--tag=package-resources-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-10'
input-file:
- Microsoft.Resources/stable/2019-10-01/resources.json
```

### Tag: package-resources-2019-08

These settings apply only when `--tag=package-resources-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-08'
input-file:
- Microsoft.Resources/stable/2019-08-01/resources.json
```

### Tag: package-resources-2019-07

These settings apply only when `--tag=package-resources-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-07'
input-file:
- Microsoft.Resources/stable/2019-07-01/resources.json
```

### Tag: package-resources-2019-0510

These settings apply only when `--tag=package-resources-2019-0510` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-0510'
input-file:
- Microsoft.Resources/stable/2019-05-10/resources.json
```

### Tag: package-resources-2019-05

These settings apply only when `--tag=package-resources-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-05'
input-file:
- Microsoft.Resources/stable/2019-05-01/resources.json
```

### Tag: package-resources-2019-03

These settings apply only when `--tag=package-resources-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-resources-2019-03'
input-file:
- Microsoft.Resources/stable/2019-03-01/resources.json
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

### Tag: package-subscriptions-2019-11

These settings apply only when `--tag=package-subscriptions-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2019-11'
input-file:
- Microsoft.Resources/stable/2019-11-01/subscriptions.json
```

### Tag: package-subscriptions-2019-06

These settings apply only when `--tag=package-subscriptions-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2019-06'
input-file:
- Microsoft.Resources/stable/2019-06-01/subscriptions.json
```

### Tag: package-subscriptions-2018-06

These settings apply only when `--tag=package-subscriptions-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2018-06'
input-file:
- Microsoft.Resources/stable/2018-06-01/subscriptions.json
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

### Tag: package-managedapplications-2019-07

These settings apply only when `--tag=package-managedapplications-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-managedapplications-2019-07'
input-file:
- Microsoft.Solutions/stable/2019-07-01/managedapplications.json
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
  - suppress: UniqueResourcePaths
    from: policyAssignments.json
    where: $.paths
    reason: policy assignment under an extension resource with Microsoft.Management
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
    where: $.definitions.GenericResourceExpanded.properties
    reason: createdTime,changedTime & provisioningState are top-level properties
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.TagDetails.properties
    reason: TagDetails is a top level property
  - suppress: BodyTopLevelProperties
    from: resources.json
    where: $.definitions.TagValue.properties
    reason: TagValue is a top level property
  - suppress: RequiredPropertiesMissingInResourceModel
    from: resources.json
    where: $.definitions.TagValue
    reason: TagValue will be deprecated soon
  - suppress: RequiredPropertiesMissingInResourceModel
    from: resources.json
    where: $.definitions.TagDetails
    reason: TagDetails will be deprecated soon
  - suppress: XmsResourceInPutResponse
    from: resources.json
    where: $.paths["/subscriptions/{subscriptionId}/tagNames/{tagName}"].put
    reason: TagDetails is not an Azure resource
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
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation 
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation 
    where: $.definitions.AzureCliScript
    reason: Tooling issue.
  - from: deploymentScripts.json
    suppress: TrackedResourceGetOperation 
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - from: deploymentScripts.json
    suppress: TrackedResourcePatchOperation 
    where: $.definitions.AzurePowerShellScript
    reason: Tooling issue
  - from: deploymentScripts.json
    suppress: OperationsAPIImplementation
    where: $.paths
    reason: OperationsAPI will come from Resources
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
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

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

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

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Authorization/stable/2016-09-01/locks.json
- Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
- Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
- Microsoft.Resources/stable/2016-06-01/subscriptions.json
- Microsoft.Resources/stable/2018-05-01/resources.json
```

## Multi-API/Profile support for AutoRest v3 generators

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Resources/preview/2019-10-01-preview/deploymentScripts.json
  - $(this-folder)/Microsoft.Features/stable/2015-12-01/features.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-09-01/locks.json
  - $(this-folder)/Microsoft.Authorization/stable/2015-01-01/locks.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-09-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-09-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-09-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-06-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-06-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-06-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-01-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-01-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2019-01-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-05-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2018-03-01/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-06-01-preview/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/preview/2017-06-01-preview/policySetDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
  - $(this-folder)/Microsoft.Authorization/stable/2016-04-01/policy.json
  - $(this-folder)/Microsoft.Authorization/preview/2015-10-01-preview/policy.json
  - $(this-folder)/Microsoft.Resources/stable/2019-10-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-08-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-07-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-05-10/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-05-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-03-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2018-05-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2018-02-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2017-05-10/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-09-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-07-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2016-02-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2015-11-01/resources.json
  - $(this-folder)/Microsoft.Resources/stable/2019-11-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2019-06-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2018-06-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2016-06-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2015-11-01/subscriptions.json
  - $(this-folder)/Microsoft.Resources/stable/2016-09-01/links.json
  - $(this-folder)/Microsoft.Solutions/stable/2019-07-01/managedapplications.json
  - $(this-folder)/Microsoft.Solutions/stable/2018-06-01/managedapplications.json
  - $(this-folder)/Microsoft.Solutions/stable/2017-09-01/managedapplications.json
  - $(this-folder)/Microsoft.Solutions/preview/2016-09-01-preview/managedapplications.json

```

If there are files that should not be in the `all-api-versions` set,
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```
