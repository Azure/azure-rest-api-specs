# ContainerInstance

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerInstance.

---

## Getting Started

To build the SDK for ContainerInstance, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ContainerInstance API.

``` yaml
openapi-type: arm
tag: package-2026-07-01
```

### Tag: package-preview-2026-09

These settings apply only when `--tag=package-preview-2026-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-09'
input-file:
  - ./preview/2026-09-01-preview/containerInstance.json
directive:
  - suppress: OperationsApiResponseSchema
    from: containerInstance.json
    where:
      - $.paths["/providers/Microsoft.ContainerInstance/operations"].get.responses["200"].schema
    reason: The operations endpoint retains the provider's published OperationListResult response shape; replacing it with the common-types shape would change the generated SDK contract.
  - suppress: OperationsApiSchemaUsesCommonTypes
    from: containerInstance.json
    where:
      - $.paths["/providers/Microsoft.ContainerInstance/operations"].get.responses["200"].schema["$ref"]
    reason: The operations endpoint intentionally references the provider's legacy OperationListResult model to preserve the published response and SDK contract.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs"].get.responses["200"].schema.properties
    reason: This endpoint returns log content for one container and is a resource action, not a collection GET; the list heuristic is triggered by the legacy ListLogs operation name.
  - suppress: ProvisioningStateMustBeReadOnly
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}"].patch.responses["200"].schema
    reason: Each referenced resource model defines provisioningState as read-only in TypeSpec; the validator does not follow the response schema reference to the nested read-only property.
  - suppress: LroErrorContent
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].patch.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/aiAgentsGroups/{aiAgentsGroupName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/restart"].post.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/start"].post.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].patch.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/managedVirtualNodePools/{managedVirtualNodePoolName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default"].delete.responses.default.schema["$ref"]
    reason: These long-running operations retain the provider's published CloudError response; changing the error envelope would break the existing wire and generated SDK contract.
  - suppress: ResourceNameRestriction
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/attach"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/exec"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/outboundNetworkDependenciesEndpoints"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/restart"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default"]
    reason: These legacy name parameters intentionally preserve the service's published unconstrained name contract; adding a pattern would introduce a new client-side restriction for existing operations.
  - suppress: PatchIdentityProperty
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].patch.parameters[4]
    reason: The legacy container group PATCH operation updates the published ContainerGroupUpdate shape, which does not support identity updates; adding identity would change the existing patch contract.
  - suppress: UnSupportedPatchProperties
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].patch.parameters[4]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}"].patch.parameters[4]
    reason: These PATCH request shapes preserve published legacy fields; removing location or provisioningState from the emitted request models would change existing SDK model shapes.
  - suppress: DeleteResponseCodes
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/providers/Microsoft.ContainerInstance/serviceAssociationLinks/default"].delete
    reason: These legacy long-running delete operations document the response codes implemented by the service; removing the existing 200 response would change the published wire contract.
  - suppress: DeleteResponseBodyEmpty
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"].delete.responses["200"].schema
    reason: The service's published container group delete operation can return the deleted resource in its 200 response; removing that schema would change the wire and SDK contract.
  - suppress: XmsPageableForListCalls
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/outboundNetworkDependenciesEndpoints"].get
    reason: These GET operations are resource actions returning log content or network dependencies, not pageable collection-list operations; their legacy operation names trigger the list heuristic.
  - suppress: PostResponseCodes
    from: containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/restart"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}/restart"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/ngroups/{ngroupsName}/start"].post
    reason: These legacy actions preserve the response-code behavior already implemented and published by the service; changing the codes would alter the wire contract.
  - suppress: DescriptionMustNotBeNodeName
    from: containerInstance.json
    where:
      - $.definitions.AzureFileShareAccessType["x-ms-enum"].values[0].description
      - $.definitions.AzureFileShareAccessType["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupIpAddressType["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupIpAddressType["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupNetworkProtocol["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupNetworkProtocol["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupPriority["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupPriority["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[2].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[3].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[4].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[5].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[6].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[7].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[8].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[9].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[10].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[11].description
      - $.definitions.ContainerGroupProvisioningState["x-ms-enum"].values[12].description
      - $.definitions.ContainerGroupRestartPolicy["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupRestartPolicy["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupRestartPolicy["x-ms-enum"].values[2].description
      - $.definitions.ContainerGroupSku["x-ms-enum"].values[0].description
      - $.definitions.ContainerGroupSku["x-ms-enum"].values[1].description
      - $.definitions.ContainerGroupSku["x-ms-enum"].values[2].description
      - $.definitions.ContainerGroupSku["x-ms-enum"].values[3].description
      - $.definitions.ContainerInstanceOperationsOrigin["x-ms-enum"].values[0].description
      - $.definitions.ContainerInstanceOperationsOrigin["x-ms-enum"].values[1].description
      - $.definitions.ContainerNetworkProtocol["x-ms-enum"].values[0].description
      - $.definitions.ContainerNetworkProtocol["x-ms-enum"].values[1].description
      - $.definitions.FileShareProperties.properties.shareAccessTier["x-ms-enum"].values[0].description
      - $.definitions.FileShareProperties.properties.shareAccessTier["x-ms-enum"].values[1].description
      - $.definitions.FileShareProperties.properties.shareAccessTier["x-ms-enum"].values[2].description
      - $.definitions.FileShareProperties.properties.shareAccessTier["x-ms-enum"].values[3].description
      - $.definitions.GpuSku["x-ms-enum"].values[0].description
      - $.definitions.GpuSku["x-ms-enum"].values[1].description
      - $.definitions.GpuSku["x-ms-enum"].values[2].description
      - $.definitions.IdentityAccessLevel["x-ms-enum"].values[0].description
      - $.definitions.IdentityAccessLevel["x-ms-enum"].values[1].description
      - $.definitions.IdentityAccessLevel["x-ms-enum"].values[2].description
      - $.definitions.IpAddress.properties.autoGeneratedDomainNameLabelScope["x-ms-enum"].values[0].description
      - $.definitions.IpAddress.properties.autoGeneratedDomainNameLabelScope["x-ms-enum"].values[1].description
      - $.definitions.IpAddress.properties.autoGeneratedDomainNameLabelScope["x-ms-enum"].values[2].description
      - $.definitions.IpAddress.properties.autoGeneratedDomainNameLabelScope["x-ms-enum"].values[3].description
      - $.definitions.IpAddress.properties.autoGeneratedDomainNameLabelScope["x-ms-enum"].values[4].description
      - $.definitions.LogAnalyticsLogType["x-ms-enum"].values[0].description
      - $.definitions.LogAnalyticsLogType["x-ms-enum"].values[1].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[0].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[1].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[2].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[3].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[4].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[5].description
      - $.definitions.NGroupProvisioningState["x-ms-enum"].values[6].description
      - $.definitions.NGroupUpdateMode["x-ms-enum"].values[0].description
      - $.definitions.NGroupUpdateMode["x-ms-enum"].values[1].description
      - $.definitions.OperatingSystemTypes["x-ms-enum"].values[0].description
      - $.definitions.OperatingSystemTypes["x-ms-enum"].values[1].description
      - $.definitions.ResourceIdentityType["x-ms-enum"].values[0].description
      - $.definitions.ResourceIdentityType["x-ms-enum"].values[1].description
      - $.definitions.ResourceIdentityType["x-ms-enum"].values[2].description
      - $.definitions.ResourceIdentityType["x-ms-enum"].values[3].description
      - $.definitions.Scheme["x-ms-enum"].values[0].description
      - $.definitions.Scheme["x-ms-enum"].values[1].description
    reason: These enum descriptions are part of the generated legacy contract carried forward into this preview; changing them is outside the ManagedVirtualNodePool scope, so suppression is limited to the exact existing description nodes.
  - suppress: AvoidAdditionalProperties
    from: containerInstance.json
    where:
      - $.definitions.LogAnalytics.properties.metadata
      - $.definitions.Volume.properties.secret
      - $.definitions.Volume.properties.secretReference
    reason: These properties are published string dictionaries whose arbitrary keys are part of the service contract; replacing them with fixed-property models would be a breaking change.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: containerInstance.json
    where:
      - $.definitions.OperationListResult
      - $.definitions.CachedImagesListResult
      - $.definitions.CapabilitiesListResult
      - $.definitions.UsageListResult
      - $.definitions.Logs
      - $.definitions.NetworkDependenciesResponse
    reason: These schemas are collection or action response payloads rather than ARM resource models, so resource envelope properties id, name, and type do not apply.
  - suppress: ArmResourcePropertiesBag
    from: containerInstance.json
    where:
      - $.definitions.ContainerGroup
      - $.definitions.ContainerGroupProfile
    reason: The nested sku properties are part of the published resource-specific properties contract; renaming or moving them would break existing clients.
```

