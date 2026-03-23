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
@@clientName(ImageVersionProperties.osDiskImageSizeInGb, "OsDiskImageSizeInGB", "csharp");
@@clientName(ImageVersionProperties.excludeFromLatest, "IsExcludedFromLatest", "csharp");
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
