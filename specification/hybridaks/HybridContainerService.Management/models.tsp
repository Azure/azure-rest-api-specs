import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridContainerService;

/**
 * Network policy used for building Kubernetes network. Possible values include: 'calico'.
 */
union NetworkPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  calico: "calico",
}

/**
 * The particular KubernetesVersion Image OS Type (Linux, Windows)
 */
union OsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux: "Linux",
}

/**
 * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
 */
union Ossku {
  string,

  /**
   * Use Mariner as the OS for node images.
   */
  CBLMariner: "CBLMariner",

  /**
   * Use Windows2019 as the OS for node images.
   */
  Windows2019: "Windows2019",

  /**
   * Use Windows2022 as the OS for node images.
   */
  Windows2022: "Windows2022",
}

/**
 * Provisioning state of the resource
 */
union ResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Upgrading: "Upgrading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
}

/**
 * Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'
 */
union AddonPhase {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  pending: "pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  provisioning: "provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `provisioning {HelmChartInstalled}`: "provisioning {HelmChartInstalled}",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `provisioning {MSICertificateDownloaded}`: "provisioning {MSICertificateDownloaded}",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  provisioned: "provisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  deleting: "deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  upgrading: "upgrading",
}

/**
 * Indicates whether Azure Hybrid Benefit is opted in. Default value is false
 */
union AzureHybridBenefit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotApplicable: "NotApplicable",
}

/**
 * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
 */
union Expander {
  string,

  /**
   * Selects the node group that will have the least idle CPU (if tied, unused memory) after scale-up. This is useful when you have different classes of nodes, for example, high CPU or high memory nodes, and only want to expand those when there are pending pods that need a lot of those resources.
   */
  `least-waste`: "least-waste",

  /**
   * Selects the node group that would be able to schedule the most pods when scaling up. This is useful when you are using nodeSelector to make sure certain pods land on certain nodes. Note that this won't cause the autoscaler to select bigger nodes vs. smaller, as it can add multiple smaller nodes at once.
   */
  `most-pods`: "most-pods",

  /**
   * Selects the node group that has the highest priority assigned by the user. It's configuration is described in more details [here](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md).
   */
  priority: "priority",

  /**
   * Used when you don't have a particular need for the node groups to scale differently.
   */
  random: "random",
}

/**
 * The extended location type. Allowed value: 'CustomLocation'
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CustomLocation: "CustomLocation",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
}

/**
 * Properties of the provisioned cluster.
 */
model ProvisionedClusterProperties {
  /**
   * The profile for Linux VMs in the provisioned cluster.
   */
  linuxProfile?: LinuxProfileProperties;

  /**
   * The profile for control plane of the provisioned cluster.
   */
  controlPlane?: ControlPlaneProfile;

  /**
   * The version of Kubernetes in use by the provisioned cluster.
   */
  kubernetesVersion?: string;

  /**
   * The network configuration profile for the provisioned cluster.
   */
  networkProfile?: NetworkProfile;

  /**
   * The storage configuration profile for the provisioned cluster.
   */
  storageProfile?: StorageProfile;

  /**
   * The SSH restricted access profile for the VMs in the provisioned cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  clusterVMAccessProfile?: ClusterVMAccessProfile;

  /**
   * The agent pool properties for the provisioned cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  agentPoolProfiles?: NamedAgentPoolProfile[];

  /**
   * The profile for the underlying cloud infrastructure provider for the provisioned cluster.
   */
  cloudProviderProfile?: CloudProviderProfile;

  /**
   * The status of the latest long running operation for the provisioned cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The observed status of the provisioned cluster.
   */
  @visibility(Lifecycle.Read)
  status?: ProvisionedClusterPropertiesStatus;

  /**
   * The license profile of the provisioned cluster.
   */
  licenseProfile?: ProvisionedClusterLicenseProfile;

  /**
   * Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.
   */
  autoScalerProfile?: ProvisionedClusterPropertiesAutoScalerProfile;
}

/**
 * SSH profile for control plane and nodepool VMs of the provisioned cluster.
 */
model LinuxProfileProperties {
  /**
   * SSH configuration for VMs of the provisioned cluster.
   */
  ssh?: LinuxProfilePropertiesSsh;
}

