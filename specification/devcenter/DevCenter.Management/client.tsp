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
@@clientLocation(AttachedNetworkConnections.getByProject,
  AttachedNetworkConnections,
  "csharp"
);
@@clientLocation(AttachedNetworkConnections.listByProject,
  AttachedNetworkConnections,
  "csharp"
);

// DevBoxDefinition: prevent merge of project ops into devcenters DevBoxDefinitions
@@clientLocation(DevBoxDefinitionOperationGroup.getByProject,
  DevBoxDefinitionOperationGroup,
  "csharp"
);
@@clientLocation(DevBoxDefinitionOperationGroup.listByProject,
  DevBoxDefinitionOperationGroup,
  "csharp"
);

// Image: prevent merge of project ops into devcenters Images
@@clientLocation(ImageOperationGroup.getByProject,
  ImageOperationGroup,
  "csharp"
);
@@clientLocation(ImageOperationGroup.listByProject,
  ImageOperationGroup,
  "csharp"
);

// ImageVersion: prevent merge of project ops into devcenters ImageVersions
@@clientLocation(ImageVersionOperationGroup.getByProject,
  ImageVersionOperationGroup,
  "csharp"
);
@@clientLocation(ImageVersionOperationGroup.listByProject,
  ImageVersionOperationGroup,
  "csharp"
);

