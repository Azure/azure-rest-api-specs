import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

@@scope(Operations.list, "!csharp");

@@clientName(AgentUpdatePatchProperties,
  "SessionHostAgentUpdatePatchProperties",
  "csharp"
);

@@clientName(AgentUpdateProperties,
  "SessionHostAgentUpdateProperties",
  "csharp"
);

@@clientName(Application, "VirtualApplication", "csharp");

@@clientName(ApplicationGroup, "VirtualApplicationGroup", "csharp");

@@clientName(ApplicationGroupType, "VirtualApplicationGroupType", "csharp");

@@clientName(ApplicationType, "VirtualApplicationType", "csharp");

@@clientName(CommandLineSetting,
  "VirtualApplicationCommandLineSetting",
  "csharp"
);

@@clientName(Desktop, "VirtualDesktop", "csharp");

@@clientName(HealthCheckName, "SessionHostHealthCheckName", "csharp");

@@clientName(HealthCheckResult, "SessionHostHealthCheckResult", "csharp");

@@clientName(HostpoolPublicNetworkAccess,
  "HostPoolPublicNetworkAccess",
  "csharp"
);

@@clientName(LoadBalancerType, "HostPoolLoadBalancerType", "csharp");

@@clientName(ScalingPlanPooledScheduleProperties.name,
  "scheduleName",
  "csharp"
);

@@clientName(ScalingPlanPooledSchedulePatchProperties.name,
  "scheduleName",
  "csharp"
);

@@clientName(MaintenanceWindowProperties,
  "SessionHostMaintenanceWindowProperties",
  "csharp"
);

@@clientName(PrivateEndpointConnectionWithSystemData,
  "DesktopVirtualizationPrivateEndpointConnectionDataData",
  "csharp"
);

@@clientName(PrivateLinkResource,
  "DesktopVirtualizationPrivateLinkResourceData",
  "csharp"
);

@@clientName(ProvisioningState, "AppAttachPackageProvisioningState", "csharp");

@@clientName(PublicNetworkAccess,
  "DesktopVirtualizationPublicNetworkAccess",
  "csharp"
);

@@clientName(RegistrationInfo, "HostPoolRegistrationInfo", "csharp");

@@clientName(RegistrationInfoPatch, "HostPoolRegistrationInfoPatch", "csharp");

@@clientName(RegistrationTokenOperation,
  "HostPoolRegistrationTokenOperation",
  "csharp"
);

@@clientName(SessionState, "UserSessionState", "csharp");

@@clientName(SSOSecretType, "HostPoolSsoSecretType", "csharp");

@@clientName(StartMenuItem, "DesktopVirtualizationStartMenuItem", "csharp");

@@clientName(Status, "SessionHostStatus", "csharp");

@@clientName(StopHostsWhen, "DesktopVirtualizationStopHostsWhen", "csharp");

@@clientName(Time, "ScalingActionTime", "csharp");

@@clientName(UpdateState, "SessionHostUpdateState", "csharp");

@@clientName(Workspace, "VirtualWorkspace", "csharp");

@@clientName(DayOfWeek, "DesktopVirtualizationDayOfWeek", "csharp");

@@clientName(AppAttachPackageArchitectures.ALL, "All", "csharp");

@@clientName(AppAttachPackageArchitectures.ARM, "Arm", "csharp");

@@clientName(AppAttachPackageArchitectures.ARM64, "Arm64", "csharp");

@@clientName(HostPoolType.BYODesktop, "BringYourOwnDesktop", "csharp");

@@clientName(AgentUpdatePatchProperties.useSessionHostLocalTime,
  "DoesUseSessionHostLocalTime",
  "csharp"
);

@@clientName(AgentUpdateProperties.useSessionHostLocalTime,
  "DoesUseSessionHostLocalTime",
  "csharp"
);

@@clientName(AppAttachPackageInfoProperties.certificateExpiry,
  "CertificateExpireOn",
  "csharp"
);

@@clientName(AppAttachPackageInfoProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);

