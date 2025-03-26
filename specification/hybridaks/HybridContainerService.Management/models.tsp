import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

enum NetworkPolicy {
  Calico: "calico",
}

enum OsType {
  Windows,
  Linux,
}

enum Ossku {
  @doc("Use Mariner as the OS for node images.") CBLMariner,
  @doc("Use Windows2019 as the OS for node images.") Windows2019,
  @doc("Use Windows2022 as the OS for node images.") Windows2022,
}

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

enum AddonPhase {
  Pending: "pending",
  Provisioning: "provisioning",
  ProvisioningHelmChartInstalled: "provisioning {HelmChartInstalled}",
  ProvisioningMSICertificateDownloaded: "provisioning {MSICertificateDownloaded}",
  Provisioned: "provisioned",
  Deleting: "deleting",
  Failed: "failed",
  Upgrading: "upgrading",
}

enum AzureHybridBenefit {
  True,
  False,
  NotApplicable,
}

enum Expander {
  @doc("Selects the node group that will have the least idle CPU (if tied, unused memory) after scale-up. This is useful when you have different classes of nodes, for example, high CPU or high memory nodes, and only want to expand those when there are pending pods that need a lot of those resources.")
  LeastWaste: "least-waste",
  @doc("Selects the node group that would be able to schedule the most pods when scaling up. This is useful when you are using nodeSelector to make sure certain pods land on certain nodes. Note that this won't cause the autoscaler to select bigger nodes vs. smaller, as it can add multiple smaller nodes at once.")
  MostPods: "most-pods",
  @doc("Selects the node group that has the highest priority assigned by the user. It's configuration is described in more details [here](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md).")
  Priority: "priority",
  @doc("Used when you don't have a particular need for the node groups to scale differently.")
  Random: "random",
}

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

@doc("Properties of the provisioned cluster.")
model ProvisionedClusterProperties {
  @doc("The profile for Linux VMs in the provisioned cluster.")
  linuxProfile?: LinuxProfileProperties;

  @doc("The profile for control plane of the provisioned cluster.")
  controlPlane?: ControlPlaneProfile;

  @doc("The version of Kubernetes in use by the provisioned cluster.")
  kubernetesVersion?: string;

  @doc("The network configuration profile for the provisioned cluster.")
  networkProfile?: NetworkProfile;

  @doc("The storage configuration profile for the provisioned cluster.")
  storageProfile?: StorageProfile;

  @doc("The SSH restricted access profile for the VMs in the provisioned cluster.")
  clusterVMAccessProfile?: ClusterVMAccessProfile;

  @doc("The agent pool properties for the provisioned cluster.")
  agentPoolProfiles?: NamedAgentPoolProfile[];

  @doc("The profile for the underlying cloud infrastructure provider for the provisioned cluster.")
  cloudProviderProfile?: CloudProviderProfile;

  @doc("The status of the latest long running operation for the provisioned cluster.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The observed status of the provisioned cluster.")
  @visibility("read")
  status?: ProvisionedClusterPropertiesStatus;

  @doc("The license profile of the provisioned cluster.")
  licenseProfile?: ProvisionedClusterLicenseProfile;

  @doc("Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.")
  autoScalerProfile?: ProvisionedClusterPropertiesAutoScalerProfile;
}

@doc("SSH profile for control plane and nodepool VMs of the provisioned cluster.")
model LinuxProfileProperties {
  @doc("SSH configuration for VMs of the provisioned cluster.")
  ssh?: LinuxProfilePropertiesSsh;
}

@doc("SSH configuration for VMs of the provisioned cluster.")
model LinuxProfilePropertiesSsh {
  @doc("The list of SSH public keys used to authenticate with VMs. A maximum of 1 key may be specified.")
  publicKeys?: LinuxProfilePropertiesSshPublicKeysItem[];
}

model LinuxProfilePropertiesSshPublicKeysItem {
  @doc("Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.")
  keyData?: string;
}