// EnvironmentDefinition: prevent merge of devcenters ops into project EnvironmentDefinitions
@@clientLocation(EnvironmentDefinitionOperationGroup.get,
  EnvironmentDefinitionOperationGroup,
  "csharp"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.listByCatalog,
  EnvironmentDefinitionOperationGroup,
  "csharp"
);
@@clientLocation(EnvironmentDefinitionOperationGroup.getErrorDetails,
  EnvironmentDefinitionOperationGroup,
  "csharp"
);

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
@@alternateType(GalleryProperties.galleryResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AttachedNetworkConnectionProperties.networkConnectionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkConnectionUpdateProperties.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ProjectUpdateProperties.devCenterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ProjectEnvironmentTypeUpdateProperties.deploymentTargetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ImageReference.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(DevCenterSku.resourceType,
  Azure.Core.armResourceType,
  "csharp"
);
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
@@alternateType(AttachedNetworkConnectionProperties.networkConnectionLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(DomainJoinType.HybridAzureADJoin, "HybridAadJoin", "csharp");
@@clientName(DomainJoinType.AzureADJoin, "AadJoin", "csharp");
@@clientName(ImageVersionProperties.osDiskImageSizeInGb,
  "OSDiskImageSizeInGB",
  "csharp"
);
@@clientName(ImageVersionProperties.excludeFromLatest,
  "IsExcludedFromLatest",
  "csharp"
);
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

// RP prefix for new models added in this API version
@@clientName(ActiveHoursConfiguration,
  "DevCenterActiveHoursConfiguration",
  "csharp"
);
@@clientName(AssignedGroup, "DevCenterAssignedGroup", "csharp");
@@clientName(CatalogConflictError, "DevCenterCatalogConflictError", "csharp");
@@clientName(CatalogErrorDetails, "DevCenterCatalogErrorDetails", "csharp");
@@clientName(CatalogResourceValidationErrorDetails,
  "DevCenterCatalogResourceValidationErrorDetails",
  "csharp"
);
@@clientName(CatalogSyncError, "DevCenterCatalogSyncError", "csharp");
@@clientName(ConfigurationPolicies, "DevCenterConfigurationPolicies", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CustomerManagedKeyEncryption,
  "DevCenterCustomerManagedKeyEncryption",
  "csharp"
);
@@clientName(CustomizationTask, "DevCenterCatalogTask", "csharp");
@@clientName(CustomizationTaskInput,
  "DevCenterCustomizationTaskInput",
  "csharp"
);
@@clientName(CustomizationTaskInstance,
  "DevCenterCustomizationTaskInstance",
  "csharp"
);
@@clientName(DefaultValue, "DevCenterDefaultValue", "csharp");
@@clientName(DefinitionParametersItem,
  "DevCenterDefinitionParametersItem",
  "csharp"
);
@@clientName(DevBoxScheduleDeleteSettings,
  "DevCenterDevBoxScheduleDeleteSettings",
  "csharp"
);
@@clientName(FeatureState, "DevCenterFeatureState", "csharp");
@@clientName(ImageCreationErrorDetails,
  "DevCenterImageCreationErrorDetails",
  "csharp"
);
@@clientName(ImageDefinitionBuildDetails,
  "DevCenterImageDefinitionBuildDetails",
  "csharp"
);
@@clientName(ImageDefinitionBuildTask,
  "DevCenterImageDefinitionBuildTask",
  "csharp"
);
@@clientName(ImageDefinitionBuildTaskGroup,
  "DevCenterImageDefinitionBuildTaskGroup",
  "csharp"
);
@@clientName(ImageDefinitionBuildTaskParametersItem,
  "DevCenterImageDefinitionBuildTaskParametersItem",
  "csharp"
);
@@clientName(ImageDefinitionReference,
  "DevCenterImageDefinitionReference",
  "csharp"
);
@@clientName(InheritedProjectCatalogSettings,
  "DevCenterInheritedProjectCatalogSettings",
  "csharp"
);
@@clientName(InheritedSettingsForProject,
  "DevCenterInheritedSettingsForProject",
  "csharp"
);
@@clientName(LatestImageBuild, "DevCenterLatestImageBuild", "csharp");
@@clientName(ProjectCustomizationManagedIdentity,
  "DevCenterProjectCustomizationManagedIdentity",
  "csharp"
);
@@clientName(ProjectCustomizationSettings,
  "DevCenterProjectCustomizationSettings",
  "csharp"
);
@@clientName(ProjectPolicyUpdate, "DevCenterProjectPolicyPatch", "csharp");
@@clientName(ResourcePolicy, "DevCenterResourcePolicy", "csharp");
@@clientName(ServerlessGpuSessionsSettings,
  "DevCenterServerlessGpuSessionsSettings",
  "csharp"
);
@@clientName(StopOnNoConnectConfiguration,
  "DevCenterStopOnNoConnectConfiguration",
  "csharp"
);
@@clientName(SyncErrorDetails, "DevCenterSyncErrorDetails", "csharp");
@@clientName(SyncStats, "DevCenterSyncStats", "csharp");
@@clientName(ProjectPolicy, "DevCenterProjectPolicy", "csharp");

// RP prefix for new unions/enums added in this API version
@@clientName(ArchitectureType, "DevCenterArchitectureType", "csharp");
@@clientName(AssignedGroupScope, "DevCenterAssignedGroupScope", "csharp");
@@clientName(AutoImageBuildStatus, "DevCenterAutoImageBuildStatus", "csharp");
@@clientName(AutoStartEnableStatus, "DevCenterAutoStartEnableStatus", "csharp");
@@clientName(CancelOnConnectEnableStatus,
  "DevCenterCancelOnConnectEnableStatus",
  "csharp"
);
@@clientName(CatalogAutoImageBuildEnableStatus,
  "DevCenterCatalogAutoImageBuildEnableStatus",
  "csharp"
);
@@clientName(CatalogConnectionState,
  "DevCenterCatalogConnectionState",
  "csharp"
);
@@clientName(CatalogItemSyncEnableStatus,
  "DevCenterCatalogItemSyncEnableStatus",
  "csharp"
);
@@clientName(CatalogItemType, "DevCenterCatalogItemType", "csharp");
@@clientName(CatalogResourceValidationStatus,
  "DevCenterCatalogResourceValidationStatus",
  "csharp"
);
@@clientName(CatalogSyncType, "DevCenterCatalogSyncType", "csharp");
@@clientName(CmkIdentityType, "DevCenterCmkIdentityType", "csharp");
@@clientName(CustomizationTaskInputType,
  "DevCenterCustomizationTaskInputType",
  "csharp"
);
@@clientName(DevBoxDeleteMode, "DevCenterDevBoxDeleteMode", "csharp");
@@clientName(DevBoxTunnelEnableStatus,
  "DevCenterDevBoxTunnelEnableStatus",
  "csharp"
);
@@clientName(DevboxDisksEncryptionEnableStatus,
  "DevCenterDevboxDisksEncryptionEnableStatus",
  "csharp"
);
@@clientName(FeatureStateModifiable,
  "DevCenterFeatureStateModifiable",
  "csharp"
);
@@clientName(FeatureStatus, "DevCenterFeatureStatus", "csharp");
@@clientName(ImageDefinitionBuildStatus,
  "DevCenterImageDefinitionBuildStatus",
  "csharp"
);
@@clientName(InstallAzureMonitorAgentEnableStatus,
  "DevCenterInstallAzureMonitorAgentEnableStatus",
  "csharp"
);
@@clientName(KeepAwakeEnableStatus, "DevCenterKeepAwakeEnableStatus", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.KeyEncryptionKeyIdentityType,
  "DevCenterKeyEncryptionKeyIdentityType",
  "csharp"
);
@@clientName(MicrosoftHostedNetworkEnableStatus,
  "DevCenterMicrosoftHostedNetworkEnableStatus",
  "csharp"
);
@@clientName(ParameterType, "DevCenterParameterType", "csharp");
@@clientName(PolicyAction, "DevCenterPolicyAction", "csharp");
@@clientName(PoolDevBoxDefinitionType,
  "DevCenterPoolDevBoxDefinitionType",
  "csharp"
);
@@clientName(ProjectCustomizationIdentityType,
  "DevCenterProjectCustomizationIdentityType",
  "csharp"
);
@@clientName(ServerlessGpuSessionsMode,
  "DevCenterServerlessGpuSessionsMode",
  "csharp"
);
@@clientName(SingleSignOnStatus, "DevCenterSingleSignOnStatus", "csharp");
@@clientName(StopOnNoConnectEnableStatus,
  "DevCenterStopOnNoConnectEnableStatus",
  "csharp"
);
@@clientName(UserCustomizationsEnableStatus,
  "DevCenterUserCustomizationsEnableStatus",
  "csharp"
);
@@clientName(VirtualNetworkType, "DevCenterVirtualNetworkType", "csharp");
@@clientName(WorkspaceStorageMode, "DevCenterWorkspaceStorageMode", "csharp");

// @@usage(Input): restore public constructors for output-only resource data models (ApiCompat)
@@usage(AllowedEnvironmentType,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(Image,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(HealthCheckStatusDetails,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(ImageVersion,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@usage(DevCenterSku,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);

// Manual: directive-based renames from autorest.md
@@clientName(ScheduleUpdateProperties.type, "ScheduledType", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.OperationStatusResult.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Manual: UserRoleAssignment C#-specific rename (overrides unscoped "UserRoleAssignmentValue")
@@clientName(UserRoleAssignment, "DevCenterUserRoleAssignments", "csharp");

// Manual: override-operation-name from autorest.md
@@clientName(OperationStatusesOperationGroup.get,
  "GetDevCenterOperationStatus",
  "csharp"
);
@@clientName(UsagesOperationGroup.listByLocation,
  "GetDevCenterUsagesByLocation",
  "csharp"
);
@@clientName(CheckNameAvailabilityOperationGroup.execute,
  "CheckDevCenterNameAvailability",
  "csharp"
);
@@clientName(SkusOperationGroup.listBySubscription,
  "GetDevCenterSkusBySubscription",
  "csharp"
);
@@clientName(NetworkConnections.listOutboundNetworkDependenciesEndpoints,
  "GetOutboundEnvironmentEndpoints",
  "csharp"
);

// AZC naming violations: rename types with forbidden suffixes
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "DevCenterNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "DevCenterNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(CheckScopedNameAvailabilityRequest,
  "DevCenterScopedNameAvailabilityContent",
  "csharp"
);
@@clientName(EnvironmentDefinitionParameter,
  "DevCenterEnvironmentDefinitionParameterInfo",
  "csharp"
);
@@clientName(PoolDevBoxDefinition,
  "DevCenterPoolDevBoxDefinitionDetail",
  "csharp"
);
@@clientName(RecommendedMachineConfiguration.vCPUs, "VCpus", "csharp");
@@clientName(CatalogUpdate, "DevCenterCatalogPatch", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "DevCenterNameUnavailableReason",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AllowedEnvironmentType.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AttachedNetworkConnection.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Catalog.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomizationTask.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevBoxDefinition.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenterEncryptionSet.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DevCenter.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentDefinition.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EnvironmentType.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gallery.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HealthCheckStatusDetails.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinitionBuild.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageDefinition.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageVersion.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkConnection.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pool.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectEnvironmentType.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectPolicy.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Project.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Schedule.properties,
  "csharp"
);

@@alternateType(TrackedResourceUpdate.location,
  Azure.Core.azureLocation,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DevCenterUpdate,
  TrackedResourceUpdate,
  "csharp"
);
@@clientName(DevCenterUpdate, "DevCenterPatch", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DevBoxDefinitionUpdate,
  TrackedResourceUpdate,
  "csharp"
);
@@clientName(DevBoxDefinitionUpdate, "DevBoxDefinitionPatch", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(NetworkConnectionUpdate,
  TrackedResourceUpdate,
  "csharp"
);
@@clientName(NetworkConnectionUpdate,
  "DevCenterNetworkConnectionPatch",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(PoolUpdate,
  TrackedResourceUpdate,
  "csharp"
);
@@clientName(PoolUpdate, "DevCenterPoolPatch", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ProjectUpdate,
  TrackedResourceUpdate,
  "csharp"
);
@@clientName(ProjectUpdate, "DevCenterProjectPatch", "csharp");

// ScheduleUpdate is a plain model without `is TrackedResourceUpdate`, so it doesn't have
// tags/location properties. hierarchyBuilding requires all base type properties to be present,
// so the replacement model approach is needed here.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Back compatibility"
@doc("The schedule properties for partial update. Properties not provided in the update request will not be changed.")
model ScheduleUpdateReplacement extends TrackedResourceUpdate {
  /** Properties of a schedule resource to be updated. */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  properties?: ScheduleUpdatePropertiesReplacement;
}
@@alternateType(ScheduleUpdate, ScheduleUpdateReplacement, "csharp");
@@clientName(ScheduleUpdateReplacement, "DevCenterSchedulePatch", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScheduleUpdateReplacement.properties,
  "csharp"
);

// ScheduleUpdateProperties uses `is TrackedResourceUpdate` which spreads tags/location into it.
// When flattened into ScheduleUpdateReplacement (which inherits tags/location from base),
// this causes CS0108. Replace with a plain model that omits tags/location.
@doc("Updatable properties of a Schedule.")
model ScheduleUpdatePropertiesReplacement {
  ...OmitProperties<ScheduleUpdateProperties, "tags" | "location">;
}

@@clientName(DevBoxDefinitionUpdateProperties.osStorageType,
  "OSStorageType",
  "csharp"
);
@@alternateType(GitCatalog.uri, url, "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(DevCenters.listByDevCenter, "GetImages", "csharp");
@@alternateType(UsagesOperationGroup.listByLocation::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectEnvironmentTypeUpdateProperties.creatorRoleAssignment,
  "csharp"
);
