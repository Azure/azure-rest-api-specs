import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DevCenter;

@@clientName(Microsoft.DevCenter, "DevCenterMgmtClient", "python");

@@clientName(Microsoft.DevCenter.DevCenterProjectCatalogSettings,
  "ProjectCatalogSettingsInfo",
  "go"
);

@@clientName(Microsoft.DevCenter.DevCenterSku, "SkuInfo", "go");

@@clientName(Microsoft.DevCenter.UserRoleAssignment, "UserRoleAssignmentValue");

@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentity,
  "CustomerManagedKeyEncryptionKeyIdentity",
  "java"
);

@@clientName(Microsoft.DevCenter.KeyEncryptionKeyIdentity,
  "DevCenterKeyEncryptionKeyIdentity",
  "csharp"
);

@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "IdentityType",
  "java"
);

@@alternateType(Microsoft.DevCenter.OperationStatus.properties,
  unknown,
  "java"
);

// Keep project-level operations in their original interfaces for C#
// to avoid resource name collisions with devcenters-level resources.
// AttachedNetwork: prevent merge of project ops into devcenters AttachedNetworks
@@clientLocation(AttachedNetworkConnections.getByProject, AttachedNetworkConnections, "csharp");
@@clientLocation(AttachedNetworkConnections.listByProject, AttachedNetworkConnections, "csharp");

// DevBoxDefinition: prevent merge of project ops into devcenters DevBoxDefinitions
@@clientLocation(DevBoxDefinitionOperationGroup.getByProject, DevBoxDefinitionOperationGroup, "csharp");
@@clientLocation(DevBoxDefinitionOperationGroup.listByProject, DevBoxDefinitionOperationGroup, "csharp");

// Image: prevent merge of project ops into devcenters Images
@@clientLocation(ImageOperationGroup.getByProject, ImageOperationGroup, "csharp");
@@clientLocation(ImageOperationGroup.listByProject, ImageOperationGroup, "csharp");

// ImageVersion: prevent merge of project ops into devcenters ImageVersions
@@clientLocation(ImageVersionOperationGroup.getByProject, ImageVersionOperationGroup, "csharp");
@@clientLocation(ImageVersionOperationGroup.listByProject, ImageVersionOperationGroup, "csharp");

// EnvironmentDefinition: prevent merge of devcenters ops into project EnvironmentDefinitions
@@clientLocation(EnvironmentDefinitionOperationGroup.get, EnvironmentDefinitionOperationGroup, "csharp");
@@clientLocation(EnvironmentDefinitionOperationGroup.listByCatalog, EnvironmentDefinitionOperationGroup, "csharp");
@@clientLocation(EnvironmentDefinitionOperationGroup.getErrorDetails, EnvironmentDefinitionOperationGroup, "csharp");

// Resource model renames for C# to match baseline SDK names
@@clientName(Pool, "DevCenterPool", "csharp");
@@clientName(Project, "DevCenterProject", "csharp");
@@clientName(NetworkConnection, "DevCenterNetworkConnection", "csharp");
@@clientName(EnvironmentType, "DevCenterEnvironmentType", "csharp");
@@clientName(Gallery, "DevCenterGallery", "csharp");
@@clientName(Schedule, "DevCenterSchedule", "csharp");
@@clientName(HealthCheckStatusDetails, "HealthCheckStatusDetail", "csharp");
@@clientName(ProjectEnvironmentType, "DevCenterProjectEnvironment", "csharp");

