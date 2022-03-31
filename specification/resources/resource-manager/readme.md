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
tag: package-resources-2021-04
```

``` yaml $(package-privatelinks)
tag: package-privatelinks-2020-05
```

``` yaml $(package-features)
tag: package-features-2021-07
```

``` yaml $(package-locks)
tag: package-locks-2020-05
```

``` yaml $(package-policy)
tag: package-policy-2021-06
```

``` yaml $(package-resources)
tag: package-resources-2021-04
```

``` yaml $(package-subscriptions)
tag: package-subscriptions-2021-01
```

``` yaml $(package-links)
tag: package-links-2016-09
```

``` yaml $(package-managedapplications)
tag: package-managedapplications-2018-06
```

``` yaml $(package-deploymentscripts)
tag: package-deploymentscripts-2020-10
```

``` yaml $(package-templatespecs)
tag: package-templatespecs-2021-05
```

``` yaml $(package-changes)
tag: package-changes-2022-03
```

### Tag: package-changes-2022-03

These settings apply only when `--tag=package-changes-2022-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-changes-2022-03'
input-file:
- Microsoft.Resources/preview/2022-03-01-preview/changes.json
```

### Tag: package-policy-2021-06

These settings apply only when `--tag=package-policy-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-policy-2021-06'
input-file:
- Microsoft.Authorization/stable/2020-09-01/dataPolicyManifests.json
- Microsoft.Authorization/stable/2021-06-01/policyAssignments.json
- Microsoft.Authorization/stable/2021-06-01/policyDefinitions.json
- Microsoft.Authorization/stable/2021-06-01/policySetDefinitions.json
- Microsoft.Authorization/preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```

### Tag: package-privatelinks-2020-05

These settings apply only when `--tag=package-privatelinks-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-privatelinks-2020-05'
input-file:
- Microsoft.Authorization/stable/2020-05-01/privateLinks.json
```

### Tag: package-locks-2020-05

These settings apply only when `--tag=package-locks-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-locks-2020-05'
input-file:
- Microsoft.Authorization/stable/2020-05-01/locks.json
```


### Tag: package-resources-2021-04


These settings apply only when `--tag=package-resources-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-resources-2021-04'
input-file:
- Microsoft.Resources/stable/2021-04-01/resources.json
```

### Tag: package-policy-2020-09

These settings apply only when `--tag=package-policy-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-09'
input-file:
- Microsoft.Authorization/stable/2020-09-01/dataPolicyManifests.json
- Microsoft.Authorization/stable/2020-09-01/policyAssignments.json
- Microsoft.Authorization/stable/2020-09-01/policyDefinitions.json
- Microsoft.Authorization/stable/2020-09-01/policySetDefinitions.json
- Microsoft.Authorization/preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
```
### Tag: package-locks-2017-04

These settings apply only when `--tag=package-locks-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-locks-2017-04'
input-file:
- Microsoft.Authorization/stable/2017-04-01/locks.json
```


### Tag: package-preview-2020-08

These settings apply only when `--tag=package-preview-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-08'
input-file:
  - Microsoft.Solutions/preview/2020-08-21-preview/managedapplications.json
```


### Tag: package-subscriptions-2021-01

These settings apply only when `--tag=package-subscriptions-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2021-01'
input-file:
- Microsoft.Resources/stable/2021-01-01/subscriptions.json
```


### Tag: package-deploymentscripts-2020-10

These settings apply only when `--tag=package-deploymentscripts-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-deploymentscripts-2020-10'
input-file:
- Microsoft.Resources/stable/2020-10-01/deploymentScripts.json
```

### Tag: package-deploymentscripts-2019-10-preview

These settings apply only when `--tag=package-deploymentscripts-2019-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-deploymentscripts-2019-10-preview'
input-file:
- Microsoft.Resources/preview/2019-10-01-preview/deploymentScripts.json
```

### Tag: package-features-2021-07

These settings apply only when `--tag=package-features-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-features-2021-07'
input-file:
- Microsoft.Features/stable/2021-07-01/features.json
- Microsoft.Features/stable/2021-07-01/SubscriptionFeatureRegistration.json

# Needed when there is more than one input file
override-info:
  title: FeatureClient
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

### Tag: package-policy-2020-03

These settings apply only when `--tag=package-policy-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-policy-2020-03'
input-file:
- Microsoft.Authorization/stable/2020-03-01/policyAssignments.json
- Microsoft.Authorization/stable/2020-03-01/policyDefinitions.json
- Microsoft.Authorization/stable/2020-03-01/policySetDefinitions.json
- Microsoft.Authorization/preview/2020-07-01-preview/policyExemptions.json

# Needed when there is more than one input file
override-info:
  title: PolicyClient
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

### Tag: package-templatespecs-2021-05

These settings apply only when `--tag=package-templatespecs-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-templatespecs-2021-05'
input-file:
- Microsoft.Resources/stable/2021-05-01/templateSpecs.json
```

### Tag: package-templatespecs-2021-03-preview

These settings apply only when `--tag=package-templatespecs-2021-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-templatespecs-2021-03-preview'
input-file:
- Microsoft.Resources/preview/2021-03-01-preview/templateSpecs.json
```

### Tag: package-templatespecs-2019-06-preview

These settings apply only when `--tag=package-templatespecs-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-templatespecs-2019-06-preview'
input-file:
- Microsoft.Resources/preview/2019-06-01-preview/templateSpecs.json
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