@doc("The properties of the control plane nodes of the provisioned cluster")
model ControlPlaneProfile {
  @doc("Number of control plane nodes. The default value is 1, and the count should be an odd number")
  count?: int32;

  @doc("VM sku size of the control plane nodes")
  vmSize?: string;

  @doc("IP Address of the Kubernetes API server")
  controlPlaneEndpoint?: ControlPlaneProfileControlPlaneEndpoint;
}

@doc("IP Address of the Kubernetes API server")
model ControlPlaneProfileControlPlaneEndpoint {
  @doc("IP address of the Kubernetes API server")
  hostIP?: string;
}

@doc("The network configuration profile for the provisioned cluster.")
model NetworkProfile {
  @doc("Profile of the HA Proxy load balancer.")
  loadBalancerProfile?: NetworkProfileLoadBalancerProfile;

  @doc("Network policy used for building Kubernetes network. Possible values include: 'calico'.")
  networkPolicy?: NetworkPolicy;

  @doc("A CIDR notation IP Address range from which to assign pod IPs.")
  podCidr?: string;
}

@doc("Profile of the HA Proxy load balancer.")
model NetworkProfileLoadBalancerProfile {
  @doc("Number of HA Proxy load balancer VMs. The default value is 0.")
  count?: int32;
}

@doc("The storage configuration profile for the provisioned cluster.")
model StorageProfile {
  @doc("SMB CSI Driver settings for the storage profile.")
  smbCsiDriver?: StorageProfileSmbCSIDriver;

  @doc("NFS CSI Driver settings for the storage profile.")
  nfsCsiDriver?: StorageProfileNfsCSIDriver;
}

@doc("SMB CSI Driver settings for the storage profile.")
model StorageProfileSmbCSIDriver {
  @doc("Indicates whether to enable SMB CSI Driver. The default value is true.")
  enabled?: boolean;
}

@doc("NFS CSI Driver settings for the storage profile.")
model StorageProfileNfsCSIDriver {
  @doc("Indicates whether to enable NFS CSI Driver. The default value is true.")
  enabled?: boolean;
}

@doc("The SSH restricted access profile for the VMs in the provisioned cluster.")
model ClusterVMAccessProfile {
  @doc("IP Address or CIDR for SSH access to VMs in the provisioned cluster")
  authorizedIPRanges?: string;
}

@doc("Profile of the default agent pool along with a name parameter")
model NamedAgentPoolProfile {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolName;
}

@doc("Profile for agent pool properties specified during creation")
model AgentPoolProfile {
  @doc("The particular KubernetesVersion Image OS Type (Linux, Windows)")
  osType?: OsType;

  @doc("Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.")
  osSKU?: Ossku;

  @doc("The node labels to be persisted across all nodes in agent pool.")
  nodeLabels?: Record<string>;

  @doc("Taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.")
  nodeTaints?: string[];

  @doc("The maximum number of nodes for auto-scaling")
  maxCount?: int32;

  @doc("The minimum number of nodes for auto-scaling")
  minCount?: int32;

  @doc("Whether to enable auto-scaler. Default value is false")
  enableAutoScaling?: boolean;

  @doc("The maximum number of pods that can run on a node.")
  maxPods?: int32;
}

@doc("Profile for agent pool properties that can be updated")
model AgentPoolUpdateProfile {
  @doc("Number of nodes in the agent pool. The default value is 1.")
  count?: int32;

  @doc("The VM sku size of the agent pool node VMs.")
  vmSize?: string;

  @doc("Version of Kubernetes in use by the agent pool. This is inherited from the kubernetesVersion of the provisioned cluster.")
  @visibility("read")
  kubernetesVersion?: string;
}

@doc("Name of the default Agent Pool")
model AgentPoolName {
  @doc("Unique name of the default agent pool in the context of the provisioned cluster. Default value is <clusterName>-nodepool1")
  name?: string;
}

@doc("The profile for the underlying cloud infrastructure provider for the provisioned cluster.")
model CloudProviderProfile {
  @doc("The profile for the infrastructure networks used by the provisioned cluster")
  infraNetworkProfile?: CloudProviderProfileInfraNetworkProfile;
}