// autorest.md migration: rename-mapping, format-by-name-rules, prepend-rp-prefix
@@clientName(DevCenterSku, "DevCenterSkuDetails", "csharp");
@@alternateType(GalleryProperties.galleryResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(AttachedNetworkConnectionProperties.networkConnectionId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(NetworkConnectionUpdateProperties.subnetId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ProjectUpdateProperties.devCenterId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ProjectEnvironmentTypeUpdateProperties.deploymentTargetId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ImageReference.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(DevCenterSku.resourceType, Azure.Core.armResourceType, "csharp");
@@clientName(EnvironmentTypeEnableStatus.Enabled, "IsEnabled", "csharp");
@@clientName(EnvironmentTypeEnableStatus.Disabled, "IsDisabled", "csharp");
@@clientName(HibernateSupport.Enabled, "IsEnabled", "csharp");
@@clientName(HibernateSupport.Disabled, "IsDisabled", "csharp");
@@clientName(LocalAdminStatus.Enabled, "IsEnabled", "csharp");
@@clientName(LocalAdminStatus.Disabled, "IsDisabled", "csharp");
@@clientName(ScheduleEnableStatus.Enabled, "IsEnabled", "csharp");
@@clientName(ScheduleEnableStatus.Disabled, "IsDisabled", "csharp");
@@clientName(StopOnDisconnectEnableStatus.Enabled, "IsEnabled", "csharp");
@@clientName(StopOnDisconnectEnableStatus.Disabled, "IsDisabled", "csharp");
@@alternateType(AttachedNetworkConnectionProperties.networkConnectionLocation, Azure.Core.azureLocation, "csharp");
@@clientName(DomainJoinType.HybridAzureADJoin, "HybridAadJoin", "csharp");
@@clientName(DomainJoinType.AzureADJoin, "AadJoin", "csharp");
@@clientName(ImageVersionProperties.osDiskImageSizeInGb, "OSDiskImageSizeInGB", "csharp");
@@clientName(ImageVersionProperties.excludeFromLatest, "IsExcludedFromLatest", "csharp");
@@clientName(ImageVersionProperties.name, "NamePropertiesName", "csharp");
@@alternateType(DevCenterProperties.devCenterUri, url, "csharp");
@@alternateType(ProjectProperties.devCenterUri, url, "csharp");
@@alternateType(ImageDefinitionBuildTask.logUri, url, "csharp");
@@clientName(Capability, "DevCenterCapability", "csharp");
@@clientName(CatalogListResult, "DevCenterCatalogListResult", "csharp");
@@clientName(Catalog, "DevCenterCatalog", "csharp");
@@clientName(EndpointDetail, "DevCenterEndpointDetail", "csharp");
@@clientName(EnvironmentRole, "DevCenterEnvironmentRole", "csharp");
@@clientName(GitCatalog, "DevCenterGitCatalog", "csharp");
@@clientName(HealthCheck, "DevCenterHealthCheck", "csharp");
@@clientName(HealthCheckStatus, "DevCenterHealthCheckStatus", "csharp");
@@clientName(HealthStatus, "DevCenterHealthStatus", "csharp");
@@clientName(HealthStatusDetail, "DevCenterHealthStatusDetail", "csharp");
@@clientName(HibernateSupport, "DevCenterHibernateSupport", "csharp");
@@clientName(Image, "DevCenterImage", "csharp");
@@clientName(ImageListResult, "DevCenterImageListResult", "csharp");
@@clientName(ImageReference, "DevCenterImageReference", "csharp");
@@clientName(LicenseType, "DevCenterLicenseType", "csharp");
@@clientName(OperationStatus, "DevCenterOperationStatus", "csharp");
@@clientName(ProvisioningState, "DevCenterProvisioningState", "csharp");
@@clientName(ResourceRange, "DevCenterResourceRange", "csharp");
@@clientName(ScheduledType, "DevCenterScheduledType", "csharp");
@@clientName(ScheduledFrequency, "DevCenterScheduledFrequency", "csharp");
@@clientName(ScheduleEnableStatus, "DevCenterScheduleEnableStatus", "csharp");
@@clientName(TrackedResourceUpdate, "DevCenterTrackedResourceUpdate", "csharp");
@@clientName(UsageName, "DevCenterUsageName", "csharp");
@@clientName(UsageUnit, "DevCenterUsageUnit", "csharp");
@@clientName(CatalogSyncState, "DevCenterCatalogSyncState", "csharp");

// Manual: directive-based renames from autorest.md
@@clientName(ScheduleUpdateProperties.`type`, "ScheduledType", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.OperationStatusResult.id, Azure.Core.armResourceIdentifier, "csharp");

// Manual: UserRoleAssignment C#-specific rename (overrides unscoped "UserRoleAssignmentValue")
@@clientName(UserRoleAssignment, "DevCenterUserRoleAssignments", "csharp");

// Manual: override-operation-name from autorest.md
@@clientName(OperationStatusesOperationGroup.get, "GetDevCenterOperationStatus", "csharp");
@@clientName(UsagesOperationGroup.listByLocation, "GetDevCenterUsagesByLocation", "csharp");
@@clientName(CheckNameAvailabilityOperationGroup.execute, "CheckDevCenterNameAvailability", "csharp");
@@clientName(SkusOperationGroup.listBySubscription, "GetDevCenterSkusBySubscription", "csharp");
@@clientName(NetworkConnections.listOutboundNetworkDependenciesEndpoints, "GetOutboundEnvironmentEndpoints", "csharp");

// AZC naming violations: rename types with forbidden suffixes
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest, "DevCenterNameAvailabilityContent", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse, "DevCenterNameAvailabilityResult", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(CheckScopedNameAvailabilityRequest, "DevCenterScopedNameAvailabilityContent", "csharp");
@@clientName(EnvironmentDefinitionParameter, "DevCenterEnvironmentDefinitionParameterInfo", "csharp");
@@clientName(PoolDevBoxDefinition, "DevCenterPoolDevBoxDefinitionDetail", "csharp");

// Acronym mapping: match baseline casing
@@clientName(RecommendedMachineConfiguration.vCPUs, "VCpus", "csharp");

// TypesMustExist fixes: rename types to match baseline
@@clientName(CatalogUpdate, "DevCenterCatalogPatch", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason, "DevCenterNameUnavailableReason", "csharp");

// FlattenProperty: back-compatible.tsp scopes to "autorest,java" only — C# needs its own
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AllowedEnvironmentType.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AttachedNetworkConnection.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomizationTask.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevBoxDefinition.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenterEncryptionSet.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenter.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentDefinition.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentType.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gallery.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HealthCheckStatusDetails.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinitionBuild.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinition.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageVersion.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkConnection.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pool.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectEnvironmentType.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectPolicy.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Project.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Schedule.properties, "csharp");

// Fix: generator auto-maps string location to AzureLocation but generates invalid deserialization.
// Explicitly set to azureLocation so the generator produces correct serialization code.
@@alternateType(TrackedResourceUpdate.location, Azure.Core.azureLocation, "csharp");

// CannotRemoveBaseTypeOrInterface fixes: replacement models to restore TrackedResourceUpdate base class.
// Original models use `is TrackedResourceUpdate` which spreads (inlines) properties in C#.
// Replacements use `extends` to preserve the inheritance chain.

model DevCenterUpdateReplacement extends TrackedResourceUpdate {
  /** Managed identity properties. */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a Dev Center to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: DevCenterUpdateProperties;
}
@@alternateType(DevCenterUpdate, DevCenterUpdateReplacement, "csharp");
@@clientName(DevCenterUpdateReplacement, "DevCenterPatch", "csharp");

model DevBoxDefinitionUpdateReplacement extends TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a Dev Box definition to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: DevBoxDefinitionUpdateProperties;
}
@@alternateType(DevBoxDefinitionUpdate, DevBoxDefinitionUpdateReplacement, "csharp");
@@clientName(DevBoxDefinitionUpdateReplacement, "DevBoxDefinitionPatch", "csharp");

model NetworkConnectionUpdateReplacement extends TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a network connection resource to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkConnectionUpdateProperties;
}
@@alternateType(NetworkConnectionUpdate, NetworkConnectionUpdateReplacement, "csharp");
@@clientName(NetworkConnectionUpdateReplacement, "DevCenterNetworkConnectionPatch", "csharp");

