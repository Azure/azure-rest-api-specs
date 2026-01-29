import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Batch;

@@clientName(Microsoft.Batch, "BatchManagementClient", "javascript, python");

// Java compat renames for existing management SDK surface
@@clientName(Microsoft.Batch.IPAddressProvisioningType,
  "IpAddressProvisioningType",
  "java"
);
@@clientName(Microsoft.Batch.PublicIPAddressConfiguration,
  "PublicIpAddressConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.IPRule, "IpRule", "java");
@@clientName(Microsoft.Batch.IPRuleAction, "IpRuleAction", "java");
@@clientName(Microsoft.Batch.NFSMountConfiguration,
  "NfsMountConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.CifsMountConfiguration,
  "CifsMountConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.NetworkConfiguration.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(Microsoft.Batch.CifsMountConfiguration.userName,
  "username",
  "java"
);
@@clientName(Microsoft.Batch.ContainerRegistry.username, "username", "java");
@@clientName(Microsoft.Batch.UserIdentity.userName, "username", "java");

@@clientName(Microsoft.Batch.PrivateLinkServiceConnectionState.actionsRequired,
  "ActionRequired",
  "go"
);
@@clientName(Microsoft.Batch.NetworkConfiguration.dynamicVnetAssignmentScope,
  "DynamicVNetAssignmentScope",
  "go"
);
@@clientName(Microsoft.Batch.CifsMountConfiguration.userName, "Username", "go");

@@clientName(Azure.ResourceManager.CommonTypes.TrackedResource,
  "AzureResource",
  "python"
);

@@clientName(CachingType, "BatchDiskCachingType", "csharp");
@@clientName(Application, "BatchApplication", "csharp");
@@clientName(ApplicationPackage, "BatchApplicationPackage", "csharp");
@@clientName(ApplicationPackageProperties.lastActivationTime,
  "LastActivatedOn",
  "csharp"
);
@@clientName(PublicNetworkAccessType, "BatchPublicNetworkAccess", "csharp");
@@clientName(BatchAccountProperties.dedicatedCoreQuotaPerVMFamilyEnforced,
  "IsDedicatedCoreQuotaPerVmFamilyEnforced",
  "csharp"
);
@@alternateType(Pool.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Pool.etag, Azure.Core.eTag, "csharp");
@@clientName(DetectorResponse, "BatchAccountDetector", "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "BatchAccountOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(EndpointDependency, "BatchAccountEndpointDependency", "csharp");
@@clientName(EndpointDetail, "BatchEndpointDetail", "csharp");
@@clientName(Pool, "BatchAccountPool", "csharp");
@@clientName(PoolProperties.lastModified, "LastModifiedOn", "csharp");
@@clientName(PoolProperties.provisioningStateTransitionTime,
  "provisioningStateTransitOn",
  "csharp"
);
@@clientName(PoolAllocationMode, "BatchAccountPoolAllocationMode", "csharp");
@@clientName(AutoScaleRun, "BatchAccountPoolAutoScaleRun", "csharp");
@@clientName(ResizeOperationStatus, "BatchResizeOperationStatus", "csharp");
@@clientName(ComputeNodeDeallocationOption,
  "BatchNodeDeallocationOption",
  "csharp"
);
@@clientName(Certificate, "BatchAccountCertificate", "csharp");
@@clientName(CertificateFormat, "BatchAccountCertificateFormat", "csharp");
@@clientName(CertificateProvisioningState,
  "BatchAccountCertificateProvisioningState",
  "csharp"
);
@@clientName(CertificateProperties.provisioningStateTransitionTime,
  "provisioningStateTransitOn",
  "csharp"
);
@@clientName(CertificateProperties.previousProvisioningStateTransitionTime,
  "previousProvisioningStateTransitOn",
  "csharp"
);
@@clientName(CertificateStoreLocation,
  "BatchCertificateStoreLocation",
  "csharp"
);
@@clientName(CertificateVisibility, "BatchCertificateVisibility", "csharp");
@@clientName(PoolProvisioningState,
  "BatchAccountPoolProvisioningState",
  "csharp"
);
@@clientName(DeploymentConfiguration, "BatchDeploymentConfiguration", "csharp");
@@clientName(DeploymentConfiguration.virtualMachineConfiguration,
  "vmConfiguration",
  "csharp"
);
@@clientName(VirtualMachineConfiguration, "BatchVmConfiguration", "csharp");
@@clientName(DataDisk, "BatchVmDataDisk", "csharp");
@@clientName(DataDisk.diskSizeGB, "DiskSizeInGB", "csharp");
@@clientName(VMExtension, "BatchVmExtension", "csharp");
@@clientName(VMExtension.type, "ExtensionType", "csharp");
@@clientName(ContainerConfiguration, "BatchVmContainerConfiguration", "csharp");
@@clientName(ContainerType, "BatchVmContainerType", "csharp");
@@clientName(ContainerRegistry, "BatchVmContainerRegistry", "csharp");
@@clientName(WindowsConfiguration.enableAutomaticUpdates,
  "IsAutomaticUpdateEnabled",
  "csharp"
);
@@clientName(ContainerRegistry.identityReference, "Identity", "csharp");
@@clientName(NetworkProfile, "BatchNetworkProfile", "csharp");
@@clientName(EndpointAccessProfile, "BatchEndpointAccessProfile", "csharp");
@@clientName(EndpointAccessDefaultAction,
  "BatchEndpointAccessDefaultAction",
  "csharp"
);
@@clientName(AllocationState, "BatchAccountPoolAllocationState", "csharp");
@@clientName(ApplicationPackageReference,
  "BatchApplicationPackageReference",
  "csharp"
);
@@alternateType(ApplicationPackageReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(CertificateReference, "BatchCertificateReference", "csharp");
@@alternateType(CertificateReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(MetadataItem, "BatchAccountPoolMetadataItem", "csharp");
@@clientName(MountConfiguration, "BatchMountConfiguration", "csharp");
@@clientName(AzureBlobFileSystemConfiguration,
  "BatchBlobFileSystemConfiguration",
  "csharp"
);
@@clientName(AzureBlobFileSystemConfiguration.identityReference,
  "Identity",
  "csharp"
);
@@clientName(AzureFileShareConfiguration,
  "BatchFileShareConfiguration",
  "csharp"
);
@@alternateType(ComputeNodeIdentityReference.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AutoStorageProperties,
  "BatchAccountAutoStorageConfiguration",
  "csharp"
);
@@clientName(AutoStorageProperties.lastKeySync, "LastKeySyncedOn", "csharp");
@@clientName(AutoStorageBaseProperties,
  "BatchAccountAutoStorageBaseConfiguration",
  "csharp"
);
@@alternateType(AutoStorageBaseProperties.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AutoStorageAuthenticationMode,
  "BatchAutoStorageAuthenticationMode",
  "csharp"
);
@@clientName(AutoStorageBaseProperties.nodeIdentityReference,
  "NodeIdentity",
  "csharp"
);
@@clientName(KeyVaultReference, "BatchKeyVaultReference", "csharp");
@@alternateType(KeyVaultReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AuthenticationMode, "BatchAuthenticationMode", "csharp");
@@clientName(EncryptionProperties,
  "BatchAccountEncryptionConfiguration",
  "csharp"
);
@@clientName(KeySource, "BatchAccountKeySource", "csharp");
@@clientName(IPRule, "BatchIPRule", "csharp");
@@clientName(ResourceFile.identityReference, "Identity", "csharp");
@@clientName(VirtualMachineFamilyCoreQuota, "BatchVmFamilyCoreQuota", "csharp");
@@clientName(ScaleSettings, "BatchAccountPoolScaleSettings", "csharp");
@@clientName(AutoScaleSettings, "BatchAccountAutoScaleSettings", "csharp");
@@clientName(FixedScaleSettings, "BatchAccountFixedScaleSettings", "csharp");
@@clientName(StartTask, "BatchAccountPoolStartTask", "csharp");
@@clientName(ResourceFile, "BatchResourceFile", "csharp");
@@clientName(EnvironmentSetting, "BatchEnvironmentSetting", "csharp");
@@clientName(TaskContainerSettings, "BatchTaskContainerSettings", "csharp");
@@clientName(ComputeNodeFillType, "BatchNodeFillType", "csharp");
@@clientName(UserAccount, "BatchUserAccount", "csharp");
@@clientName(ElevationLevel, "BatchUserAccountElevationLevel", "csharp");
@@clientName(AutoUserScope, "BatchAutoUserScope", "csharp");
@@clientName(AutoUserSpecification, "BatchAutoUserSpecification", "csharp");
@@clientName(LinuxUserConfiguration, "BatchLinuxUserConfiguration", "csharp");
@@clientName(WindowsUserConfiguration,
  "BatchWindowsUserConfiguration",
  "csharp"
);
@@clientName(LoginMode, "BatchWindowsLoginMode", "csharp");
@@clientName(ApplicationPackageProperties.storageUrlExpiry,
  "StorageUriExpireOn",
  "csharp"
);
@@clientName(SupportedSku, "BatchSupportedSku", "csharp");
@@clientName(ActivateApplicationPackageParameters,
  "BatchApplicationPackageActivateContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters,
  "BatchNameAvailabilityContent",
  "csharp"
);
@@alternateType(CheckNameAvailabilityParameters.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(CheckNameAvailabilityResult,
  "BatchNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(NameAvailabilityReason, "BatchNameUnavailableReason", "csharp");
@@clientName(CifsMountConfiguration, "BatchCifsMountConfiguration", "csharp");
@@clientName(CifsMountConfiguration.userName, "username", "csharp");
@@clientName(NFSMountConfiguration, "BatchNFSMountConfiguration", "csharp");
@@clientName(ContainerWorkingDirectory,
  "BatchContainerWorkingDirectory",
  "csharp"
);
@@clientName(DiffDiskPlacement, "BatchDiffDiskPlacement", "csharp");
@@clientName(DiskEncryptionTarget, "BatchDiskEncryptionTarget", "csharp");
@@clientName(InboundEndpointProtocol, "BatchInboundEndpointProtocol", "csharp");
@@clientName(InboundNatPool, "BatchInboundNatPool", "csharp");
@@clientName(IPAddressProvisioningType,
  "BatchIPAddressProvisioningType",
  "csharp"
);
@@clientName(IPRuleAction, "BatchIPRuleAction", "csharp");
@@clientName(NetworkConfiguration, "BatchNetworkConfiguration", "csharp");
@@clientName(NetworkConfiguration.dynamicVnetAssignmentScope,
  "dynamicVNetAssignmentScope",
  "csharp"
);
@@alternateType(NetworkConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(NetworkSecurityGroupRule,
  "BatchNetworkSecurityGroupRule",
  "csharp"
);
@@clientName(NetworkSecurityGroupRuleAccess,
  "BatchNetworkSecurityGroupRuleAccess",
  "csharp"
);
@@clientName(NodePlacementPolicyType, "BatchNodePlacementPolicyType", "csharp");
@@clientName(PackageState, "BatchApplicationPackageState", "csharp");
@@clientName(PrivateLinkServiceConnectionStatus,
  "BatchPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionState.actionsRequired,
  "actionRequired",
  "csharp"
);
@@clientName(PublicIPAddressConfiguration,
  "BatchPublicIPAddressConfiguration",
  "csharp"
);
@@clientName(SkuCapability, "BatchSkuCapability", "csharp");
@@clientName(UserIdentity, "BatchUserIdentity", "csharp");
@@clientName(ImageReference, "BatchImageReference", "csharp");
@@alternateType(ImageReference.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(CertificateCreateOrUpdateProperties.data, unknown, "csharp");
@@alternateType(KeyVaultProperties.keyIdentifier, url, "csharp");
@@clientName(AzureFileShareConfiguration.azureFileUrl, "FileUrl", "csharp");
@@clientName(MountConfiguration.azureBlobFileSystemConfiguration,
  "BlobFileSystemConfiguration",
  "csharp"
);
@@clientName(MountConfiguration.azureFileShareConfiguration,
  "FileShareConfiguration",
  "csharp"
);
@@clientName(ResourceFile.storageContainerUrl, "BlobContainerUri", "csharp");
@@clientName(ResourceFile.autoStorageContainerName,
  "AutoBlobContainerName",
  "csharp"
);
@@clientName(AccountKeyType, "BatchAccountKeyType", "csharp");
@@clientName(BatchAccountRegenerateKeyParameters.keyName, "KeyType", "csharp");
@@clientName(CertificateProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(CertificateCreateOrUpdateProperties.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(OSDisk, "BatchOSDisk", "csharp");
@@clientName(OSDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);
@@clientName(SecurityProfile, "BatchSecurityProfile", "csharp");
@@clientName(UefiSettings, "BatchUefiSettings", "csharp");
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVTpmEnabled", "csharp");
@@clientName(SecurityTypes, "BatchSecurityType", "csharp");
@@clientName(StorageAccountType.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(StorageAccountType, "BatchStorageAccountType", "csharp");
@@clientName(ProvisioningState, "BatchProvisioningState", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.Severity,
  "BatchSeverity",
  "csharp"
);
// @@clientName(NetworkSecurityPerimeterConfiguration,
//   "NetworkSecurityPerimeterConfigurationResource",
//   "csharp"
// );
@@clientName(Azure.ResourceManager.CommonTypes.AccessRule,
  "BatchAccessRule",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.AccessRuleDirection,
  "BatchAccessRuleDirection",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.AccessRuleProperties,
  "BatchAccessRuleProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.IssueType,
  "BatchIssueType",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ProvisioningIssue,
  "BatchProvisioningIssue",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ProvisioningIssueProperties,
  "BatchProvisioningIssueProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ResourceAssociation,
  "BatchResourceAssociation",
  "csharp"
);
@@clientName(SecurityEncryptionTypes, "BatchSecurityEncryptionType", "csharp");
@@clientName(PrivateEndpointConnection,
  "BatchPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateLinkResource, "BatchPrivateLinkResource", "csharp");
@@clientName(BatchAccountCreateParameters,
  "BatchAccountCreateOrUpdateContent",
  "csharp"
);
// @@clientName(CertificateCreateOrUpdateParameters, "Foooooooooooooo", "csharp");
@@clientName(BatchAccountRegenerateKeyParameters,
  "BatchAccountRegenerateKeyContent",
  "csharp"
);