@doc("The profile for the infrastructure networks used by the provisioned cluster")
model CloudProviderProfileInfraNetworkProfile {
  @doc("List of ARM resource Ids (maximum 1) for the infrastructure network object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/logicalNetworks/{logicalNetworkName}")
  vnetSubnetIds?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/logicalNetworks";
    },
    {
      type: "Microsoft.HybridContainerService/virtualNetworks";
    }
  ]>[];
}

@doc("The observed status of the provisioned cluster.")
model ProvisionedClusterPropertiesStatus {
  @doc("The detailed status of the provisioned cluster components including addons.")
  controlPlaneStatus?: AddonStatusProfile[];

  @doc("The current state of the provisioned cluster.")
  @visibility("read")
  currentState?: ResourceProvisioningState;

  @doc("Error messages during a provisioned cluster operation or steady state.")
  errorMessage?: string;
}

@doc("The status profile of the addons and other kubernetes components")
model AddonStatusProfile {
  @doc("Name of the addon or component")
  name?: string;

  @doc("Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'")
  phase?: AddonPhase;

  @doc("Indicates whether the addon or component is ready")
  ready?: boolean;

  @doc("Observed error message from the addon or component")
  errorMessage?: string;
}

@doc("The license profile of the provisioned cluster.")
model ProvisionedClusterLicenseProfile {
  @doc("Indicates whether Azure Hybrid Benefit is opted in. Default value is false")
  azureHybridBenefit?: AzureHybridBenefit;
}