model PoolUpdateReplacement extends TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a pool to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: PoolUpdateProperties;
}
@@alternateType(PoolUpdate, PoolUpdateReplacement, "csharp");
@@clientName(PoolUpdateReplacement, "DevCenterPoolPatch", "csharp");

model ProjectUpdateReplacement extends TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a project to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ProjectUpdateProperties;
  /** Managed identity properties. */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}
@@alternateType(ProjectUpdate, ProjectUpdateReplacement, "csharp");
@@clientName(ProjectUpdateReplacement, "DevCenterProjectPatch", "csharp");

model ScheduleUpdateReplacement extends TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  /** Properties of a schedule resource to be updated. */
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ScheduleUpdateProperties;
}
@@alternateType(ScheduleUpdate, ScheduleUpdateReplacement, "csharp");
@@clientName(ScheduleUpdateReplacement, "DevCenterSchedulePatch", "csharp");

// ScheduleUpdateProperties uses `is TrackedResourceUpdate` which spreads tags/location into it.
// When flattened into ScheduleUpdateReplacement (which inherits tags/location from base),
// this causes CS0108. Replace with a plain model that omits tags/location.
model ScheduleUpdatePropertiesReplacement {
  ...OmitProperties<ScheduleUpdateProperties, "tags" | "location">;
}
@@alternateType(ScheduleUpdateProperties, ScheduleUpdatePropertiesReplacement, "csharp");

// ApiCompat fixes: property renames and type overrides
@@clientName(DevBoxDefinitionUpdateProperties.osStorageType, "OSStorageType", "csharp");
@@alternateType(GitCatalog.uri, url, "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type, Azure.Core.armResourceType, "csharp");

// Group 3: Fix GetImages method rename (GetByDevCenter → GetImages)
@@clientName(DevCenters.listByDevCenter, "GetImages", "csharp");

// Group 4: Fix Usage method param type (string → AzureLocation)
@@alternateType(UsagesOperationGroup.listByLocation::parameters.location, Azure.Core.azureLocation, "csharp");

// Group 5: Fix Roles property name (CreatorRoleAssignmentRoles → Roles via flatten)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectEnvironmentTypeUpdateProperties.creatorRoleAssignment, "csharp");
