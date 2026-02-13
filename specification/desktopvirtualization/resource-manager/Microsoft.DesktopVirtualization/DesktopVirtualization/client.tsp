import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

// ============================================================================
// Model renames (@clientName)
// ============================================================================

// AgentUpdatePatchProperties -> SessionHostAgentUpdatePatchProperties
@@clientName(AgentUpdatePatchProperties,
  "SessionHostAgentUpdatePatchProperties",
  "csharp"
);

// AgentUpdateProperties -> SessionHostAgentUpdateProperties
@@clientName(AgentUpdateProperties,
  "SessionHostAgentUpdateProperties",
  "csharp"
);

// Application -> VirtualApplication
@@clientName(Application, "VirtualApplication", "csharp");

// ApplicationGroup -> VirtualApplicationGroup
@@clientName(ApplicationGroup, "VirtualApplicationGroup", "csharp");

// ApplicationGroupType -> VirtualApplicationGroupType
@@clientName(ApplicationGroupType, "VirtualApplicationGroupType", "csharp");

// ApplicationType -> VirtualApplicationType
@@clientName(ApplicationType, "VirtualApplicationType", "csharp");

// CommandLineSetting -> VirtualApplicationCommandLineSetting
@@clientName(CommandLineSetting,
  "VirtualApplicationCommandLineSetting",
  "csharp"
);

// Desktop -> VirtualDesktop
@@clientName(Desktop, "VirtualDesktop", "csharp");

// HealthCheckName -> SessionHostHealthCheckName
@@clientName(HealthCheckName, "SessionHostHealthCheckName", "csharp");

// HealthCheckResult -> SessionHostHealthCheckResult
@@clientName(HealthCheckResult, "SessionHostHealthCheckResult", "csharp");

// HostpoolPublicNetworkAccess -> HostPoolPublicNetworkAccess
@@clientName(HostpoolPublicNetworkAccess,
  "HostPoolPublicNetworkAccess",
  "csharp"
);

// LoadBalancerType -> HostPoolLoadBalancerType
@@clientName(LoadBalancerType, "HostPoolLoadBalancerType", "csharp");

// MaintenanceWindowProperties -> SessionHostMaintenanceWindowProperties
@@clientName(MaintenanceWindowProperties,
  "SessionHostMaintenanceWindowProperties",
  "csharp"
);

// PrivateEndpointConnectionWithSystemData -> DesktopVirtualizationPrivateEndpointConnectionData
@@clientName(PrivateEndpointConnectionWithSystemData,
  "DesktopVirtualizationPrivateEndpointConnectionData",
  "csharp"
);

// PrivateLinkResource -> DesktopVirtualizationPrivateLinkResourceData
@@clientName(PrivateLinkResource,
  "DesktopVirtualizationPrivateLinkResourceData",
  "csharp"
);

// ProvisioningState -> AppAttachPackageProvisioningState
@@clientName(ProvisioningState, "AppAttachPackageProvisioningState", "csharp");

// PublicNetworkAccess -> DesktopVirtualizationPublicNetworkAccess
@@clientName(PublicNetworkAccess,
  "DesktopVirtualizationPublicNetworkAccess",
  "csharp"
);

// RegistrationInfo -> HostPoolRegistrationInfo
@@clientName(RegistrationInfo, "HostPoolRegistrationInfo", "csharp");

// RegistrationInfoPatch -> HostPoolRegistrationInfoPatch
@@clientName(RegistrationInfoPatch, "HostPoolRegistrationInfoPatch", "csharp");

// RegistrationTokenOperation -> HostPoolRegistrationTokenOperation
@@clientName(RegistrationTokenOperation,
  "HostPoolRegistrationTokenOperation",
  "csharp"
);

// SendMessage -> UserSessionMessage
@@clientName(SendMessage, "UserSessionMessage", "csharp");

// SessionState -> UserSessionState
@@clientName(SessionState, "UserSessionState", "csharp");

// SSOSecretType -> HostPoolSsoSecretType
@@clientName(SSOSecretType, "HostPoolSsoSecretType", "csharp");

