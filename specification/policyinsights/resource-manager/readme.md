# PolicyInsights

> see https://aka.ms/autorest

This is the AutoRest configuration file for PolicyInsights.

---

## Getting Started

To build the SDK for PolicyInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the PolicyInsights API.

``` yaml
title: PolicyInsightsClient
openapi-type: arm
tag: package-2022-03
```

### Validations

Run validations when `--validate` is specified on command line

``` yaml $(validate)
azure-validator: true
semantic-validator: true
model-validator: true
message-format: json
```

### Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    reason: The data type in store is boolean. If we change the type in RP, it will break existing clients, and we will incur runtime conversion cost.
    where:
      - $.definitions.PolicyEvent.properties.isCompliant
      - $.definitions.PolicyState.properties.isCompliant

  - suppress: NonApplicationJsonType
    reason: ODATA $metadata endpoint for each resource type returns metadata document as XML.
    where:
      - $.paths["/{scope}/providers/Microsoft.PolicyInsights/policyEvents/$metadata"].get.produces[0]
      - $.paths["/{scope}/providers/Microsoft.PolicyInsights/policyStates/$metadata"].get.produces[0]

  - suppress: OperationIdNounConflictingModelNames
    reason: Metadata is already in plural form.
    where:
      - $.paths["/providers/Microsoft.PolicyInsights/policyMetadata/{resourceName}"].get.operationId
      - $.paths["/providers/Microsoft.PolicyInsights/policyMetadata"].get.operationId

  - suppress: PageableOperation
    reason: The operations API is not pagable.
    where:
      - $.paths["/providers/Microsoft.PolicyInsights/operations"].get

  - suppress: PostOperationIdContainsUrlVerb
    reason: The operation can be performed at multiple scopes. The operationId needs to indicate the scope.
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions"].post.operationId
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions"].post.operationId

  - suppress: BodyTopLevelProperties
    from: attestations.json
    where: $.definitions.Attestation.properties
    reason: systemData is now a required top level property

  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    from: policyEvents.json
    reason: unnecessary check

  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    from: policyStates.json
    reason: unnecessary check

  - suppress: MISSING_REQUIRED_PARAMETER
    from: policyEvents.json
    reason: unnecessary check

  - suppress: MISSING_REQUIRED_PARAMETER
    from: policyStates.json
    reason: unnecessary check

```

``` yaml !$(python)
directive:
  - from: policyEvents.json
    where: $
    transform: delete $['x-ms-paths']
    reason: other languages which still use track1 does not support remove '/' for 'next_link'

  - from: policyStates.json
    where: $
    transform: delete $['x-ms-paths']
    reason: other languages which still use track1 does not support remove '/' for 'next_link'

  - from: policyEvents.json
    where:
      - $.path["/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/{resourceId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults"]
    transform: delete $['post']['x-ms-pageable']['operationName']

  - from: policyStates.json
    where:
      - $.path["/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/{resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
      - $.path["/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults"]
    transform: delete $['post']['x-ms-pageable']['operationName']
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2021-10-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
- Microsoft.PolicyInsights/stable/2022-03-01/checkPolicyRestrictions.json
- Microsoft.PolicyInsights/stable/2021-01-01/attestations.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2021-10-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
- Microsoft.PolicyInsights/stable/2020-07-01/checkPolicyRestrictions.json
- Microsoft.PolicyInsights/stable/2021-01-01/attestations.json
```
### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2019-07-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
- Microsoft.PolicyInsights/stable/2020-07-01/checkPolicyRestrictions.json
- Microsoft.PolicyInsights/stable/2021-01-01/attestations.json
```

### Tag: package-2020-07

These settings apply only when `--tag=package-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-2020-07'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2019-07-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
- Microsoft.PolicyInsights/stable/2020-07-01/checkPolicyRestrictions.json
```

### Tag: package-2020-07-preview

These settings apply only when `--tag=package-2020-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-preview'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2019-07-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
- Microsoft.PolicyInsights/preview/2020-07-01-preview/checkPolicyRestrictions.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/stable/2019-07-01/remediations.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyEvents.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyStates.json
- Microsoft.PolicyInsights/stable/2019-10-01/policyMetadata.json
```

### Tag: package-2018-07

These settings apply only when `--tag=package-2018-07` is specified on the command line.

``` yaml $(tag) == 'package-2018-07'
input-file:
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyTrackedResources.json
- Microsoft.PolicyInsights/preview/2018-07-01-preview/remediations.json
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyEvents.json
- Microsoft.PolicyInsights/preview/2018-07-01-preview/policyStates.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-2018-04'
input-file:
- Microsoft.PolicyInsights/stable/2018-04-04/policyEvents.json
- Microsoft.PolicyInsights/stable/2018-04-04/policyStates.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.PolicyInsights
  output-folder: $(csharp-sdks-folder)/policyinsights/Microsoft.Azure.Management.PolicyInsights/src/Generated
  clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.policyinsights
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-policyinsights
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2022-03
  - tag: package-2021-10
  - tag: package-2021-01
  - tag: package-2020-07
  - tag: package-2019-10
  - tag: package-2018-07
  - tag: package-2018-04
```

### Tag: package-2022-03 and java

These settings apply only when `--tag=package-2022-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2022-03' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2022_03_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2022_03_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-10 and java

These settings apply only when `--tag=package-2021-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-10' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2021_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2021_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2021-01 and java

These settings apply only when `--tag=package-2021-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2021-01' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2021_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2021_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2020-07 and java

These settings apply only when `--tag=package-2020-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2020-07' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2020_07_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2020_07_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-10 and java

These settings apply only when `--tag=package-2019-10 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2019_10_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2019_10_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-07 and java

These settings apply only when `--tag=package-2018-07 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-07' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2018_07_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2018_07_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-04 and java

These settings apply only when `--tag=package-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-04' && $(java)
java:
  namespace: com.microsoft.azure.management.policyinsights.v2018_04_04
  output-folder: $(azure-libraries-for-java-folder)/sdk/policyinsights/mgmt-v2018_04_04
regenerate-manager: true
generate-interface: true
```
