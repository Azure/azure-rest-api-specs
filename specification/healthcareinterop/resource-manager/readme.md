# healthcareinterop

> see https://aka.ms/autorest

This is the AutoRest configuration file for healthcareinterop.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for healthcareinterop.

```yaml
title: HealthcareInterop
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-01-preview
```

### Tag: package-2025-06-01-preview

These settings apply only when `--tag=package-2025-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01-preview'
input-file:
  - Microsoft.HealthcareInterop/cloud/preview/2025-06-01-preview/cloud.json
  - Microsoft.HealthcareInterop/edge/preview/2025-06-01-preview/edge.json
suppressions:
  - code: AvoidAnonymousTypes
    from: cloud.json
    where: $.definitions["Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate"].properties.userAssignedIdentities.additionalProperties
    reason: (GitHub Issue 747) Rule AvoidAnonymousTypes raises a false-positive error on UserAssignedIdentity generated from TypeSpec.
  - code: PatchBodyParametersSchema
    from: cloud.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareInterop/fhirQueryEventBatchChannels/{fhirQueryEventBatchChannelName}"].patch.parameters[4].schema.properties.properties
    reason: There are properties (connectorType, emrSystem, triggerType) used as discriminators to support polymorphic resource definitions. The discriminators need to be provided during PATCH to allow updates on certain polymorphic resource properties.
  - code: PatchBodyParametersSchema
    from: cloud.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareInterop/fhirQueryFlatFileBatchChannels/{fhirQueryFlatFileBatchChannelName}"].patch.parameters[4].schema.properties.properties
    reason: There are properties (connectorType, emrSystem, triggerType) used as discriminators to support polymorphic resource definitions. The discriminators need to be provided during PATCH to allow updates on certain polymorphic resource properties.
  - code: PatchBodyParametersSchema
    from: cloud.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareInterop/dicomDirectChannels/{dicomDirectChannelName}"].patch.parameters[4].schema.properties.properties
    reason: There are properties (connectorType) used as discriminators to support polymorphic resource definitions. The discriminators need to be provided during PATCH to allow updates on certain polymorphic resource properties.
```

### Tag: package-2025-05-01-preview

These settings apply only when `--tag=package-2025-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01-preview'
input-file:
  - Microsoft.HealthcareInterop/cloud/preview/2025-05-01-preview/cloud.json
  - Microsoft.HealthcareInterop/edge/preview/2025-05-01-preview/edge.json
suppressions:
  - code: AvoidAnonymousTypes
    from: cloud.json
    where: $.definitions["Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate"].properties.userAssignedIdentities.additionalProperties
    reason: (GitHub Issue 747) Rule AvoidAnonymousTypes raises a false-positive error on UserAssignedIdentity generated from TypeSpec.
  - code: PatchBodyParametersSchema
    from: cloud.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareInterop/fhirQueryEventBatchChannels/{fhirQueryEventBatchChannelName}"].patch.parameters[4].schema.properties.properties
    reason: There are properties (connectorType, emrSystem, triggerType) used as discriminators to support polymorphic resource definitions. The discriminators need to be provided during PATCH to allow updates on certain polymorphic resource properties.
  - code: PatchBodyParametersSchema
    from: cloud.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HealthcareInterop/fhirQueryFlatFileBatchChannels/{fhirQueryFlatFileBatchChannelName}"].patch.parameters[4].schema.properties.properties
    reason: There are properties (connectorType, emrSystem, triggerType) used as discriminators to support polymorphic resource definitions. The discriminators need to be provided during PATCH to allow updates on certain polymorphic resource properties.
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)
