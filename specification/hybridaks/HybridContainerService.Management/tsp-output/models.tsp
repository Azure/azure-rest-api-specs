import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Network policy used for building Kubernetes network. Possible values include: 'calico'.
 */
enum NetworkPolicy {
  calico,
}

/**
 * The particular KubernetesVersion Image OS Type (Linux, Windows)
 */
enum OsType {
  Windows,
  Linux,
}

/**
 * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
 */
enum Ossku {
  /**
   * Use Mariner as the OS for node images.
   */
  CBLMariner,

  /**
   * Use Windows2019 as the OS for node images.
   */
  Windows2019,

  /**
   * Use Windows2022 as the OS for node images.
   */
  Windows2022,
}

/**
 * Provisioning state of the resource
 */
enum ResourceProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Pending,
  Creating,
  Deleting,
  Updating,
  Upgrading,
  Accepted,
}

/**
 * Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'
 */
enum AddonPhase {
  pending,
  provisioning,
  `provisioning {HelmChartInstalled}`,
  `provisioning {MSICertificateDownloaded}`,
  provisioned,
  deleting,
  failed,
  upgrading,
}

/**
 * Indicates whether Azure Hybrid Benefit is opted in. Default value is false
 */
enum AzureHybridBenefit {
  True,
  False,
  NotApplicable,
}

/**
 * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
 */
enum Expander {
  /**
   * Selects the node group that will have the least idle CPU (if tied, unused memory) after scale-up. This is useful when you have different classes of nodes, for example, high CPU or high memory nodes, and only want to expand those when there are pending pods that need a lot of those resources.
   */
  `least-waste`,

  /**
   * Selects the node group that would be able to schedule the most pods when scaling up. This is useful when you are using nodeSelector to make sure certain pods land on certain nodes. Note that this won't cause the autoscaler to select bigger nodes vs. smaller, as it can add multiple smaller nodes at once.
   */
  `most-pods`,

  /**
   * Selects the node group that has the highest priority assigned by the user. It's configuration is described in more details [here](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md).
   */
  priority,

  /**
   * Used when you don't have a particular need for the node groups to scale differently.
   */
  random,
}

/**
 * The extended location type. Allowed value: 'CustomLocation'
 */
enum ExtendedLocationTypes {
  CustomLocation,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Pending,
  Creating,
  Deleting,
  Updating,
  Accepted,
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
  clusterVMAccessProfile?: ClusterVMAccessProfile;

  /**
   * The agent pool properties for the provisioned cluster.
   */
  agentPoolProfiles?: NamedAgentPoolProfile[];

  /**
   * The profile for the underlying cloud infrastructure provider for the provisioned cluster.
   */
  cloudProviderProfile?: CloudProviderProfile;

  /**
   * The status of the latest long running operation for the provisioned cluster.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * The observed status of the provisioned cluster.
   */
  @visibility("read")
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
  publicKeys?: LinuxProfilePropertiesSshPublicKeysItem[];
}

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
model StorageProfileSmbCSIDriver {
  /**
   * Indicates whether to enable SMB CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * NFS CSI Driver settings for the storage profile.
 */
model StorageProfileNfsCSIDriver {
  /**
   * Indicates whether to enable NFS CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * The SSH restricted access profile for the VMs in the provisioned cluster.
 */
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
  osSKU?: Ossku;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
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
  @visibility("read")
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
  vnetSubnetIds?: ResourceIdentifier<[
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
  controlPlaneStatus?: AddonStatusProfile[];

  /**
   * The current state of the provisioned cluster.
   */
  @visibility("read")
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
  @projectedName("json", "balance-similar-node-groups")
  balanceSimilarNodeGroups?: string;

  /**
   * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
   */
  expander?: Expander;

  /**
   * The default is 10.
   */
  @projectedName("json", "max-empty-bulk-delete")
  maxEmptyBulkDelete?: string;

  /**
   * The default is 600.
   */
  @projectedName("json", "max-graceful-termination-sec")
  maxGracefulTerminationSec?: string;

  /**
   * The default is '15m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "max-node-provision-time")
  maxNodeProvisionTime?: string;

  /**
   * The default is 45. The maximum is 100 and the minimum is 0.
   */
  @projectedName("json", "max-total-unready-percentage")
  maxTotalUnreadyPercentage?: string;

  /**
   * For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. The default is '0s'. Values must be an integer followed by a unit ('s' for seconds, 'm' for minutes, 'h' for hours, etc).
   */
  @projectedName("json", "new-pod-scale-up-delay")
  newPodScaleUpDelay?: string;

  /**
   * This must be an integer. The default is 3.
   */
  @projectedName("json", "ok-total-unready-count")
  okTotalUnreadyCount?: string;

  /**
   * The default is '10'. Values must be an integer number of seconds.
   */
  @projectedName("json", "scan-interval")
  scanInterval?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "scale-down-delay-after-add")
  scaleDownDelayAfterAdd?: string;

  /**
   * The default is the scan-interval. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "scale-down-delay-after-delete")
  scaleDownDelayAfterDelete?: string;

  /**
   * The default is '3m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "scale-down-delay-after-failure")
  scaleDownDelayAfterFailure?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "scale-down-unneeded-time")
  scaleDownUnneededTime?: string;

  /**
   * The default is '20m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @projectedName("json", "scale-down-unready-time")
  scaleDownUnreadyTime?: string;

  /**
   * The default is '0.5'.
   */
  @projectedName("json", "scale-down-utilization-threshold")
  scaleDownUtilizationThreshold?: string;

  /**
   * The default is true.
   */
  @projectedName("json", "skip-nodes-with-local-storage")
  skipNodesWithLocalStorage?: string;

  /**
   * The default is true.
   */
  @projectedName("json", "skip-nodes-with-system-pods")
  skipNodesWithSystemPods?: string;
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Control plane and agent pool upgrade profiles.
 */
model ProvisionedClusterUpgradeProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
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
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility("read")
  osType?: OsType;

  /**
   * List of available kubernetes versions for upgrade.
   */
  upgrades?: ProvisionedClusterPoolUpgradeProfileProperties[];
}

/**
 * The upgrade properties.
 */
model ProvisionedClusterPoolUpgradeProfileProperties {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  @visibility("read")
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
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

/**
 * Properties of the agent pool resource
 */
model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...HybridaksAgentPoolProvisioningStatus;
}

/**
 * The agentPool resource provisioning status definition
 */
model HybridaksAgentPoolProvisioningStatus {
  /**
   * The status of the latest long running operation for the agent pool.
   */
  @visibility("read")
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
  @visibility("read")
  currentState?: ResourceProvisioningState;

  /**
   * Error messages during an agent pool operation or steady state.
   */
  errorMessage?: string;

  readyReplicas?: AgentPoolUpdateProfile[];
}

/**
 * The list kubeconfig result response.
 */
model ListCredentialResponse {
  /**
   * Operation Id
   */
  @visibility("read")
  id?: string;

  /**
   * Operation Name
   */
  @visibility("read")
  name?: string;

  /**
   * ARM Resource Id of the provisioned cluster instance
   */
  @visibility("read")
  resourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.HybridContainerService/provisionedClusterInstances";
    }
  ]>;

  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  status?: ResourceProvisioningState;

  error?: ListCredentialResponseError;
  properties?: ListCredentialResponseProperties;
}