@@clientName(AppAttachPackagePatchProperties.keyVaultURL,
  "KeyVaultUri",
  "csharp"
);

@@clientName(AppAttachPackageProperties.keyVaultURL, "KeyVaultUri", "csharp");

@@clientName(ApplicationGroupProperties.cloudPcResource,
  "IsCloudPCResource",
  "csharp"
);

@@clientName(ApplicationGroupProperties.hostPoolArmPath,
  "HostPoolId",
  "csharp"
);

@@clientName(ApplicationGroupProperties.workspaceArmPath,
  "WorkspaceId",
  "csharp"
);

@@clientName(ExpandMsixImageProperties.lastUpdated, "LastUpdatedOn", "csharp");

@@clientName(HostPoolProperties.cloudPcResource, "IsCloudPCResource", "csharp");

@@clientName(HostPoolProperties.ssoadfsAuthority, "SsoAdfsAuthority", "csharp");

@@clientName(HostPoolProperties.validationEnvironment,
  "IsValidationEnvironment",
  "csharp"
);

@@clientName(HostPoolPatchProperties.ssoadfsAuthority,
  "SsoAdfsAuthority",
  "csharp"
);

@@clientName(HostPoolPatchProperties.validationEnvironment,
  "IsValidationEnvironment",
  "csharp"
);

@@clientName(MSIXPackageList, "MsixPackageList", "csharp");
@@clientName(MSIXPackageProperties.lastUpdated, "LastUpdatedOn", "csharp");

@@clientName(ScalingHostPoolReference.hostPoolArmPath, "HostPoolId", "csharp");

@@clientName(ScalingHostPoolReference.scalingPlanEnabled,
  "IsScalingPlanEnabled",
  "csharp"
);

@@clientName(ScalingPlanProperties.hostPoolType,
  "ScalingHostPoolType",
  "csharp"
);

@@clientName(SessionHostProperties.lastHeartBeat, "LastHeartBeatOn", "csharp");

@@clientName(SessionHostProperties.lastUpdateTime, "LastUpdatedOn", "csharp");

@@clientName(SessionHostProperties.virtualMachineId, "VmId", "csharp");

@@clientName(WorkspaceProperties.cloudPcResource,
  "IsCloudPCResource",
  "csharp"
);

@@alternateType(AppAttachPackagePatchProperties.keyVaultURL,
  TypeSpec.url,
  "csharp"
);

@@alternateType(AppAttachPackageProperties.keyVaultURL, TypeSpec.url, "csharp");

@@alternateType(ApplicationProperties.iconContent, unknown, "csharp");

@@alternateType(DesktopProperties.iconContent, unknown, "csharp");

@@alternateType(MsixPackageApplications.rawIcon, unknown, "csharp");

@@alternateType(MsixPackageApplications.rawPng, unknown, "csharp");