@doc("Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.")
model ProvisionedClusterPropertiesAutoScalerProfile {
  @doc("Valid values are 'true' and 'false'")
  @projectedName("json", "balance-similar-node-groups")
  balanceSimilarNodeGroups?: string;

  @doc("If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.")
  expander?: Expander;

  @doc("The default is 10.")
  @projectedName("json", "max-empty-bulk-delete")
  maxEmptyBulkDelete?: string;

  @doc("The default is 600.")
  @projectedName("json", "max-graceful-termination-sec")
  maxGracefulTerminationSec?: string;

  @doc("The default is '15m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "max-node-provision-time")
  maxNodeProvisionTime?: string;

  @doc("The default is 45. The maximum is 100 and the minimum is 0.")
  @projectedName("json", "max-total-unready-percentage")
  maxTotalUnreadyPercentage?: string;

  @doc("For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. The default is '0s'. Values must be an integer followed by a unit ('s' for seconds, 'm' for minutes, 'h' for hours, etc).")
  @projectedName("json", "new-pod-scale-up-delay")
  newPodScaleUpDelay?: string;

  @doc("This must be an integer. The default is 3.")
  @projectedName("json", "ok-total-unready-count")
  okTotalUnreadyCount?: string;

  @doc("The default is '10'. Values must be an integer number of seconds.")
  @projectedName("json", "scan-interval")
  scanInterval?: string;

  @doc("The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "scale-down-delay-after-add")
  scaleDownDelayAfterAdd?: string;

  @doc("The default is the scan-interval. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "scale-down-delay-after-delete")
  scaleDownDelayAfterDelete?: string;

  @doc("The default is '3m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "scale-down-delay-after-failure")
  scaleDownDelayAfterFailure?: string;

  @doc("The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "scale-down-unneeded-time")
  scaleDownUnneededTime?: string;

  @doc("The default is '20m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.")
  @projectedName("json", "scale-down-unready-time")
  scaleDownUnreadyTime?: string;

  @doc("The default is '0.5'.")
  @projectedName("json", "scale-down-utilization-threshold")
  scaleDownUtilizationThreshold?: string;

  @doc("The default is true.")
  @projectedName("json", "skip-nodes-with-local-storage")
  skipNodesWithLocalStorage?: string;

  @doc("The default is true.")
  @projectedName("json", "skip-nodes-with-system-pods")
  skipNodesWithSystemPods?: string;
}

@doc("Extended location pointing to the underlying infrastructure")
model ExtendedLocation {
  @doc("The extended location type. Allowed value: 'CustomLocation'")
  type?: ExtendedLocationTypes;

  @doc("ARM Id of the extended location.")
  name?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Control plane and agent pool upgrade profiles.")
model ProvisionedClusterUpgradeProfileProperties {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The list of available kubernetes version upgrades for the control plane.")
  controlPlaneProfile: ProvisionedClusterPoolUpgradeProfile;
}

@doc("The list of available kubernetes versions for upgrade.")
model ProvisionedClusterPoolUpgradeProfile {
  @doc("The Kubernetes version (major.minor.patch).")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The particular KubernetesVersion Image OS Type (Linux, Windows)")
  @visibility("read")
  osType?: OsType;

  @doc("List of available kubernetes versions for upgrade.")
  upgrades?: ProvisionedClusterPoolUpgradeProfileProperties[];
}

@doc("The upgrade properties.")
model ProvisionedClusterPoolUpgradeProfileProperties {
  @doc("The Kubernetes version (major.minor.patch).")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("Whether the Kubernetes version is currently in preview.")
  @visibility("read")
  isPreview?: boolean;
}

@doc("Defines the resource properties for the hybrid identity metadata.")
model HybridIdentityMetadataProperties {
  @doc("Unique id of the parent provisioned cluster resource.")
  resourceUid?: string;

  @doc("Onboarding public key for provisioning the Managed identity for the connected cluster.")
  publicKey?: string;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Properties of the agent pool resource")
model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolProvisioningStatus;
}

@doc("The agentPool resource provisioning status definition")
model AgentPoolProvisioningStatus {
  @doc("The status of the latest long running operation for the agent pool.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The observed status of the agent pool.")
  status?: AgentPoolProvisioningStatusStatus;
}

@doc("The observed status of the agent pool.")
model AgentPoolProvisioningStatusStatus {
  @doc("The current state of the agent pool.")
  @visibility("read")
  currentState?: ResourceProvisioningState;

  @doc("Error messages during an agent pool operation or steady state.")
  errorMessage?: string;

  readyReplicas?: AgentPoolUpdateProfile[];
}

@doc("The list kubeconfig result response.")
model ListCredentialResponse {
  @doc("Operation Id")
  @visibility("read")
  id?: string;

  @doc("Operation Name")
  @visibility("read")
  name?: string;

  @doc("ARM Resource Id of the provisioned cluster instance")
  @visibility("read")
  resourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.HybridContainerService/provisionedClusterInstances";
    }
  ]>;

  @doc("Provisioning state of the resource")
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
  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  kubeconfigs?: CredentialResult[];
}

@doc("The credential result response.")
model CredentialResult {
  @doc("The name of the credential.")
  @visibility("read")
  name?: string;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  value?: bytes;
}

model KubernetesVersionProfileProperties {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("List of supported Kubernetes versions")
  values?: KubernetesVersionProperties[];
}

@doc("Kubernetes version profile for given major.minor release")
model KubernetesVersionProperties {
  @doc("major.minor version of Kubernetes release")
  @visibility("read")
  version?: string;

  @doc("Whether this version is in preview mode.")
  @visibility("read")
  isPreview?: boolean;

  @doc("Patch versions of a Kubernetes release")
  @visibility("read")
  patchVersions?: Record<KubernetesPatchVersions>;
}

@doc("Kubernetes Patch Version profile")
model KubernetesPatchVersions {
  @doc("Indicates whether the kubernetes version image is ready or not")
  readiness?: KubernetesVersionReadiness[];

  @doc("Possible upgrade paths for given patch version")
  upgrades?: string[];
}

@doc("Indicates whether the kubernetes version image is ready or not")
model KubernetesVersionReadiness {
  @doc("The particular KubernetesVersion Image OS Type (Linux, Windows)")
  @visibility("read")
  osType?: OsType;

  @doc("Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.")
  osSku?: Ossku;

  @doc("Whether the kubernetes version image is ready or not")
  @visibility("read")
  ready?: boolean;

  @doc("The error message for version not being ready")
  @visibility("read")
  errorMessage?: string;
}

model VmSkuProfileProperties {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("List of supported VM SKUs.")
  values?: VmSkuProperties[];
}

@doc("The profile for supported VM SKUs")
model VmSkuProperties {
  @doc("The type of resource the SKU applies to.")
  @visibility("read")
  resourceType?: string;

  @doc("The list of name-value pairs to describe VM SKU capabilities like MemoryGB, vCPUs, etc.")
  @visibility("read")
  capabilities?: VmSkuCapabilities[];

  @doc("The name of the VM SKU")
  @visibility("read")
  name?: string;

  @doc("The tier of the VM SKU")
  @visibility("read")
  tier?: string;

  @doc("The size of the VM SKU")
  @visibility("read")
  size?: string;
}

@doc("Describes the VM SKU capabilities like MemoryGB, vCPUs, etc.")
model VmSkuCapabilities {
  @doc("Name of the VM SKU capability")
  @visibility("read")
  name?: string;

  @doc("Value of the VM SKU capability")
  @visibility("read")
  value?: string;
}

@doc("Properties of the virtual network resource")
model VirtualNetworkProperties {
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  @doc("Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer")
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  @doc("Range of IP Addresses for Kubernetes node VMs")
  vmipPool?: VirtualNetworkPropertiesVmipPoolItem[];

  @doc("List of DNS server IP Addresses associated with the network")
  dnsServers?: string[];

  @doc("IP Address of the Gateway associated with the network")
  gateway?: string;

  @doc("IP Address Prefix of the network")
  ipAddressPrefix?: string;

  @doc("VLAN Id used by the network")
  vlanID?: int32;

  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status of the virtual network resource")
  @visibility("read")
  status?: VirtualNetworkPropertiesStatus;
}

model VirtualNetworkPropertiesInfraVnetProfile {
  @doc("Infrastructure network profile for HCI platform")
  hci?: VirtualNetworkPropertiesInfraVnetProfileHci;
}

@doc("Infrastructure network profile for HCI platform")
model VirtualNetworkPropertiesInfraVnetProfileHci {
  @doc("Group in MOC(Microsoft On-premises Cloud)")
  mocGroup?: string;

  @doc("Location in MOC(Microsoft On-premises Cloud)")
  mocLocation?: string;

  @doc("Virtual Network name in MOC(Microsoft On-premises Cloud)")
  mocVnetName?: string;
}

model VirtualNetworkPropertiesVipPoolItem {
  @doc("Ending IP address for the IP Pool")
  endIP?: string;

  @doc("Starting IP address for the IP Pool")
  startIP?: string;
}

model VirtualNetworkPropertiesVmipPoolItem {
  @doc("Ending IP address for the IP Pool")
  endIP?: string;

  @doc("Starting IP address for the IP Pool")
  startIP?: string;
}

@doc("Status of the virtual network resource")
model VirtualNetworkPropertiesStatus {
  @doc("The detailed status of the long running operation.")
  operationStatus?: VirtualNetworkPropertiesStatusOperationStatus;
}

@doc("The detailed status of the long running operation.")
model VirtualNetworkPropertiesStatusOperationStatus {
  @doc("The error if any from the operation.")
  error?: VirtualNetworkPropertiesStatusOperationStatusError;

  @doc("The identifier of the operation.")
  operationId?: string;

  @doc("The status of the operation.")
  status?: string;
}

@doc("The error if any from the operation.")
model VirtualNetworkPropertiesStatusOperationStatusError {
  @doc("The error code from the operation.")
  code?: string;

  @doc("The error message from the operation.")
  message?: string;
}

@doc("Extended location pointing to the underlying infrastructure")
model VirtualNetworkExtendedLocation {
  @doc("The extended location type. Allowed value: 'CustomLocation'")
  type?: ExtendedLocationTypes;

  @doc("ARM Id of the extended location.")
  name?: string;
}

@doc("The Virtual Network resource patch definition.")
model VirtualNetworksPatch {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("The profile for Linux VMs in the provisioned cluster.")
model LinuxProfile {
  @doc("Profile for Linux VMs in the container service cluster.")
  linuxProfile?: LinuxProfileProperties;
}