// StartMenuItem -> DesktopVirtualizationStartMenuItem
@@clientName(StartMenuItem, "DesktopVirtualizationStartMenuItem", "csharp");

// Status -> SessionHostStatus
@@clientName(Status, "SessionHostStatus", "csharp");

// StopHostsWhen -> DesktopVirtualizationStopHostsWhen
@@clientName(StopHostsWhen, "DesktopVirtualizationStopHostsWhen", "csharp");

// Time -> ScalingActionTime
@@clientName(Time, "ScalingActionTime", "csharp");

// UpdateState -> SessionHostUpdateState
@@clientName(UpdateState, "SessionHostUpdateState", "csharp");

// Workspace -> VirtualWorkspace
@@clientName(Workspace, "VirtualWorkspace", "csharp");

// DayOfWeek -> DesktopVirtualizationDayOfWeek (prepend-rp-prefix)
@@clientName(DayOfWeek, "DesktopVirtualizationDayOfWeek", "csharp");

// ============================================================================
// Enum member renames (@clientName)
// ============================================================================

// AppAttachPackageArchitectures.ALL -> All
@@clientName(AppAttachPackageArchitectures.ALL, "All", "csharp");

// AppAttachPackageArchitectures.ARM -> Arm
@@clientName(AppAttachPackageArchitectures.ARM, "Arm", "csharp");

// AppAttachPackageArchitectures.ARM64 -> Arm64
@@clientName(AppAttachPackageArchitectures.ARM64, "Arm64", "csharp");

// HostPoolType.BYODesktop -> BringYourOwnDesktop
@@clientName(HostPoolType.BYODesktop, "BringYourOwnDesktop", "csharp");

// ============================================================================
// Property renames (@clientName)
// ============================================================================

// AgentUpdatePatchProperties.useSessionHostLocalTime -> DoesUseSessionHostLocalTime
@@clientName(AgentUpdatePatchProperties.useSessionHostLocalTime,
  "DoesUseSessionHostLocalTime",
  "csharp"
);

// AgentUpdateProperties.useSessionHostLocalTime -> DoesUseSessionHostLocalTime
@@clientName(AgentUpdateProperties.useSessionHostLocalTime,
  "DoesUseSessionHostLocalTime",
  "csharp"
);

// AppAttachPackageInfoProperties.certificateExpiry -> CertificateExpireOn
@@clientName(AppAttachPackageInfoProperties.certificateExpiry,
  "CertificateExpireOn",
  "csharp"
);

// AppAttachPackageInfoProperties.lastUpdated -> LastUpdatedOn
@@clientName(AppAttachPackageInfoProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);

// AppAttachPackagePatchProperties.keyVaultURL -> KeyVaultUri
@@clientName(AppAttachPackagePatchProperties.keyVaultURL,
  "KeyVaultUri",
  "csharp"
);

// AppAttachPackageProperties.keyVaultURL -> KeyVaultUri
@@clientName(AppAttachPackageProperties.keyVaultURL, "KeyVaultUri", "csharp");

// ApplicationGroupProperties.cloudPcResource -> IsCloudPcResource
@@clientName(ApplicationGroupProperties.cloudPcResource,
  "IsCloudPcResource",
  "csharp"
);

// ApplicationGroupProperties.hostPoolArmPath -> HostPoolId
@@clientName(ApplicationGroupProperties.hostPoolArmPath,
  "HostPoolId",
  "csharp"
);

// ApplicationGroupProperties.workspaceArmPath -> WorkspaceId
@@clientName(ApplicationGroupProperties.workspaceArmPath,
  "WorkspaceId",
  "csharp"
);

// ExpandMsixImageProperties.lastUpdated -> LastUpdatedOn
@@clientName(ExpandMsixImageProperties.lastUpdated, "LastUpdatedOn", "csharp");

// HostPoolProperties.cloudPcResource -> IsCloudPcResource
@@clientName(HostPoolProperties.cloudPcResource, "IsCloudPcResource", "csharp");