### Tag: package-preview-2026-08

These settings apply only when `--tag=package-preview-2026-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-08'
input-file:
  - ./preview/2026-08-01-preview/containerInstance.json
directive:
  - suppress: AvoidAdditionalProperties
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ArmResourcePropertiesBag
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DeleteResponseBodyEmpty
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DeleteResponseCodes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DescriptionMustNotBeNodeName
    reason: These enum value descriptions are carried forward from the existing service contract.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean shapes in this generated OpenAPI are carried forward from earlier preview and stable API contracts. Changing them to string enums in this preview version would be a breaking contract change.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This TypeSpec project intentionally continues to emit ARM common-types v5 for compatibility with the service's existing API shapes. Moving the entire service to v6 is outside the scope of this preview.
  - suppress: LocationMustHaveXmsMutability
    reason: This generated swagger preserves legacy custom and proxy resource shapes for backward compatibility. Changing location mutability here would alter the existing contract.
  - suppress: LroErrorContent
    reason: The long-running operations on this provider use the existing CloudError shape, consistent with the prior stable API versions of this service. Switching to the standard ErrorResponse envelope from common-types v2+ would be a breaking change versus the published stable API.
  - suppress: OperationsApiResponseSchema
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: OperationsApiSchemaUsesCommonTypes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: PatchIdentityProperty
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: PostResponseCodes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design - the property carries readOnly via the referenced enum schema (use-read-only-status-schema), and the TypeSpec source uses @visibility(Lifecycle.Read). The LintDiff rule does not follow $ref to detect the readOnly flag. Surfacing readOnly on the property reference would be inconsistent with prior API versions of this provider.
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ResourceNameRestriction
    reason: These path parameter shapes are carried forward from the existing service contract.
  - suppress: SchemaDescriptionOrTitle
    reason: This preview version preserves the existing generated schema shape carried forward from the 2026-07-01 stable API version.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: This preview version preserves the existing operation text carried forward from the 2026-07-01 stable API version.
  - suppress: UnSupportedPatchProperties
    reason: This preview version preserves the existing patch contract carried forward from the 2026-07-01 stable API version.
  - suppress: XmsIdentifierValidation
    reason: This preview version preserves the existing generated pageable shape carried forward from the 2026-07-01 stable API version.
  - suppress: XmsPageableForListCalls
    reason: This preview version preserves the existing list contract carried forward from the 2026-07-01 stable API version.
```