### Tag: package-resources-2021-01

These settings apply only when `--tag=package-resources-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-resources-2021-01'
input-file:
- Microsoft.Resources/stable/2021-01-01/resources.json
```

### Tag: package-resources-2020-10

These settings apply only when `--tag=package-resources-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-resources-2020-10'
input-file:
  - Microsoft.Resources/stable/2020-10-01/resources.json
```

### Tag: package-resources-2020-08

These settings apply only when `--tag=package-resources-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-resources-2020-08'
input-file:
  - Microsoft.Resources/stable/2020-08-01/resources.json
```

### Tag: package-resources-2020-06

These settings apply only when `--tag=package-resources-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-resources-2020-06'
input-file:
- Microsoft.Resources/stable/2020-06-01/resources.json
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

### Tag: package-subscriptions-2020-01

These settings apply only when `--tag=package-subscriptions-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2020-01'
input-file:
  - Microsoft.Resources/stable/2020-01-01/subscriptions.json
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
    from: resources.json
    where: $.paths
    reason: route definitions under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyDefinitions.json
    where: $.paths
    reason: policy definition under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyAssignments.json
    where: $.paths
    reason: policy assignment under an extension resource with Microsoft.Management
  - suppress: UniqueResourcePaths
    from: policyExemptions.json
    where: $.paths
    reason: policy exemption under an extension resource with Microsoft.Management
  - suppress: OperationsAPIImplementation
    from: policyAssignments.json
    where: $.paths
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: OperationsAPIImplementation
    from: privateLinks.json
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
  - suppress: OperationsAPIImplementation
    from: policyExemptions.json
    where: $.paths
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: BodyTopLevelProperties
    from: policyExemptions.json
    where: $.definitions.PolicyExemption.properties
    reason: Currently systemData is not allowed
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
    reason: 'createdTime,changedTime & provisioningState are top-level properties'
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
    where: '$.paths["/subscriptions/{subscriptionId}/tagNames/{tagName}"].put'
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
  - from: deploymentScripts.json
    suppress: R3006
    where:
      - $.definitions.DeploymentScript.properties
      - $.definitions.AzureCliScript.properties
      - $.definitions.AzurePowerShellScript.properties
    reason: Currently systemData is not allowed
  - suppress: OperationsAPIImplementation
    from: templateSpecs.json
    where: $.paths
    reason: OperationsAPI will come from Resources
  - suppress: R3006
    from: templateSpecs.json
    where:
      - $.definitions.TemplateSpec.properties
      - $.definitions.TemplateSpecVersion.properties
      - $.definitions.TemplateSpecUpdateModel.properties
      - $.definitions.TemplateSpecVersionUpdateModel.properties
    reason: Currently systemData is not allowed
  - suppress: TrackedResourceListByImmediateParent
    from: templateSpecs.json
    where: $.definitions
    reason: Tooling issue
  - suppress: TrackedResourceListByResourceGroup
    from: templateSpecs.json
    where: $.definitions.TemplateSpecVersion
    reason: Tooling issue
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: dataPolicyManifests.json
    reason: operation APIs for Microsoft.Authorization are to be defined in RBAC swagger
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DataManifestCustomResourceFunctionDefinition.properties.allowCustomProperties
    from: dataPolicyManifests.json
    reason: 'This property can only have two values. '
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.DataPolicyManifestProperties.properties.isBuiltInOnly
    from: dataPolicyManifests.json
    reason: 'This property can only have two values. '
  - suppress: PageableOperation
    where: '$.paths["/providers/Microsoft.Authorization/dataPolicyManifests"].get'
    from: dataPolicyManifests.json
    reason: Pagination not supported. The size of the result list is pretty limited
  - suppress: DescriptionAndTitleMissing
    where: $.definitions.AliasPathMetadata
    from: resources.json
    reason: This was already checked in - not my code
  - suppress: XmsExamplesRequired
    where: $.paths
    from: resources.json
    reason: Pre-existing lint error. Not related to this version release.
  - suppress: TopLevelResourcesListByResourceGroup
    from: policyDefinitions.json
    reason: Policy definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: TopLevelResourcesListByResourceGroup
    from: policySetDefinitions.json
    reason: Policy set definitions are a proxy resource that is only usable on subscriptions or management groups
  - suppress: RequiredReadOnlySystemData
    from: privateLinks.json
    reason: We do not yet support system data
  - from: SubscriptionFeatureRegistration.json
    suppress: R4009
    reason: Currently systemData is not allowed
  - from: Subscriptions.json
    suppress: OperationsAPIImplementation
    reason: 'Duplicate Operations API causes generation issues'
  - suppress: TopLevelResourcesListByResourceGroup
    from: privateLinks.json
    reason: The resource is managed in a management group level (instead of inside a resource group)
  - suppress: TopLevelResourcesListBySubscription
    from: changes.json
    reason: We will be pushing customers to use Azure Resource Graph for those at scale scenarios. 
  - from: changes.json
    suppress: OperationsAPIImplementation
    where: $.paths
    reason: 'Duplicate Operations API causes generation issues'
  - suppress: RequiredReadOnlySystemData
    from: changes.json
    reason: System Metadata from a change resource perspective is irrelevant
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
```
## Python

See configuration in [readme.python.md](./readme.python.md)

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
  - package-deploymentscripts: true
  - package-templatespecs: true
  - package-changes: true
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

override-info:
  title: PolicyClient
```


