import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core.Legacy;
using Azure.ResourceManager;
using Microsoft.HybridContainerService;

@@Azure.ClientGenerator.Core.clientName(
  HybridIdentityMetadataOperationGroup,
  "HybridIdentityMetadata",
  "!autorest"
);

// Preserve the existing .NET management SDK resource names during the TypeSpec migration.
@@Azure.ClientGenerator.Core.clientName(
  AgentPool,
  "HybridContainerServiceAgentPool",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetwork,
  "HybridContainerServiceVirtualNetwork",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VmSkuProfile,
  "HybridContainerServiceVmSku",
  "csharp"
);

@@Azure.ClientGenerator.Core.clientName(
  AddonPhase,
  "ProvisionedClusterAddonPhase",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AddonStatusProfile,
  "ProvisionedClusterAddonStatusProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AgentPoolProfile,
  "HybridContainerServiceAgentPoolProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AgentPoolProvisioningStatus,
  "AgentPoolProvisioningStatusProperties",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AgentPoolProvisioningStatusStatus,
  "AgentPoolProvisioningStatus",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AzureHybridBenefit,
  "ProvisionedClusterAzureHybridBenefit",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  CloudProviderProfile,
  "ProvisionedClusterCloudProviderProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  CloudProviderProfileInfraNetworkProfile,
  "ProvisionedClusterInfraNetworkProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ControlPlaneProfile,
  "ProvisionedClusterControlPlaneProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  CredentialResult,
  "HybridContainerServiceCredential",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  Expander,
  "HybridContainerServiceExpander",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ExtendedLocation,
  "HybridContainerServiceExtendedLocation",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ExtendedLocationTypes,
  "HybridContainerServiceExtendedLocationType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  LinuxProfilePropertiesSsh,
  "LinuxSshConfiguration",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  LinuxProfilePropertiesSshPublicKeysItem,
  "LinuxSshPublicKey",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  KeyRotationState,
  "ProvisionedClusterKeyRotationState",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  KeyRotationStatus,
  "ProvisionedClusterKeyRotationStatus",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ListCredentialResponse,
  "HybridContainerServiceCredentialListResult",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ListCredentialResponseError,
  "HybridContainerServiceCredentialListError",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  NamedAgentPoolProfile,
  "HybridContainerServiceNamedAgentPoolProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  NetworkPolicy,
  "ProvisionedClusterNetworkPolicy",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  NetworkProfile,
  "ProvisionedClusterNetworkProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  NetworkProfileLoadBalancerProfile,
  "ProvisionedClusterLoadBalancerProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  OSSKU,
  "HybridContainerServiceOSSku",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  OsType,
  "HybridContainerServiceOSType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ProvisionedClusterPropertiesStatus,
  "ProvisionedClusterStatus",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ProvisioningState,
  "HybridContainerServiceResourceProvisioningState",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  SecurityProfile,
  "ProvisionedClusterSecurityProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkProperties,
  "HybridContainerServiceVirtualNetworkProperties",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesInfraVnetProfile,
  "InfraVnetProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesInfraVnetProfileHci,
  "HciInfraVnetProfile",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesStatus,
  "HybridContainerServiceNetworkStatus",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesStatusOperationStatusError,
  "HybridContainerServiceNetworkOperationError",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesVipPoolItem,
  "KubernetesVirtualIPItem",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkPropertiesVmipPoolItem,
  "VirtualMachineIPItem",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VmSkuCapabilities,
  "HybridContainerServiceVmSkuCapabilities",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VmSkuProperties,
  "HybridContainerServiceVmSkuProperties",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AgentPoolProfile.osSKU,
  "OSSku",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  AgentPoolProfile.osType,
  "OSType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ClusterVMAccessProfile.authorizedIPRanges,
  "ClusterVmAccessAuthorizedIPRanges",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  CloudProviderProfileInfraNetworkProfile.vnetSubnetIds,
  "InfraNetworkVnetSubnetIds",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ExtendedLocation.type,
  "ExtendedLocationType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  KubernetesVersionReadiness.osSku,
  "OSSku",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  KubernetesVersionReadiness.osType,
  "OSType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  LinuxProfilePropertiesSsh.publicKeys,
  "SshPublicKeys",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ProvisionedClusterPoolUpgradeProfile.osType,
  "OSType",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  SecurityProfileFipsImage.enabled,
  "IsFipsImageEnabled",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  StorageProfileNfsCSIDriver.enabled,
  "IsNfsCsiDriverEnabled",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  StorageProfileSmbCSIDriver.enabled,
  "IsSmbCsiDriverEnabled",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkProperties.ipAddressPrefix,
  "IPAddressPrefix",
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  VirtualNetworkProperties.vlanID,
  "VlanId",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AgentPool.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(HybridIdentityMetadata.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProvisionedClusterUpgradeProfile.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VmSkuProfile.properties, "csharp");

@@Azure.ClientGenerator.Core.usage(
  AgentPoolProfile,

    | Azure.ClientGenerator.Core.Usage.input
    | Azure.ClientGenerator.Core.Usage.output,
  "csharp"
);
@@Azure.ClientGenerator.Core.usage(
  ProvisionedClusterPoolUpgradeProfile,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@Azure.ClientGenerator.Core.usage(
  ProvisionedClusterPoolUpgradeProfileProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@Azure.ClientGenerator.Core.usage(
  ProvisionedClusterUpgradeProfileProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

namespace Microsoft.HybridContainerService {
  /**
   * Provisioning state used by the virtual network model in the existing .NET SDK.
   */
  union HybridContainerServiceProvisioningState {
    string,
    ResourceProvisioningState,

    /** The resource is pending. */
    Pending: "Pending",

    /** The resource is being created. */
    Creating: "Creating",

    /** The resource is being deleted. */
    Deleting: "Deleting",

    /** The resource is being updated. */
    Updating: "Updating",

    /** The resource request was accepted. */
    Accepted: "Accepted",
  }
}

@@Azure.ClientGenerator.Core.alternateType(
  VirtualNetworkProperties.provisioningState,
  HybridContainerServiceProvisioningState,
  "csharp"
);
@@Azure.ClientGenerator.Core.alternateType(
  VirtualNetwork.extendedLocation,
  ExtendedLocation,
  "csharp"
);

@@Azure.ClientGenerator.Core.access(
  ProvisionedClusterUpgradeProfiles.listUpgradeProfile,
  Azure.ClientGenerator.Core.Access.internal,
  "csharp"
);
@@Azure.ClientGenerator.Core.clientName(
  ProvisionedClusterUpgradeProfiles.listUpgradeProfile,
  "ListUpgradeProfiles",
  "csharp"
);