### Tag: package-2026-07-01

These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - ./stable/2026-07-01/containerInstance.json
directive:
  - suppress: AvoidAdditionalProperties
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ArmResourcePropertiesBag
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DeleteResponseBodyEmpty
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DeleteResponseCodes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DescriptionMustNotBeNodeName
    reason: These enum value descriptions are carried forward from the existing service contract.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean shapes in this generated OpenAPI are carried forward from earlier preview and stable API contracts. Changing them to string enums in this stable version would be a breaking contract change.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This TypeSpec project intentionally continues to emit ARM common-types v5 for compatibility with the service's existing API shapes. Moving the entire service to v6 is outside the scope of this fix.
  - suppress: LocationMustHaveXmsMutability
    reason: This generated swagger preserves legacy custom and proxy resource shapes for backward compatibility. Changing location mutability here would alter the existing contract.
  - suppress: LroErrorContent
    reason: The long-running operations in this stable version continue to use the service's existing CloudError shape for backward compatibility.
  - suppress: OperationsApiResponseSchema
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: OperationsApiSchemaUsesCommonTypes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: PatchIdentityProperty
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: PostResponseCodes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design and is carried forward from the existing generated contract.
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ResourceNameRestriction
    reason: These path parameter shapes are carried forward from the existing service contract.
  - suppress: SchemaDescriptionOrTitle
    reason: This stable version preserves the existing generated schema shape carried forward from preview.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: This stable version preserves the existing operation text carried forward from preview.
  - suppress: UnSupportedPatchProperties
    reason: This stable version preserves the existing patch contract carried forward from preview.
  - suppress: XmsIdentifierValidation
    reason: This stable version preserves the existing generated pageable shape carried forward from preview.
  - suppress: XmsPageableForListCalls
    reason: This stable version preserves the existing list contract carried forward from preview.