// HostPoolProperties.ssoadfsAuthority -> SsoAdfsAuthority
@@clientName(HostPoolProperties.ssoadfsAuthority, "SsoAdfsAuthority", "csharp");

// HostPoolProperties.validationEnvironment -> IsValidationEnvironment
@@clientName(HostPoolProperties.validationEnvironment,
  "IsValidationEnvironment",
  "csharp"
);

// HostPoolPatchProperties.ssoadfsAuthority -> SsoAdfsAuthority
@@clientName(HostPoolPatchProperties.ssoadfsAuthority,
  "SsoAdfsAuthority",
  "csharp"
);

// HostPoolPatchProperties.validationEnvironment -> IsValidationEnvironment
@@clientName(HostPoolPatchProperties.validationEnvironment,
  "IsValidationEnvironment",
  "csharp"
);

// MSIXPackageProperties.lastUpdated -> LastUpdatedOn  (note: spec uses MSIXPackageProperties)
@@clientName(MSIXPackageProperties.lastUpdated, "LastUpdatedOn", "csharp");

// ScalingHostPoolReference.hostPoolArmPath -> HostPoolId
@@clientName(ScalingHostPoolReference.hostPoolArmPath, "HostPoolId", "csharp");

// ScalingHostPoolReference.scalingPlanEnabled -> IsScalingPlanEnabled
@@clientName(ScalingHostPoolReference.scalingPlanEnabled,
  "IsScalingPlanEnabled",
  "csharp"
);

// ScalingPlanProperties.hostPoolType -> ScalingHostPoolType
@@clientName(ScalingPlanProperties.hostPoolType,
  "ScalingHostPoolType",
  "csharp"
);

// SessionHostProperties.lastHeartBeat -> LastHeartBeatOn
@@clientName(SessionHostProperties.lastHeartBeat, "LastHeartBeatOn", "csharp");

// SessionHostProperties.lastUpdateTime -> LastUpdatedOn
@@clientName(SessionHostProperties.lastUpdateTime, "LastUpdatedOn", "csharp");

// SessionHostProperties.virtualMachineId -> VmId
@@clientName(SessionHostProperties.virtualMachineId, "VmId", "csharp");

// WorkspaceProperties.cloudPcResource -> IsCloudPcResource
@@clientName(WorkspaceProperties.cloudPcResource,
  "IsCloudPcResource",
  "csharp"
);

// ============================================================================
// Type changes (@alternateType)
// ============================================================================

// AppAttachPackagePatchProperties.keyVaultURL -> uri
@@alternateType(AppAttachPackagePatchProperties.keyVaultURL,
  TypeSpec.url,
  "csharp"
);

// AppAttachPackageProperties.keyVaultURL -> uri
@@alternateType(AppAttachPackageProperties.keyVaultURL, TypeSpec.url, "csharp");

// ApplicationProperties.iconContent -> any
@@alternateType(ApplicationProperties.iconContent, unknown, "csharp");

// DesktopProperties.iconContent -> any
@@alternateType(DesktopProperties.iconContent, unknown, "csharp");

// MsixPackageApplications.rawIcon -> any
@@alternateType(MsixPackageApplications.rawIcon, unknown, "csharp");

// MsixPackageApplications.rawPng -> any
@@alternateType(MsixPackageApplications.rawPng, unknown, "csharp");

// ResourceModelWithAllowedPropertySet.managedBy -> arm-id
@@alternateType(ResourceModelWithAllowedPropertySet.managedBy,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ApplicationGroupProperties.hostPoolArmPath -> arm-id
@@alternateType(ApplicationGroupProperties.hostPoolArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ApplicationGroupProperties.workspaceArmPath -> arm-id
@@alternateType(ApplicationGroupProperties.workspaceArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ScalingHostPoolReference.hostPoolArmPath -> arm-id
@@alternateType(ScalingHostPoolReference.hostPoolArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// SessionHost.properties.resourceId -> arm-id
@@alternateType(SessionHostProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