model ListCredentialResponseError {
  code?: string;
  message?: string;
}

model ListCredentialResponseProperties {
  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  kubeconfigs?: CredentialResult[];
}

/**
 * The credential result response.
 */
model CredentialResult {
  /**
   * The name of the credential.
   */
  @visibility("read")
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  value?: bytes;
}

model KubernetesVersionProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported Kubernetes versions
   */
  values?: KubernetesVersionProperties[];
}

/**
 * Kubernetes version profile for given major.minor release
 */
model KubernetesVersionProperties {
  /**
   * major.minor version of Kubernetes release
   */
  @visibility("read")
  version?: string;

  /**
   * Whether this version is in preview mode.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * Patch versions of a Kubernetes release
   */
  @visibility("read")
  patchVersions?: Record<KubernetesPatchVersions>;
}

/**
 * Kubernetes Patch Version profile
 */
model KubernetesPatchVersions {
  /**
   * Indicates whether the kubernetes version image is ready or not
   */
  readiness?: KubernetesVersionReadiness[];

  /**
   * Possible upgrade paths for given patch version
   */
  upgrades?: string[];
}

/**
 * Indicates whether the kubernetes version image is ready or not
 */
model KubernetesVersionReadiness {
  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility("read")
  osType?: OsType;

  /**
   * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
   */
  osSku?: Ossku;

  /**
   * Whether the kubernetes version image is ready or not
   */
  @visibility("read")
  ready?: boolean;

  /**
   * The error message for version not being ready
   */
  @visibility("read")
  errorMessage?: string;
}

model VmSkuProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported VM SKUs.
   */
  values?: VmSkuProperties[];
}

/**
 * The profile for supported VM SKUs
 */
model VmSkuProperties {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The list of name-value pairs to describe VM SKU capabilities like MemoryGB, vCPUs, etc.
   */
  @visibility("read")
  capabilities?: VmSkuCapabilities[];

  /**
   * The name of the VM SKU
   */
  @visibility("read")
  name?: string;

  /**
   * The tier of the VM SKU
   */
  @visibility("read")
  tier?: string;

  /**
   * The size of the VM SKU
   */
  @visibility("read")
  size?: string;
}

/**
 * Describes the VM SKU capabilities like MemoryGB, vCPUs, etc.
 */
model VmSkuCapabilities {
  /**
   * Name of the VM SKU capability
   */
  @visibility("read")
  name?: string;

  /**
   * Value of the VM SKU capability
   */
  @visibility("read")
  value?: string;
}

/**
 * Properties of the virtual network resource
 */
model VirtualNetworkProperties {
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  /**
   * Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer
   */
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  /**
   * Range of IP Addresses for Kubernetes node VMs
   */
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
  vlanID?: int32;

  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Status of the virtual network resource
   */
  @visibility("read")
  status?: VirtualNetworkPropertiesStatus;
}

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

model VirtualNetworkPropertiesVipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
  startIP?: string;
}

model VirtualNetworkPropertiesVmipPoolItem {
  /**
   * Ending IP address for the IP Pool
   */
  endIP?: string;

  /**
   * Starting IP address for the IP Pool
   */
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
 * The Virtual Network resource patch definition.
 */
model VirtualNetworksPatch {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * The profile for Linux VMs in the provisioned cluster.
 */
model LinuxProfile {
  /**
   * Profile for Linux VMs in the container service cluster.
   */
  linuxProfile?: LinuxProfileProperties;
}