```

### Tag: package-2025-09-01

These settings apply only when `--tag=package-2025-09-01` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01'
input-file:
  - ./stable/2025-09-01/containerInstance.json
```

### Tag: package-preview-2026-06-01

These settings apply only when `--tag=package-preview-2026-06-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-06-01'
input-file:
  - ./preview/2026-06-01-preview/containerInstance.json
directive:
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design - the property carries readOnly via the referenced enum schema (use-read-only-status-schema), and the TypeSpec source uses @visibility(Lifecycle.Read). The LintDiff rule does not follow $ref to detect the readOnly flag. Surfacing readOnly on the property reference would be inconsistent with prior API versions of this provider.
  - suppress: LroErrorContent
    reason: The long-running operations on this provider use the existing CloudError shape, consistent with the prior 2025-09-01 stable API version of this service. Switching to the standard ErrorResponse envelope from common-types v2+ would be a breaking change versus the published stable API.
```

### Tag: package-preview-2024-11

These settings apply only when `--tag=package-preview-2024-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11'
input-file:
  - ./preview/2024-11-01-preview/containerInstance.json
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - ./preview/2024-10-01-preview/containerInstance.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - ./preview/2024-09-01-preview/containerInstance.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - ./preview/2024-05-01-preview/containerInstance.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - ./stable/2023-05-01/containerInstance.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-02'
input-file:
  - ./preview/2023-02-01-preview/containerInstance.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - ./preview/2022-10-01-preview/containerInstance.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - ./stable/2022-09-01/containerInstance.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - ./stable/2021-10-01/containerInstance.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - ./stable/2021-09-01/containerInstance.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - ./stable/2021-07-01/containerInstance.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - ./stable/2021-03-01/containerInstance.json
```

### Tag: package-2020-11

These settings apply only when `--tag=package-2020-11` is specified on the command line.

``` yaml $(tag) == 'package-2020-11'
input-file:
  - ./stable/2020-11-01/containerInstance.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
  - ./stable/2019-12-01/containerInstance.json
```

### Tag: package-2018-10

These settings apply only when `--tag=package-2018-10` is specified on the command line.

``` yaml $(tag) == 'package-2018-10'
input-file:
- ./stable/2018-10-01/containerInstance.json
```

### Tag: package-2018-09

These settings apply only when `--tag=package-2018-09` is specified on the command line.

``` yaml $(tag) == 'package-2018-09'
input-file:
- ./stable/2018-09-01/containerInstance.json
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-2018-06'
input-file:
- ./stable/2018-06-01/containerInstance.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-2018-04'
input-file:
- ./stable/2018-04-01/containerInstance.json
```

### Tag: package-2018-02-preview

These settings apply only when `--tag=package-2018-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-preview'
input-file:
- ./preview/2018-02-01-preview/containerInstance.json
```

### Tag: package-2017-12-preview

These settings apply only when `--tag=package-2017-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-preview'
input-file:
- ./preview/2017-12-01-preview/containerInstance.json
```

### Tag: package-2017-10-preview

These settings apply only when `--tag=package-2017-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-preview'
input-file:
- ./preview/2017-10-01-preview/containerInstance.json
```

### Tag: package-2017-08-preview

These settings apply only when `--tag=package-2017-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-preview'
input-file:
- ./preview/2017-08-01-preview/containerInstance.json
```

## Suppression

``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: containerInstance.json
    reason: false positive, see https://github.com/Azure/azure-openapi-validator/issues/176
suppressions:
  - code: AvoidAdditionalProperties
    reason: Using additionalProperties type as the object is user-defined and not subject to any validations at RP level.
    from:
      - containerInstance.json
    where:
      - $.definitions.ConfigMap.properties.keyValuePairs
  - code: AvoidAdditionalProperties
    reason: additional feature addition to existing secretVolumes which is defined as a dictionary
    from:
      - containerInstance.json
    where:
      - $.definitions.SecretReferenceVolume
  - code: GetCollectionResponseSchema
    reason: We do not return the instanceView property in our List operation, we just return this
            property for our Get operations. This change has been part of our stable api versions for a couple of years
    from:
      - containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/containerGroups"]
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
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_container_instance']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
