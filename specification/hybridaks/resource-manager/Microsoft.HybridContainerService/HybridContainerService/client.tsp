import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.HybridContainerService;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;

@@Azure.ClientGenerator.Core.clientName(
  HybridIdentityMetadataOperationGroup,
  "HybridIdentityMetadata",
  "!autorest"
);

@@clientName(AgentPool, "HybridContainerServiceAgentPool", "csharp");
@@clientName(VirtualNetwork, "HybridContainerServiceVirtualNetwork", "csharp");
@@clientName(VmSkuProfile, "HybridContainerServiceVmSku", "csharp");

@@clientName(AddonPhase, "ProvisionedClusterAddonPhase", "csharp");
@@clientName(
  AddonStatusProfile,
  "ProvisionedClusterAddonStatusProfile",
  "csharp"
);
@@clientName(
  AgentPoolProfile,
  "HybridContainerServiceAgentPoolProfile",
  "csharp"
);
@@clientName(AgentPoolProfile.osType, "OSType", "csharp");
@@clientName(AgentPoolProfile.osSKU, "OSSku", "csharp");
@@clientName(
  AgentPoolProvisioningStatus,
  "AgentPoolProvisioningStatusProperties",
  "csharp"
);
@@clientName(
  AgentPoolProvisioningStatusStatus,
  "AgentPoolProvisioningStatus",
  "csharp"
);
@@clientName(
  AzureHybridBenefit,
  "ProvisionedClusterAzureHybridBenefit",
  "csharp"
);
@@clientName(
  CloudProviderProfile,
  "ProvisionedClusterCloudProviderProfile",
  "csharp"
);
@@clientName(
  CloudProviderProfileInfraNetworkProfile,
  "ProvisionedClusterInfraNetworkProfile",
  "csharp"
);
@@clientName(
  ControlPlaneProfileControlPlaneEndpoint,
  "ProvisionedClusterControlPlaneEndpoint",
  "csharp"
);
@@clientName(
  ControlPlaneProfile,
  "ProvisionedClusterControlPlaneProfile",
  "csharp"
);
@@clientName(CredentialResult, "HybridContainerServiceCredential", "csharp");
@@clientName(Expander, "HybridContainerServiceExpander", "csharp");
@@clientName(
  ExtendedLocation,
  "HybridContainerServiceExtendedLocation",
  "csharp"
);
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(
  ExtendedLocationTypes,
  "HybridContainerServiceExtendedLocationType",
  "csharp"
);
@@clientName(LinuxProfilePropertiesSsh, "LinuxSshConfiguration", "csharp");
@@clientName(
  LinuxProfilePropertiesSshPublicKeysItem,
  "LinuxSshPublicKey",
  "csharp"
);
@@clientName(
  ListCredentialResponse,
  "HybridContainerServiceCredentialListResult",
  "csharp"
);
@@clientName(
  ListCredentialResponseError,
  "HybridContainerServiceCredentialListError",
  "csharp"
);
@@clientName(
  NamedAgentPoolProfile,
  "HybridContainerServiceNamedAgentPoolProfile",
  "csharp"
);
@@clientName(NetworkPolicy, "ProvisionedClusterNetworkPolicy", "csharp");
@@clientName(NetworkProfile, "ProvisionedClusterNetworkProfile", "csharp");
@@clientName(
  NetworkProfileLoadBalancerProfile,
  "ProvisionedClusterLoadBalancerProfile",
  "csharp"
);
@@clientName(OSSKU, "HybridContainerServiceOSSku", "csharp");
@@clientName(OsType, "HybridContainerServiceOSType", "csharp");
@@clientName(
  ProvisioningState,
  "HybridContainerServiceResourceProvisioningState",
  "csharp"
);
@@clientName(ProvisionedClusterPoolUpgradeProfile.osType, "OSType", "csharp");
@@clientName(
  ProvisionedClusterPropertiesStatus,
  "ProvisionedClusterStatus",
  "csharp"
);
@@clientName(SecurityProfile, "ProvisionedClusterSecurityProfile", "csharp");
@@clientName(SecurityProfileFipsImage.enabled, "IsFipsImageEnabled", "csharp");
@@clientName(
  VirtualNetworkProperties,
  "HybridContainerServiceVirtualNetworkProperties",
  "csharp"
);
@@clientName(
  VirtualNetworkProperties.ipAddressPrefix,
  "IPAddressPrefix",
  "csharp"
);
@@clientName(VirtualNetworkProperties.vlanID, "VlanId", "csharp");
@@clientName(
  VirtualNetworkPropertiesInfraVnetProfile,
  "InfraVnetProfile",
  "csharp"
);
@@clientName(
  VirtualNetworkPropertiesInfraVnetProfileHci,
  "HciInfraVnetProfile",
  "csharp"
);
@@clientName(
  VirtualNetworkPropertiesStatus,
  "HybridContainerServiceNetworkStatus",
  "csharp"
);
@@clientName(
  VirtualNetworkPropertiesStatusOperationStatusError,
  "HybridContainerServiceNetworkOperationError",
  "csharp"
);
@@clientName(
  VirtualNetworkPropertiesVipPoolItem,
  "KubernetesVirtualIPItem",
  "csharp"
);
@@clientName(
  VirtualNetworkPropertiesVmipPoolItem,
  "VirtualMachineIPItem",
  "csharp"
);
@@clientName(
  VmSkuProperties,
  "HybridContainerServiceVmSkuProperties",
  "csharp"
);
@@clientName(
  VmSkuCapabilities,
  "HybridContainerServiceVmSkuCapabilities",
  "csharp"
);
@@clientName(
  StorageProfileSmbCSIDriver.enabled,
  "IsSmbCsiDriverEnabled",
  "csharp"
);
@@clientName(
  StorageProfileNfsCSIDriver.enabled,
  "IsNfsCsiDriverEnabled",
  "csharp"
);

@@alternateType(VirtualNetwork.extendedLocation, ExtendedLocation, "csharp");

@@clientName(KubernetesVersionReadiness.osType, "OSType", "csharp");
@@clientName(KubernetesVersionReadiness.osSku, "OSSku", "csharp");

@@usage(AgentPoolProfile, Usage.input, "csharp");
@@usage(AgentPoolProfile, Usage.output, "csharp");
@@usage(ProvisionedClusterPoolUpgradeProfile, Usage.input, "csharp");
@@usage(ProvisionedClusterPoolUpgradeProfileProperties, Usage.input, "csharp");

/**
 * Provisioning state used by the shipped C# virtual network model.
 */
union VirtualNetworkProvisioningState {
  string,

  /** The request was accepted. */
  Accepted: "Accepted",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The operation failed. */
  Failed: "Failed",

  /** The operation is pending. */
  Pending: "Pending",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The resource is being updated. */
  Updating: "Updating",
}

@@clientName(
  VirtualNetworkProvisioningState,
  "HybridContainerServiceProvisioningState",
  "csharp"
);
@@alternateType(
  VirtualNetworkProperties.provisioningState,
  VirtualNetworkProvisioningState,
  "csharp"
);

@@clientName(
  ProvisionedClusterUpgradeProfiles.listUpgradeProfile,
  "ListUpgradeProfiles",
  "csharp"
);
@@access(
  ProvisionedClusterUpgradeProfiles.listUpgradeProfile,
  Access.internal,
  "csharp"
);

@@usage(AgentPoolProfile, Usage.input, "csharp");
@@usage(ProvisionedClusterUpgradeProfileProperties, Usage.input, "csharp");
@@usage(ProvisionedClusterUpgradeProfile, Usage.input, "csharp");