@@alternateType(ResourceModelWithAllowedPropertySet.managedBy,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(ApplicationGroupProperties.hostPoolArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(ApplicationGroupProperties.workspaceArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(ScalingHostPoolReference.hostPoolArmPath,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(SessionHostProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(ScalingSchedule.daysOfWeek,
  ScalingScheduleDaysOfWeekItemUsingStruct[],
  "csharp"
);

@@clientName(AppAttachPackageArchitectures,
  "AppAttachPackageArchitecture",
  "csharp"
);
@@clientName(ImportPackageInfoRequest, "ImportPackageInfoContent", "csharp");
@@clientName(SetStartVMOnConnect, "SetStartVmOnConnect", "csharp");
@@clientName(ScalingPlans.listByHostPool, "listScalingPlans", "csharp");
@@clientName(UserSessions.listByHostPool, "listUserSessions", "csharp");
@@clientName(SessionHostManagementProvisioningStatuses.get,
  "getProvisioningStatus",
  "csharp"
);
@@clientName(SessionHostManagementUpdateStatuses.get,
  "getUpdateStatus",
  "csharp"
);
@@clientName(HostPoolProvisioningControlParameter,
  "HostPoolProvisioningControlContent",
  "csharp"
);

@@clientName(ResourceProviderOperation,
  "ResourceProviderOperationInfo",
  "csharp"
);
@@clientName(HostPoolUpdateControlParameter,
  "HostPoolUpdateControlContent",
  "csharp"
);
@@clientName(MSIXPackage, "MsixPackage", "csharp");

// Category A fixes: acronym casing and property rename decorators
@@clientName(MSIXImageURI, "MsixImageUri", "csharp");
@@clientName(HostPoolProperties.startVMOnConnect, "StartVmOnConnect", "csharp");
@@clientName(AppAttachPackageArchitectures.x86a64, "X86A64", "csharp");
@@clientName(HostPoolPatchProperties.startVMOnConnect,
  "StartVmOnConnect",
  "csharp"
);
@@clientName(MsixPackageApplications.appUserModelID,
  "AppUserModelId",
  "csharp"
);

@@clientName(ScalingPlanPersonalSchedulePatchProperties.offPeakStartVMOnConnect,
  "OffPeakStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalSchedulePatchProperties.peakStartVMOnConnect,
  "PeakStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalSchedulePatchProperties.rampDownStartVMOnConnect,
  "RampDownStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalSchedulePatchProperties.rampUpStartVMOnConnect,
  "RampUpStartVmOnConnect",
  "csharp"
);

@@clientName(AgentUpdatePatchProperties.type, "UpdateType", "csharp");
@@clientName(AgentUpdateProperties.type, "UpdateType", "csharp");

@@clientName(HealthCheckName.SxSStackListenerCheck,
  "SxsStackListenerCheck",
  "csharp"
);
@@clientName(HealthCheckName.WebRTCRedirectorCheck,
  "WebRtcRedirectorCheck",
  "csharp"
);
@@clientName(Status.SxSStackListenerNotReady,
  "SxsStackListenerNotReady",
  "csharp"
);

@@clientName(ScalingPlanPersonalScheduleProperties.offPeakStartVMOnConnect,
  "OffPeakStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalScheduleProperties.peakStartVMOnConnect,
  "PeakStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalScheduleProperties.rampDownStartVMOnConnect,
  "RampDownStartVmOnConnect",
  "csharp"
);
@@clientName(ScalingPlanPersonalScheduleProperties.rampUpStartVMOnConnect,
  "RampUpStartVmOnConnect",
  "csharp"
);

@@clientName(SessionHostProperties.osVersion, "OSVersion", "csharp");
@@clientName(SessionHostProperties.sxSStackVersion,
  "SxsStackVersion",
  "csharp"
);

@@alternateType(HostPool.managedBy, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ScalingPlan.managedBy,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ApplicationGroup.managedBy,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Workspace.managedBy,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(HostPool.etag, Azure.Core.eTag, "csharp");
@@alternateType(ScalingPlan.etag, Azure.Core.eTag, "csharp");
@@alternateType(ApplicationGroup.etag, Azure.Core.eTag, "csharp");
@@alternateType(Workspace.etag, Azure.Core.eTag, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnectionWithSystemData.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExpandMsixImage.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HostPool.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MSIXPackage.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MSIXPackagePatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlan.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlanPersonalSchedule.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlanPooledSchedule.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SessionHost.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UserSession.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Application.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationGroup.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Desktop.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StartMenuItem.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HostPoolPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlanPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlanPersonalSchedulePatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScalingPlanPooledSchedulePatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SessionHostPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationGroupPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DesktopPatch.properties,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkspacePatch.properties,
  "csharp"
);

@@usage(StartMenuItem, Usage.input, "csharp");
@@usage(ExpandMsixImage, Usage.input, "csharp");
@@usage(ExpandMsixImageProperties, Usage.input, "csharp");
@@usage(UserSession, Usage.input, "csharp");
@@usage(UserSessionProperties, Usage.input, "csharp");
@@usage(Desktop, Usage.input, "csharp");
@@usage(DesktopProperties, Usage.input, "csharp");
@@usage(SessionHostProperties, Usage.input, "csharp");

// Breaking #9 fix: Public constructors for resource data types
@@usage(MSIXPackage, Usage.input, "csharp");
@@usage(ScalingPlanPersonalSchedule, Usage.input, "csharp");
@@usage(ScalingPlanPooledSchedule, Usage.input, "csharp");
@@usage(PrivateEndpointConnectionWithSystemData, Usage.input, "csharp");
@@usage(PrivateEndpointConnection, Usage.input, "csharp");
@@usage(PrivateLinkResource, Usage.input, "csharp");

@@clientName(ScalingScheduleDaysOfWeekItem,
  "ScalingScheduleDaysOfWeekItemOld",
  "csharp"
);
@@clientName(ScalingScheduleDaysOfWeekItemUsingStruct,
  "ScalingScheduleDaysOfWeekItem",
  "csharp"
);
@@alternateType(ScalingScheduleDaysOfWeekItem,
  ScalingScheduleDaysOfWeekItemUsingStruct,
  "csharp"
);

@@alternateType(SendMessageRequest, SendMessage, "csharp");
@@clientName(SendMessage, "UserSessionMessage", "csharp");
@@clientName(UserSessions.sendMessage::parameters.body,
  "sendMessage",
  "csharp"
);
@@clientName(MSIXImages.expand::parameters.body, "msixImageUri", "csharp");

@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");

@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

@@clientName(AppAttachPackageInfo.`import`,
  "importAppAttachPackageInfos",
  "csharp"
);
@@clientName(MSIXImages.expand, "expandMsixImages", "csharp");
@@clientName(PrivateLinkResources.listByHostPool,
  "getPrivateLinkResources",
  "csharp"
);

@@Azure.ClientGenerator.Core.alternateType(CustomPrivateEndpointConnection.updateByWorkspace::parameters.resource,
  PrivateEndpointConnection,
  "csharp"
);
@@Azure.ClientGenerator.Core.alternateType(CustomPrivateEndpointConnection.updateByHostPool::parameters.resource,
  PrivateEndpointConnection,
  "csharp"
);

@@clientName(InitiateSessionHostUpdate.post,
  "initiateSessionHostUpdate",
  "csharp"
);
@@clientName(ControlSessionHostProvisioning.post,
  "controlSessionHostProvisioning",
  "csharp"
);
@@clientName(ControlSessionHostUpdate.post,
  "controlSessionHostUpdate",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(SessionHosts.listSingleSessionHostRegistrationTokens
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" ""
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(HostPools.listRegistrationTokens
);

@@clientName(type, "DesktopVirtualizationImageType", "csharp");
@@clientName(updateStatus,
  "SessionHostManagementUpdateOperationStatus",
  "csharp"
);
@@clientName(CanaryPolicy, "DesktopVirtualizationCanaryPolicy", "csharp");
@@clientName(DeploymentScope, "DesktopVirtualizationDeploymentScope", "csharp");
@@clientName(CreateDeleteProperties,
  "DesktopVirtualizationCreateDeleteProperties",
  "csharp"
);
@@clientName(DiffDiskOption, "DesktopVirtualizationDiffDiskOption", "csharp");
@@clientName(DiffDiskPlacement,
  "DesktopVirtualizationDiffDiskPlacement",
  "csharp"
);
@@clientName(DiffDiskProperties,
  "DesktopVirtualizationDiffDiskProperties",
  "csharp"
);
@@clientName(DirectUDP, "DesktopVirtualizationDirectUDP", "csharp");
@@clientName(DiskInfoProperties,
  "DesktopVirtualizationDiskInfoProperties",
  "csharp"
);
@@clientName(DomainInfoProperties,
  "DesktopVirtualizationDomainInfoProperties",
  "csharp"
);
@@clientName(DomainJoinType, "DesktopVirtualizationDomainJoinType", "csharp");
@@clientName(ImageInfoProperties,
  "DesktopVirtualizationImageInfoProperties",
  "csharp"
);
@@clientName(ImageInfoPatchProperties,
  "DesktopVirtualizationImageInfoPatchProperties",
  "csharp"
);
@@clientName(KeyVaultCredentialsPatchProperties,
  "DesktopVirtualizationKeyVaultCredentialsPatchProperties",
  "csharp"
);
@@clientName(KeyVaultCredentialsProperties,
  "DesktopVirtualizationKeyVaultCredentialsProperties",
  "csharp"
);
@@clientName(ManagedPrivateUDP,
  "DesktopVirtualizationManagedPrivateUDP",
  "csharp"
);
@@clientName(NetworkInfoPatchProperties,
  "DesktopVirtualizationNetworkInfoPatchProperties",
  "csharp"
);
@@clientName(ManagementType, "DesktopVirtualizationManagementType", "csharp");
@@clientName(NetworkInfoProperties,
  "DesktopVirtualizationNetworkInfoProperties",
  "csharp"
);
@@clientName(PublicUDP, "DesktopVirtualizationPublicUDP", "csharp");
@@clientName(ProvisioningStateSHC,
  "ProvisioningStateSessionHostConfiguration",
  "csharp"
);
@@clientName(RegistrationTokenList,
  "DesktopVirtualizationRegistrationTokenList",
  "csharp"
);
@@clientName(RegistrationTokenMinimal,
  "DesktopVirtualizationRegistrationTokenMinimal",
  "csharp"
);
@@clientName(RelayUDP, "DesktopVirtualizationRelayUDP", "csharp");
@@clientName(ScalingMethodType,
  "DesktopVirtualizationScalingMethodType",
  "csharp"
);
@@clientName(SecurityInfoPatchProperties,
  "DesktopVirtualizationSecurityInfoPatchProperties",
  "csharp"
);
@@clientName(SecurityInfoProperties,
  "DesktopVirtualizationSecurityInfoProperties",
  "csharp"
);
@@clientName(UpdateSessionHostsRequestBody,
  "DesktopVirtualizationUpdateSessionHostsContent",
  "csharp"
);
@@clientName(VirtualMachineDiskType,
  "DesktopVirtualizationVirtualMachineDiskType",
  "csharp"
);
@@clientName(VirtualMachineSecurityType,
  "DesktopVirtualizationVirtualMachineSecurityType",
  "csharp"
);
@@clientName(FailedSessionHostCleanupPolicySHC,
  "FailedSessionHostCleanupPolicySessionHostConfiguration",
  "csharp"
);

@@clientName(SessionHostProvisioningConfigurationProperties.setDrainMode,
  "IsDrainModeEnabled",
  "csharp"
);
@@clientName(SessionHostProvisioningConfigurationPatchProperties.setDrainMode,
  "IsDrainModeEnabled",
  "csharp"
);
@@clientName(BootDiagnosticsInfoProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(BootDiagnosticsInfoPatchProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(SecurityInfoProperties.secureBootEnabled,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(SecurityInfoPatchProperties.secureBootEnabled,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(SecurityInfoProperties.vTpmEnabled,
  "IsVtpmEnabled",
  "csharp"
);
@@clientName(SecurityInfoPatchProperties.vTpmEnabled,
  "IsVtpmEnabled",
  "csharp"
);
@@clientName(HostPoolUpdateConfigurationProperties.deleteOriginalVm,
  "ShouldDeleteOriginalVm",
  "csharp"
);
@@clientName(HostPoolUpdateConfigurationPatchProperties.deleteOriginalVm,
  "ShouldDeleteOriginalVm",
  "csharp"
);

@@alternateType(ActiveSessionHostConfigurationProperties.vmLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(SessionHostConfigurationProperties.vmLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(SessionHostConfigurationPatchProperties.vmLocation,
  Azure.Core.azureLocation,
  "csharp"
);