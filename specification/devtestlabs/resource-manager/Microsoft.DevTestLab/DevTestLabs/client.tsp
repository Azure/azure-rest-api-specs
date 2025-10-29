import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.DevTestLab;

@@scope(Operations.get, "!csharp");
@@scope(ProviderOperations.list, "!csharp");

@@clientName(ArmTemplate, "DevTestLabArmTemplate", "csharp");
@@clientName(Artifact, "DevTestLabArtifact", "csharp");
@@clientName(ArtifactSource, "DevTestLabArtifactSource", "csharp");
@@clientName(CustomImage, "DevTestLabCustomImage", "csharp");
@@clientName(Disk, "DevTestLabDisk", "csharp");
@@clientName(DtlEnvironment, "DevTestLabEnvironment", "csharp");
@@clientName(Formula, "DevTestLabFormula", "csharp");
@@clientName(Lab, "DevTestLab", "csharp");
@@clientName(LabCost, "DevTestLabCost", "csharp");
@@clientName(Schedule, "DevTestLabSchedule", "csharp");
@@clientName(LabVirtualMachine, "DevTestLabVm", "csharp");
@@clientName(LabVirtualMachineProperties.virtualMachineCreationSource,
  "VmCreationSource",
  "csharp"
);
@@alternateType(LabVirtualMachineProperties.computeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(LabVirtualMachineProperties.labVirtualNetworkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(LabVirtualMachineProperties.environmentId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(NotificationChannel, "DevTestLabNotificationChannel", "csharp");
@@clientName(Policy, "DevTestLabPolicy", "csharp");
@@clientName(Secret, "DevTestLabSecret", "csharp");
@@clientName(ServiceFabric, "DevTestLabServiceFabric", "csharp");
@@clientName(ServiceRunner, "DevTestLabServiceRunner", "csharp");
@@clientName(User, "DevTestLabUser", "csharp");
@@clientName(VirtualNetwork, "DevTestLabVirtualNetwork", "csharp");
@@clientName(ApplicableSchedule, "DevTestLabApplicableSchedule", "csharp");
@@alternateType(ApplicableSchedule.location, azureLocation, "csharp");
@@clientName(ApplyArtifactsRequest,
  "DevTestLabVmApplyArtifactsContent",
  "csharp"
);
@@clientName(ArmTemplateInfo, "DevTestLabArmTemplateInfo", "csharp");
@@clientName(ArmTemplateParameterProperties,
  "DevTestLabArmTemplateParameter",
  "csharp"
);
@@clientName(ArtifactDeploymentStatusProperties,
  "DevTestLabArtifactDeploymentStatus",
  "csharp"
);
@@clientName(ArtifactInstallProperties,
  "DevTestLabArtifactInstallInfo",
  "csharp"
);
@@clientName(ArtifactParameterProperties,
  "DevTestLabArtifactParameter",
  "csharp"
);
@@clientName(AttachDiskProperties, "DevTestLabDiskAttachContent", "csharp");
@@alternateType(AttachDiskProperties.leasedByLabVmId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AttachNewDataDiskOptions, "AttachNewDataDiskDetails", "csharp");
@@clientName(TargetCostProperties, "DevTestLabTargetCost", "csharp");
@@clientName(CostThresholdProperties, "DevTestLabCostThreshold", "csharp");
@@clientName(CostThresholdStatus, "DevTestLabCostThresholdStatus", "csharp");
@@clientName(CostType, "DevTestLabCostType", "csharp");
@@clientName(LabCostDetailsProperties, "DevTestLabCostDetails", "csharp");
@@clientName(LabCostDetailsProperties.date, "On", "csharp");
@@clientName(CustomImageOsType, "DevTestLabCustomImageOsType", "csharp");
@@clientName(CustomImagePropertiesCustom, "DevTestLabCustomImageVhd", "csharp");
@@clientName(CustomImagePropertiesFromVm, "DevTestLabCustomImageVm", "csharp");
@@clientName(CustomImagePropertiesFromPlan,
  "DevTestLabCustomImagePlan",
  "csharp"
);
@@clientName(DataDiskStorageTypeInfo,
  "DevTestLabDataDiskStorageTypeInfo",
  "csharp"
);
@@clientName(StorageType, "DevTestLabStorageType", "csharp");
@@clientName(DataDiskProperties, "DevTestLabDataDiskProperties", "csharp");
@@alternateType(DataDiskProperties.existingLabDiskId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(DetachDataDiskProperties,
  "DevTestLabVmDetachDataDiskContent",
  "csharp"
);
@@clientName(DetachDiskProperties, "DevTestLabDiskDetachContent", "csharp");
@@alternateType(DetachDiskProperties.leasedByLabVmId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(UpdateResource, "DevTestLabResourcePatch", "csharp");
@@clientName(EnableStatus, "DevTestLabEnableStatus", "csharp");
@@clientName(EnvironmentDeploymentProperties,
  "DevTestLabEnvironmentDeployment",
  "csharp"
);
@@alternateType(EnvironmentDeploymentProperties.armTemplateId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(EnvironmentPermission,
  "DevTestLabEnvironmentPermission",
  "csharp"
);
@@clientName(EvaluatePoliciesRequest,
  "DevTestLabEvaluatePoliciesContent",
  "csharp"
);
@@clientName(EvaluatePoliciesProperties, "DevTestLabEvaluatePolicy", "csharp");
@@clientName(EvaluatePoliciesResponse,
  "DevTestLabEvaluatePoliciesResult",
  "csharp"
);
@@clientName(PolicySetResult, "DevTestLabPolicySetResult", "csharp");
@@clientName(Event, "DevTestLabNotificationChannelEvent", "csharp");
@@clientName(NotificationChannelEventType,
  "DevTestLabNotificationChannelEventType",
  "csharp"
);
@@clientName(ExportResourceUsageParameters,
  "DevTestLabExportResourceUsageContent",
  "csharp"
);
@@alternateType(ExportResourceUsageParameters.blobStorageAbsoluteSasUri,
  url,
  "csharp"
);
@@clientName(ExternalSubnet, "DevTestLabExternalSubnet", "csharp");
@@alternateType(ExternalSubnet.id, armResourceIdentifier, "csharp");
@@clientName(SubnetOverride, "DevTestLabSubnetOverride", "csharp");
@@alternateType(SubnetOverride.resourceId, armResourceIdentifier, "csharp");
@@clientName(FileUploadOptions, "DevTestLabFileUploadOption", "csharp");
@@clientName(GalleryImage, "DevTestLabGalleryImage", "csharp");
@@clientName(GalleryImageProperties.enabled, "IsEnabled", "csharp");
@@clientName(GalleryImageReference,
  "DevTestLabGalleryImageReference",
  "csharp"
);
@@clientName(GenerateArmTemplateRequest.virtualMachineName, "VmName", "csharp");
@@clientName(GenerateArmTemplateRequest,
  "DevTestLabArtifactGenerateArmTemplateContent",
  "csharp"
);
@@clientName(ParameterInfo, "DevTestLabParameter", "csharp");
@@clientName(GenerateUploadUriParameter,
  "DevTestLabGenerateUploadUriContent",
  "csharp"
);
@@clientName(GenerateUploadUriResponse,
  "DevTestLabGenerateUploadUriResult",
  "csharp"
);
@@clientName(HostCachingOptions, "DevTestLabHostCachingOption", "csharp");
@@clientName(IdentityProperties, "DevTestLabManagedIdentity", "csharp");
//@@alternateType(IdentityProperties.type, Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType, "csharp");
@@alternateType(IdentityProperties.principalId, uuid, "csharp");
@@clientName(ImportLabVirtualMachineRequest,
  "DevTestLabImportVmContent",
  "csharp"
);
@@alternateType(ImportLabVirtualMachineRequest.sourceVirtualMachineResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(InboundNatRule, "DevTestLabInboundNatRule", "csharp");
@@clientName(LabAnnouncementProperties, "DevTestLabAnnouncement", "csharp");
@@clientName(LabResourceCostProperties, "DevTestLabResourceCost", "csharp");
@@clientName(LabResourceCostProperties.resourcename, "ResourceName", "csharp");
@@clientName(LabResourceCostProperties.resourceUId,
  "ResourceUniqueId",
  "csharp"
);
@@clientName(LabSupportProperties, "DevTestLabSupport", "csharp");
@@clientName(LabVirtualMachineCreationParameter,
  "DevTestLabVmCreationContent",
  "csharp"
);
@@clientName(LinuxOsState, "DevTestLabLinuxOsState", "csharp");
@@clientName(NetworkInterfaceProperties,
  "DevTestLabNetworkInterface",
  "csharp"
);
@@alternateType(NetworkInterfaceProperties.virtualNetworkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkInterfaceProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkInterfaceProperties.publicIpAddressId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(NotificationSettings, "DevTestLabNotificationSettings", "csharp");
@@clientName(NotifyParameters,
  "DevTestLabNotificationChannelNotifyContent",
  "csharp"
);
@@clientName(ParametersValueFileInfo,
  "DevTestLabParametersValueFileInfo",
  "csharp"
);
@@clientName(PolicyEvaluatorType, "DevTestLabPolicyEvaluatorType", "csharp");
@@clientName(PolicyFactName, "DevTestLabPolicyFactName", "csharp");
@@clientName(PolicyStatus, "DevTestLabPolicyStatus", "csharp");
@@clientName(PolicyViolation, "DevTestLabPolicyViolation", "csharp");
@@clientName(Port, "DevTestLabPort", "csharp");
@@clientName(TransportProtocol, "DevTestLabTransportProtocol", "csharp");
@@clientName(PremiumDataDisk, "DevTestLabPremiumDataDisk", "csharp");
@@clientName(RdpConnection, "DevTestLabRdpConnection", "csharp");
@@clientName(ReportingCycleType, "DevTestLabReportingCycleType", "csharp");
@@clientName(ResizeLabVirtualMachineProperties,
  "DevTestLabVmResizeContent",
  "csharp"
);
@@clientName(RetargetScheduleProperties,
  "DevTestLabGlobalScheduleRetargetContent",
  "csharp"
);
@@alternateType(RetargetScheduleProperties.currentResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(RetargetScheduleProperties.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ScheduleCreationParameter,
  "DevTestLabScheduleCreationParameter",
  "csharp"
);
@@alternateType(ScheduleCreationParameterProperties.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ScheduleFragment, "DevTestLabSchedulePatch", "csharp");
@@clientName(SourceControlType, "DevTestLabSourceControlType", "csharp");
@@clientName(Subnet, "DevTestLabSubnet", "csharp");
@@alternateType(Subnet.resourceId, armResourceIdentifier, "csharp");
@@clientName(TargetCostStatus, "DevTestLabTargetCostStatus", "csharp");
@@clientName(UsagePermissionType, "DevTestLabUsagePermissionType", "csharp");
@@clientName(UserIdentity, "DevTestLabUserIdentity", "csharp");
@@clientName(UserSecretStore, "DevTestLabUserSecretStore", "csharp");
@@alternateType(UserSecretStore.keyVaultId, armResourceIdentifier, "csharp");
@@clientName(VirtualMachineCreationSource,
  "DevTestLabVmCreationSource",
  "csharp"
);
@@clientName(WeekDetails, "DevTestLabWeekDetails", "csharp");
@@clientName(ArmTemplateProperties.enabled, "IsEnabled", "csharp");
@@clientName(LabAnnouncementProperties.expired, "IsExpired", "csharp");
@@clientName(CustomImagePropertiesCustom.sysPrep, "IsSysPrepEnabled", "csharp");
@@alternateType(DiskProperties.managedDiskId, armResourceIdentifier, "csharp");
@@alternateType(DiskProperties.leasedByLabVmId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(LabVirtualMachineCreationParameterProperties.labVirtualNetworkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(DetachDataDiskProperties.existingLabDiskId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(LabProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(LabAnnouncementProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(ScheduleProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(ArtifactSourceProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(LabCostProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(CustomImageProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(FormulaProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(NotificationChannelProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(PolicyProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(UserProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(DiskProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(EnvironmentProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(SecretProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(ServiceFabricProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(LabVirtualMachineProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(VirtualNetworkProperties.uniqueIdentifier, uuid, "csharp");
@@alternateType(ArtifactSourceProperties.uri, url, "csharp");
@@alternateType(DiskProperties.diskUri, url, "csharp");
@@alternateType(ComputeDataDisk.diskUri, url, "csharp");
@@alternateType(NotificationChannelProperties.webHookUrl, url, "csharp");

@@clientName(Labs.importVirtualMachine, "ImportVm", "csharp");
@@clientName(PolicySets.evaluatePolicies, "EvaluatePolicies", "csharp");