/**
 * SSH configuration for VMs of the provisioned cluster.
 */
model LinuxProfilePropertiesSsh {
  /**
   * The list of SSH public keys used to authenticate with VMs. A maximum of 1 key may be specified.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  publicKeys?: LinuxProfilePropertiesSshPublicKeysItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LinuxProfilePropertiesSshPublicKeysItem {
  /**
   * Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.
   */
  keyData?: string;
}

/**
 * The properties of the control plane nodes of the provisioned cluster
 */
model ControlPlaneProfile {
  /**
   * Number of control plane nodes. The default value is 1, and the count should be an odd number
   */
  count?: int32 = 1;

  /**
   * VM sku size of the control plane nodes
   */
  vmSize?: string;

  /**
   * IP Address of the Kubernetes API server
   */
  controlPlaneEndpoint?: ControlPlaneProfileControlPlaneEndpoint;
}

/**
 * IP Address of the Kubernetes API server
 */
model ControlPlaneProfileControlPlaneEndpoint {
  /**
   * IP address of the Kubernetes API server
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  hostIP?: string;
}

/**
 * The network configuration profile for the provisioned cluster.
 */
model NetworkProfile {
  /**
   * Profile of the HA Proxy load balancer.
   */
  loadBalancerProfile?: NetworkProfileLoadBalancerProfile;

  /**
   * Network policy used for building Kubernetes network. Possible values include: 'calico'.
   */
  networkPolicy?: NetworkPolicy = NetworkPolicy.calico;

  /**
   * A CIDR notation IP Address range from which to assign pod IPs.
   */
  podCidr?: string;
}

/**
 * Profile of the HA Proxy load balancer.
 */
model NetworkProfileLoadBalancerProfile {
  /**
   * Number of HA Proxy load balancer VMs. The default value is 0.
   */
  count?: int32;
}

/**
 * The storage configuration profile for the provisioned cluster.
 */
model StorageProfile {
  /**
   * SMB CSI Driver settings for the storage profile.
   */
  smbCsiDriver?: StorageProfileSmbCSIDriver;

  /**
   * NFS CSI Driver settings for the storage profile.
   */
  nfsCsiDriver?: StorageProfileNfsCSIDriver;
}

/**
 * SMB CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model StorageProfileSmbCSIDriver {
  /**
   * Indicates whether to enable SMB CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * NFS CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model StorageProfileNfsCSIDriver {
  /**
   * Indicates whether to enable NFS CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * The SSH restricted access profile for the VMs in the provisioned cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model ClusterVMAccessProfile {
  /**
   * IP Address or CIDR for SSH access to VMs in the provisioned cluster
   */
  authorizedIPRanges?: string;
}

/**
 * Profile of the default agent pool along with a name parameter
 */
model NamedAgentPoolProfile {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolName;
}

/**
 * Profile for agent pool properties specified during creation
 */
model AgentPoolProfile {
  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  osType?: OsType;

  /**
   * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  osSKU?: Ossku;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nodeLabels?: Record<string>;

  /**
   * Taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * The maximum number of nodes for auto-scaling
   */
  maxCount?: int32;

  /**
   * The minimum number of nodes for auto-scaling
   */
  minCount?: int32;

  /**
   * Whether to enable auto-scaler. Default value is false
   */
  enableAutoScaling?: boolean;

  /**
   * The maximum number of pods that can run on a node.
   */
  maxPods?: int32;
}

/**
 * Profile for agent pool properties that can be updated
 */
model AgentPoolUpdateProfile {
  /**
   * Number of nodes in the agent pool. The default value is 1.
   */
  count?: int32 = 1;

  /**
   * The VM sku size of the agent pool node VMs.
   */
  vmSize?: string;

  /**
   * Version of Kubernetes in use by the agent pool. This is inherited from the kubernetesVersion of the provisioned cluster.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;
}

/**
 * Name of the default Agent Pool
 */
model AgentPoolName {
  /**
   * Unique name of the default agent pool in the context of the provisioned cluster. Default value is <clusterName>-nodepool1
   */
  name?: string;
}

/**
 * The profile for the underlying cloud infrastructure provider for the provisioned cluster.
 */
model CloudProviderProfile {
  /**
   * The profile for the infrastructure networks used by the provisioned cluster
   */
  infraNetworkProfile?: CloudProviderProfileInfraNetworkProfile;
}

/**
 * The profile for the infrastructure networks used by the provisioned cluster
 */
model CloudProviderProfileInfraNetworkProfile {
  /**
   * List of ARM resource Ids (maximum 1) for the infrastructure network object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/logicalNetworks/{logicalNetworkName}
   */
  vnetSubnetIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/logicalNetworks";
    },
    {
      type: "Microsoft.HybridContainerService/virtualNetworks";
    }
  ]>[];
}

