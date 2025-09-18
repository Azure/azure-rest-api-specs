import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridContainerService;

@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`balance-similar-node-groups`,
  "balanceSimilarNodeGroups"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`max-empty-bulk-delete`,
  "maxEmptyBulkDelete"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`max-graceful-termination-sec`,
  "maxGracefulTerminationSec"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`max-node-provision-time`,
  "maxNodeProvisionTime"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`max-total-unready-percentage`,
  "maxTotalUnreadyPercentage"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`new-pod-scale-up-delay`,
  "newPodScaleUpDelay"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`ok-total-unready-count`,
  "okTotalUnreadyCount"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scan-interval`,
  "scanInterval"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-delay-after-add`,
  "scaleDownDelayAfterAdd"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-delay-after-delete`,
  "scaleDownDelayAfterDelete"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-delay-after-failure`,
  "scaleDownDelayAfterFailure"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-unneeded-time`,
  "scaleDownUnneededTime"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-unready-time`,
  "scaleDownUnreadyTime"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`scale-down-utilization-threshold`,
  "scaleDownUtilizationThreshold"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`skip-nodes-with-local-storage`,
  "skipNodesWithLocalStorage"
);
@@clientName(ProvisionedClusterPropertiesAutoScalerProfile.`skip-nodes-with-system-pods`,
  "skipNodesWithSystemPods"
);

@@clientLocation(ProvisionedClusters.get, "provisionedClusterInstances");
@@clientLocation(ProvisionedClusters.createOrUpdate,
  "provisionedClusterInstances"
);
@@clientName(ProvisionedClusters.createOrUpdate::parameters.resource,
  "provisionedClusterInstance"
);
@@clientLocation(ProvisionedClusters.delete, "provisionedClusterInstances");
@@clientLocation(ProvisionedClusters.list, "provisionedClusterInstances");
@@clientLocation(ProvisionedClusters.listUserKubeconfig,
  "provisionedClusterInstances"
);
@@clientLocation(ProvisionedClusters.listAdminKubeconfig,
  "provisionedClusterInstances"
);

@@clientLocation(ProvisionedClusterUpgradeProfiles.getUpgradeProfile,
  "provisionedClusterInstances"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ProvisionedClusterUpgradeProfile.properties);

@@clientLocation(HybridIdentityMetadataOperationGroup.get,
  "HybridIdentityMetadata"
);
@@clientLocation(HybridIdentityMetadataOperationGroup.put,
  "HybridIdentityMetadata"
);
@@clientName(HybridIdentityMetadataOperationGroup.put::parameters.resource,
  "body"
);
@@clientLocation(HybridIdentityMetadataOperationGroup.delete,
  "HybridIdentityMetadata"
);
@@clientLocation(HybridIdentityMetadataOperationGroup.listByCluster,
  "HybridIdentityMetadata"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(hybridIdentityMetadata.properties);

@@clientLocation(AgentPools.get, "agentPool");
@@clientLocation(AgentPools.createOrUpdate, "agentPool");
@@clientName(AgentPools.createOrUpdate::parameters.resource, "agentPool");
@@clientLocation(AgentPools.delete, "agentPool");
@@clientLocation(AgentPools.listByProvisionedCluster, "agentPool");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(agentPool.properties);

@@clientLocation(KubernetesVersionProfiles.getKubernetesVersions, "");
@@clientLocation(KubernetesVersionProfiles.putKubernetesVersions, "");
@@clientName(KubernetesVersionProfiles.putKubernetesVersions::parameters.resource,
  "kubernetesVersions"
);
@@clientLocation(KubernetesVersionProfiles.deleteKubernetesVersions, "");
@@clientLocation(KubernetesVersionProfiles.list, "KubernetesVersions");

@@clientLocation(VmSkuProfiles.getVMSkus, "");
@@clientLocation(VmSkuProfiles.putVMSkus, "");
@@clientName(VmSkuProfiles.putVMSkus::parameters.resource, "skus");
@@clientLocation(VmSkuProfiles.deleteVMSkus, "");
@@clientLocation(VmSkuProfiles.list, "VMSkus");

@@clientLocation(VirtualNetworks.retrieve, "virtualNetworks");
@@clientLocation(VirtualNetworks.createOrUpdate, "virtualNetworks");
@@clientName(VirtualNetworks.createOrUpdate::parameters.resource,
  "virtualNetworks"
);
@@clientLocation(VirtualNetworks.update, "virtualNetworks");
@@clientName(VirtualNetworks.update::parameters.properties, "virtualNetworks");
@@clientLocation(VirtualNetworks.delete, "virtualNetworks");
@@clientLocation(VirtualNetworks.listByResourceGroup, "virtualNetworks");
@@clientLocation(VirtualNetworks.listBySubscription, "virtualNetworks");
