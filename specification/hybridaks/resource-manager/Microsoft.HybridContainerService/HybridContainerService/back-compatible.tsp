import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.HybridContainerService;

@@clientName(VmSkuProfiles.getVMSkus, "getVmSkus", "autorest");
@@clientName(VmSkuProfiles.createVMSkus, "createVmSkus", "autorest");
@@clientName(VmSkuProfiles.deleteVMSkus, "deleteVmSkus", "autorest");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(AgentPool.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(HybridIdentityMetadata.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(ProvisionedClusterUpgradeProfile.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(VmSkuProfile.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(ProvisionedClusterProperties.linuxProfile, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(LinuxProfileProperties.ssh, "csharp");
@@clientName(LinuxProfilePropertiesSsh.publicKeys, "SshPublicKeys", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(
  ProvisionedClusterProperties.clusterVMAccessProfile,
  "csharp"
);
@@clientName(
  ClusterVMAccessProfile.authorizedIPRanges,
  "ClusterVmAccessAuthorizedIPRanges",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(ProvisionedClusterProperties.cloudProviderProfile, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserves the flattened data shape of the shipped C# SDK."
@@flattenProperty(CloudProviderProfile.infraNetworkProfile, "csharp");
@@clientName(
  CloudProviderProfileInfraNetworkProfile.vnetSubnetIds,
  "InfraNetworkVnetSubnetIds",
  "csharp"
);
