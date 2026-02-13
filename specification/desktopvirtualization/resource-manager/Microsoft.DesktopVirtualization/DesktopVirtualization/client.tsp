import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

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

@@clientName(MaintenanceWindowProperties,
  "SessionHostMaintenanceWindowProperties",
  "csharp"
);

@@clientName(PrivateEndpointConnectionWithSystemData,
  "DesktopVirtualizationPrivateEndpointConnectionData",
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

@@clientName(SendMessage, "UserSessionMessage", "csharp");

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
  "IsCloudPcResource",
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

@@clientName(HostPoolProperties.cloudPcResource, "IsCloudPcResource", "csharp");

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
  "IsCloudPcResource",
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
  ScalingScheduleDaysOfWeekItem,
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