/**
 * The observed status of the provisioned cluster.
 */
model ProvisionedClusterPropertiesStatus {
  /**
   * The detailed status of the provisioned cluster components including addons.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  controlPlaneStatus?: AddonStatusProfile[];

  /**
   * The current state of the provisioned cluster.
   */
  @visibility(Lifecycle.Read)
  currentState?: ResourceProvisioningState;

  /**
   * Error messages during a provisioned cluster operation or steady state.
   */
  errorMessage?: string;
}

/**
 * The status profile of the addons and other kubernetes components
 */
model AddonStatusProfile {
  /**
   * Name of the addon or component
   */
  name?: string;

  /**
   * Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'
   */
  phase?: AddonPhase;

  /**
   * Indicates whether the addon or component is ready
   */
  ready?: boolean;

  /**
   * Observed error message from the addon or component
   */
  errorMessage?: string;
}

/**
 * The license profile of the provisioned cluster.
 */
model ProvisionedClusterLicenseProfile {
  /**
   * Indicates whether Azure Hybrid Benefit is opted in. Default value is false
   */
  azureHybridBenefit?: AzureHybridBenefit = AzureHybridBenefit.NotApplicable;
}

/**
 * Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.
 */
model ProvisionedClusterPropertiesAutoScalerProfile {
  /**
   * Valid values are 'true' and 'false'
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `balance-similar-node-groups`?: string;

  /**
   * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
   */
  expander?: Expander;

  /**
   * The default is 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `max-empty-bulk-delete`?: string;

  /**
   * The default is 600.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `max-graceful-termination-sec`?: string;

  /**
   * The default is '15m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `max-node-provision-time`?: string;

  /**
   * The default is 45. The maximum is 100 and the minimum is 0.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `max-total-unready-percentage`?: string;

  /**
   * For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. The default is '0s'. Values must be an integer followed by a unit ('s' for seconds, 'm' for minutes, 'h' for hours, etc).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `new-pod-scale-up-delay`?: string;

  /**
   * This must be an integer. The default is 3.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `ok-total-unready-count`?: string;

  /**
   * The default is '10'. Values must be an integer number of seconds.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scan-interval`?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-delay-after-add`?: string;

  /**
   * The default is the scan-interval. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-delay-after-delete`?: string;

  /**
   * The default is '3m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-delay-after-failure`?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-unneeded-time`?: string;

  /**
   * The default is '20m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-unready-time`?: string;

  /**
   * The default is '0.5'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `scale-down-utilization-threshold`?: string;

  /**
   * The default is true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `skip-nodes-with-local-storage`?: string;

  /**
   * The default is true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  `skip-nodes-with-system-pods`?: string;
}

/**
 * Extended location pointing to the underlying infrastructure
 */
model ExtendedLocation {
  /**
   * The extended location type. Allowed value: 'CustomLocation'
   */
  type?: ExtendedLocationTypes;

  /**
   * ARM Id of the extended location.
   */
  name?: string;
}

/**
 * Control plane and agent pool upgrade profiles.
 */
model ProvisionedClusterUpgradeProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The list of available kubernetes version upgrades for the control plane.
   */
  controlPlaneProfile: ProvisionedClusterPoolUpgradeProfile;
}

/**
 * The list of available kubernetes versions for upgrade.
 */
model ProvisionedClusterPoolUpgradeProfile {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * List of available kubernetes versions for upgrade.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  upgrades?: ProvisionedClusterPoolUpgradeProfileProperties[];
}

/**
 * The upgrade properties.
 */
model ProvisionedClusterPoolUpgradeProfileProperties {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;
}

