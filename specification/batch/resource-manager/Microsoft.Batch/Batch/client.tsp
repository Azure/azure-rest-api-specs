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
@@alternateType(Application.etag, Azure.Core.EtagProperty.etag, "csharp");
@@clientName(ApplicationPackage, "BatchApplicationPackage", "csharp");
@@alternateType(ApplicationPackage.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@clientName(ApplicationPackageProperties.lastActivationTime,
  "LastActivatedOn",
  "csharp"
);
@@alternateType(ApplicationPackageProperties.storageUrl, url, "csharp");
@@clientName(PublicNetworkAccessType, "BatchPublicNetworkAccess", "csharp");
@@clientName(BatchAccountProperties.dedicatedCoreQuotaPerVMFamilyEnforced,
  "IsDedicatedCoreQuotaPerVmFamilyEnforced",
  "csharp"
);
@@clientName(BatchAccountProperties.dedicatedCoreQuotaPerVMFamily,
  "DedicatedCoreQuotaPerVmFamily",
  "csharp"
);
@@clientName(DetectorResponse, "BatchAccountDetector", "csharp");
@@alternateType(DetectorResponse.etag, Azure.Core.EtagProperty.etag, "csharp");
@@usage(DetectorResponse, Usage.input, "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "BatchAccountOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(EndpointDependency, "BatchAccountEndpointDependency", "csharp");
@@clientName(EndpointDetail, "BatchEndpointDetail", "csharp");
@@clientName(Pool, "BatchAccountPool", "csharp");
@@alternateType(Pool.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Pool.etag, Azure.Core.EtagProperty.etag, "csharp");
@@clientName(PoolProperties.lastModified, "LastModifiedOn", "csharp");
@@clientName(PoolProperties.provisioningStateTransitionTime,
  "provisioningStateTransitOn",
  "csharp"
);
@@clientName(PoolAllocationMode, "BatchAccountPoolAllocationMode", "csharp");
@@clientName(AutoScaleRun, "BatchAccountPoolAutoScaleRun", "csharp");
@@alternateType(AutoScaleRun.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "csharp"
);
@@clientName(ResizeOperationStatus, "BatchResizeOperationStatus", "csharp");
@@clientName(ComputeNodeDeallocationOption,
  "BatchNodeDeallocationOption",
  "csharp"
);
@@clientName(Certificate, "BatchAccountCertificate", "csharp");
@@alternateType(Certificate.etag, Azure.Core.EtagProperty.etag, "csharp");
@@usage(Certificate, Usage.input, "csharp");
@@clientName(CertificateFormat, "BatchAccountCertificateFormat", "csharp");
@@alternateType(CertificateProvisioningState,
  BatchAccountCertificateProvisioningState,
  "csharp"
);
@@clientName(CertificateProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(CertificateProperties.provisioningStateTransitionTime,
  "provisioningStateTransitOn",
  "csharp"
);
@@clientName(CertificateProperties.previousProvisioningStateTransitionTime,
  "previousProvisioningStateTransitOn",
  "csharp"
);
@@alternateType(CertificateProperties.deleteCertificateError,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "csharp"
);
@@clientName(CertificateStoreLocation,
  "BatchCertificateStoreLocation",
  "csharp"
);
@@clientName(CertificateVisibility, "BatchCertificateVisibility", "csharp");
@@clientName(DeploymentConfiguration, "BatchDeploymentConfiguration", "csharp");
@@clientName(DeploymentConfiguration.virtualMachineConfiguration,
  "vmConfiguration",
  "csharp"
);
@@clientName(VirtualMachineConfiguration, "BatchVmConfiguration", "csharp");
@@clientName(VirtualMachineConfiguration.osDisk, "OSDisk", "csharp");
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
@@clientName(EndpointAccessProfile.ipRules, "IPRules", "csharp");
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
@@clientName(AzureFileShareConfiguration.azureFileUrl, "FileUri", "csharp");
@@alternateType(AzureFileShareConfiguration.azureFileUrl, url, "csharp");
@@alternateType(ComputeNodeIdentityReference.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AutoStorageProperties,
  "BatchAccountAutoStorageConfiguration",
  "csharp"
);
@@clientName(AutoStorageProperties.lastKeySync, "LastKeySyncedOn", "csharp");
@@usage(AutoStorageProperties, Usage.input, "csharp");
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
@@alternateType(KeyVaultReference.url, url, "csharp");
@@clientName(AuthenticationMode, "BatchAuthenticationMode", "csharp");
@@clientName(AuthenticationMode.AAD, "Aad", "csharp");
@@clientName(EncryptionProperties,
  "BatchAccountEncryptionConfiguration",
  "csharp"
);
@@clientName(KeySource, "BatchAccountKeySource", "csharp");
@@clientName(IPRule, "BatchIPRule", "csharp");
@@clientName(VirtualMachineFamilyCoreQuota, "BatchVmFamilyCoreQuota", "csharp");
@@clientName(ScaleSettings, "BatchAccountPoolScaleSettings", "csharp");
@@clientName(AutoScaleSettings, "BatchAccountAutoScaleSettings", "csharp");
@@clientName(FixedScaleSettings, "BatchAccountFixedScaleSettings", "csharp");
@@clientName(StartTask, "BatchAccountPoolStartTask", "csharp");
@@clientName(ResourceFile.identityReference, "Identity", "csharp");
@@clientName(ResourceFile, "BatchResourceFile", "csharp");
@@alternateType(ResourceFile.httpUrl, url, "csharp");
@@alternateType(ResourceFile.storageContainerUrl, url, "csharp");
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
@@clientName(CheckNameAvailabilityParameters.type, "ResourceType", "csharp");
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
@@clientName(NFSMountConfiguration, "BatchNfsMountConfiguration", "csharp");
@@clientName(ContainerWorkingDirectory,
  "BatchContainerWorkingDirectory",
  "csharp"
);
@@clientName(DiskEncryptionTarget, "BatchDiskEncryptionTarget", "csharp");
@@clientName(DiskEncryptionTarget.OsDisk, "OSDisk", "csharp");
@@clientName(InboundEndpointProtocol, "BatchInboundEndpointProtocol", "csharp");
@@clientName(InboundEndpointProtocol.TCP, "Tcp", "csharp");
@@clientName(InboundEndpointProtocol.UDP, "Udp", "csharp");
@@clientName(InboundNatPool, "BatchInboundNatPool", "csharp");
@@clientName(IPAddressProvisioningType,
  "BatchIPAddressProvisioningType",
  "csharp"
);
@@alternateType(IPRuleAction, BatchIPRuleAction, "csharp");
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
@@clientName(PublicIPAddressConfiguration.ipAddressIds,
  "IPAddressIds",
  "csharp"
);
@@alternateType(PublicIPAddressConfiguration.ipAddressIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@clientName(SkuCapability, "BatchSkuCapability", "csharp");
@@clientName(UserIdentity, "BatchUserIdentity", "csharp");
@@clientName(ImageReference, "BatchImageReference", "csharp");
@@alternateType(ImageReference.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(CertificateCreateOrUpdateProperties.data, unknown, "csharp");
@@alternateType(KeyVaultProperties.keyIdentifier, url, "csharp");
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
@@clientName(SecurityTypes.confidentialVM, "ConfidentialVm", "csharp");
@@clientName(SecurityTypes, "BatchSecurityType", "csharp");
@@clientName(StorageAccountType.Standard_LRS, "StandardLrs", "csharp");
@@clientName(StorageAccountType.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(StorageAccountType.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(StorageAccountType, "BatchStorageAccountType", "csharp");
@@alternateType(ProvisioningState, BatchProvisioningState, "csharp");
@@alternateType(PoolProvisioningState,
  BatchAccountPoolProvisioningState,
  "csharp"
);
@@alternateType(DiffDiskPlacement, BatchDiffDiskPlacement, "csharp");
@@alternateType(PrivateEndpointConnectionProvisioningState,
  BatchPrivateEndpointConnectionProvisioningState,
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.Severity,
  "BatchSeverity",
  "csharp"
);
@@clientName(NetworkSecurityPerimeterConfigurations,
  "NetworkSecurityPerimeterConfiguration",
  "csharp"
);
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
@@clientName(SecurityEncryptionTypes.VMGuestStateOnly,
  "VmGuestStateOnly",
  "csharp"
);
@@clientName(SecurityEncryptionTypes, "BatchSecurityEncryptionType", "csharp");
@@clientName(AutomaticOSUpgradePolicy.osRollingUpgradeDeferral,
  "OSRollingUpgradeDeferral",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "BatchPrivateEndpointConnection",
  "csharp"
);
@@alternateType(PrivateEndpointConnection.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(PrivateLinkResource, "BatchPrivateLinkResource", "csharp");
@@alternateType(PrivateLinkResource.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@clientName(BatchAccountCreateParameters,
  "BatchAccountCreateOrUpdateContent",
  "csharp"
);
@@alternateType(BatchAccountCreateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(BatchAccountCreateParameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(CertificateCreateOrUpdateParameters,
  "BatchAccountCertificateCreateOrUpdateContent",
  "csharp"
);
@@clientName(BatchAccountRegenerateKeyParameters,
  "BatchAccountRegenerateKeyContent",
  "csharp"
);
@@clientName(BatchAccount, "BatchAccountRenamed", "csharp");
@@alternateType(BatchAccountUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(ServiceArtifactReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(BatchAccount, BatchAccountData, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BatchAccountData.properties,
  "csharp"
);
@@alternateType(BatchAccount.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// added to solve the problem that the c# resource class can inherit the `resource data` class
namespace Microsoft.Batch {
  /**
   * Contains information about an Azure Batch account.
   */
  @usage(Usage.input, "csharp")
  @clientName("BatchAccount", "csharp")
  model BatchAccountData
    is Azure.ResourceManager.ProxyResource<BatchAccountProperties> {
    ...Azure.ResourceManager.ResourceNameParameter<
      Resource = BatchAccount,
      KeyName = "accountName",
      SegmentName = "batchAccounts",
      NamePattern = "^[a-zA-Z0-9]+$"
    >;
    ...OmitProperties<
      BatchAccount,
      "id" | "name" | "type" | "properties" | "location"
    >;

    /** The geo-location where the resource lives */
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @visibility(Lifecycle.Read, Lifecycle.Create)
    location?: Azure.Core.azureLocation;
  }

  /**
   * The provisioned state of the resource
   */
  union BatchProvisioningState {
    ProvisioningState,
    string,
  }

  /**
   * The provisioning state of the private endpoint connection.
   */
  union BatchPrivateEndpointConnectionProvisioningState {
    PrivateEndpointConnectionProvisioningState,
    string,
  }

  /**
   * The action when client IP address is matched.
   */
  union BatchIPRuleAction {
    IPRuleAction,
    string,
  }

  /**
   * The location where the OS disk should be placed.
   */
  union BatchDiffDiskPlacement {
    DiffDiskPlacement,
    string,
  }

  /**
   * The current state of the pool.
   */
  union BatchAccountPoolProvisioningState {
    PoolProvisioningState,
    string,
  }

  /**
   * The provisioning state of the certificate.
   */
  union BatchAccountCertificateProvisioningState {
    CertificateProvisioningState,
    string,
  }
}