/**
 * Defines the resource properties for the hybrid identity metadata.
 */
model HybridIdentityMetadataProperties {
  /**
   * Unique id of the parent provisioned cluster resource.
   */
  resourceUid?: string;

  /**
   * Onboarding public key for provisioning the Managed identity for the connected cluster.
   */
  publicKey?: string;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/**
 * List of hybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model hybridIdentityMetadataList is Azure.Core.Page<hybridIdentityMetadata>;

/**
 * Properties of the agent pool resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolProvisioningStatus;
}

/**
 * The agentPool resource provisioning status definition
 */
model AgentPoolProvisioningStatus {
  /**
   * The status of the latest long running operation for the agent pool.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The observed status of the agent pool.
   */
  status?: AgentPoolProvisioningStatusStatus;
}

/**
 * The observed status of the agent pool.
 */
model AgentPoolProvisioningStatusStatus {
  /**
   * The current state of the agent pool.
   */
  @visibility(Lifecycle.Read)
  currentState?: ResourceProvisioningState;

  /**
   * Error messages during an agent pool operation or steady state.
   */
  errorMessage?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  readyReplicas?: AgentPoolUpdateProfile[];
}

/**
 * The list kubeconfig result response.
 */
model ListCredentialResponse {
  /**
   * Operation Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Operation Name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ARM Resource Id of the provisioned cluster instance
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridContainerService/provisionedClusterInstances";
    }
  ]>;

  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  status?: ResourceProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  error?: ListCredentialResponseError;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: ListCredentialResponseProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListCredentialResponseError {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  code?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListCredentialResponseProperties {
  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  kubeconfigs?: CredentialResult[];
}

/**
 * The credential result response.
 */
model CredentialResult {
  /**
   * The name of the credential.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility(Lifecycle.Read)
  value?: bytes;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KubernetesVersionProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported Kubernetes versions
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  values?: KubernetesVersionProperties[];
}

/**
 * Kubernetes version profile for given major.minor release
 */
model KubernetesVersionProperties {
  /**
   * major.minor version of Kubernetes release
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Whether this version is in preview mode.
   */
  @visibility(Lifecycle.Read)
  isPreview?: boolean;

  /**
   * Patch versions of a Kubernetes release
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  patchVersions?: Record<KubernetesPatchVersions>;
}

/**
 * Kubernetes Patch Version profile
 */
model KubernetesPatchVersions {
  /**
   * Indicates whether the kubernetes version image is ready or not
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  readiness?: KubernetesVersionReadiness[];

  /**
   * Possible upgrade paths for given patch version
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  upgrades?: string[];
}

/**
 * Indicates whether the kubernetes version image is ready or not
 */
model KubernetesVersionReadiness {
  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
   */
  osSku?: Ossku;

  /**
   * Whether the kubernetes version image is ready or not
   */
  @visibility(Lifecycle.Read)
  ready?: boolean;

  /**
   * The error message for version not being ready
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * List of supported kubernetes versions.
 */
model KubernetesVersionProfileList {
  @pageItems
  @doc("The collection of kubernetes profiles.")
  value?: KubernetesVersionProfile[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

/**
 * List of all agent pool resources associated with the provisioned cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model agentPoolListResult {
  @pageItems
  @doc("The collection of agent pools.")
  value?: agentPool[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

/**
 * Lists the ProvisionedClusterInstance resource associated with the ConnectedCluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model provisionedClusterListResult {
  @pageItems
  @doc("The collection of provisioned clusters.")
  value?: provisionedCluster[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

/**
 * A list of virtual network resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model virtualNetworksListResult {
  @pageItems
  @doc("The collection of virtual networks.")
  value?: virtualNetwork[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VmSkuProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported VM SKUs.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  values?: VmSkuProperties[];
}

/**
 * The profile for supported VM SKUs
 */
model VmSkuProperties {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The list of name-value pairs to describe VM SKU capabilities like MemoryGB, vCPUs, etc.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  capabilities?: VmSkuCapabilities[];

  /**
   * The name of the VM SKU
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The tier of the VM SKU
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The size of the VM SKU
   */
  @visibility(Lifecycle.Read)
  size?: string;
}

/**
 * Describes the VM SKU capabilities like MemoryGB, vCPUs, etc.
 */
model VmSkuCapabilities {
  /**
   * Name of the VM SKU capability
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Value of the VM SKU capability
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The list of supported VM SKUs.
 */
model VmSkuProfileList {
  @pageItems
  @doc("The collection of VmSkuProfile.")
  value?: VmSkuProfile[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Properties of the virtual network resource
 */
model VirtualNetworkProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  /**
   * Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  /**
   * Range of IP Addresses for Kubernetes node VMs
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vmipPool?: VirtualNetworkPropertiesVmipPoolItem[];

  /**
   * List of DNS server IP Addresses associated with the network
   */
  dnsServers?: string[];

  /**
   * IP Address of the Gateway associated with the network
   */
  gateway?: string;

  /**
   * IP Address Prefix of the network
   */
  ipAddressPrefix?: string;

  /**
   * VLAN Id used by the network
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  vlanID?: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Status of the virtual network resource
   */
  @visibility(Lifecycle.Read)
  status?: VirtualNetworkPropertiesStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesInfraVnetProfile {
  /**
   * Infrastructure network profile for HCI platform
   */
  hci?: VirtualNetworkPropertiesInfraVnetProfileHci;
}

/**
 * Infrastructure network profile for HCI platform
 */
model VirtualNetworkPropertiesInfraVnetProfileHci {
  /**
   * Group in MOC(Microsoft On-premises Cloud)
   */
  mocGroup?: string;

  /**
   * Location in MOC(Microsoft On-premises Cloud)
   */
  mocLocation?: string;

  /**
   * Virtual Network name in MOC(Microsoft On-premises Cloud)
   */
  mocVnetName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesVipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VirtualNetworkPropertiesVmipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;
}

/**
 * Status of the virtual network resource
 */
model VirtualNetworkPropertiesStatus {
  /**
   * The detailed status of the long running operation.
   */
  operationStatus?: VirtualNetworkPropertiesStatusOperationStatus;
}

/**
 * The detailed status of the long running operation.
 */
model VirtualNetworkPropertiesStatusOperationStatus {
  /**
   * The error if any from the operation.
   */
  error?: VirtualNetworkPropertiesStatusOperationStatusError;

  /**
   * The identifier of the operation.
   */
  operationId?: string;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * The error if any from the operation.
 */
model VirtualNetworkPropertiesStatusOperationStatusError {
  /**
   * The error code from the operation.
   */
  code?: string;

  /**
   * The error message from the operation.
   */
  message?: string;
}

/**
 * Extended location pointing to the underlying infrastructure
 */
model VirtualNetworkExtendedLocation {
  /**
   * The extended location type. Allowed value: 'CustomLocation'
   */
  type?: ExtendedLocationTypes;

  /**
   * ARM Id of the extended location.
   */
  name?: string;
}

/**
 * The Virtual Network resource patch definition.
 */
model VirtualNetworksPatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The profile for Linux VMs in the provisioned cluster.
 */
model LinuxProfile {
  /**
   * Profile for Linux VMs in the container service cluster.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Initial suppression to prevent breaking change"
  linuxProfile?: LinuxProfileProperties;
}

/**
 * URI parameter for the connected cluster resource.
 */
model ConnectedClusterResourceUriParameter {
  @path(#{ allowReserved: true })
  @doc("The fully qualified Azure Resource Manager identifier of the connected cluster resource.")
  connectedClusterResourceUri: string;
}

/**
 * Common parameters that should be grouped for all ConnectedClusterResourceUriParameter usage.
 */
alias ConnectedClusterResourceUriParameters = {
  ...ApiVersionParameter;
  ...ConnectedClusterResourceUriParameter;
};

/**
 * URI parameter for the custom location resource.
 */
model CustomLocationResourceUriParameter {
  @path(#{ allowReserved: true })
  @doc("The fully qualified Azure Resource Manager identifier of the custom location resource.")
  customLocationResourceUri: string;
}

/**
 * Common parameters that should be grouped for all CustomLocationResourceUriParameter usage.
 */
alias CustomLocationResourceUriParameters = {
  ...ApiVersionParameter;
  ...CustomLocationResourceUriParameter;
};
