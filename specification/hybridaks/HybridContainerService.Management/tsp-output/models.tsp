import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The particular KubernetesVersion's Image's OS Type (Linux, Windows)")
enum OsType {
  Windows,
  Linux,
}

@doc("Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.")
enum Ossku {
  @doc("Use Mariner as the OS for node images.") CBLMariner,
  @doc("Use Windows2019 as the OS for node images.") Windows2019,
  @doc("Use Windows2022 as the OS for node images.") Windows2022,
}

@doc("NetworkPolicy - Network policy used for building Kubernetes network. Possible values include: 'calico', 'flannel'. Default is 'calico'")
enum NetworkPolicy {
  calico,
  flannel,
}

@doc("Provisioning state of the resource")
enum ResourceProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
  Upgrading,
  InProgress,
  Accepted,
  Created,
}

@doc("Observed phase of the addon on the target cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'")
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

@doc("Indicates whether Azure Hybrid Benefit is opted in")
enum AzureHybridBenefit {
  True,
  False,
  NotApplicable,
}

@doc("The extended location type.")
enum ExtendedLocationTypes {
  CustomLocation,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  InProgress,
  Deleting,
  Updating,
  Accepted,
  Created,
}

@doc("All properties of the provisioned cluster")
model ProvisionedClusterProperties {
  @doc("LinuxProfile - The profile for Linux VMs in the Provisioned Cluster.")
  linuxProfile?: LinuxProfileProperties;

  @doc("ControlPlane - ControlPlane Configuration")
  controlPlane?: ControlPlaneProfile;

  @doc("KubernetesVersion - Version of Kubernetes specified when creating the managed cluster.")
  kubernetesVersion?: string;

  @doc("NetworkProfile - Profile of network configuration.")
  networkProfile?: NetworkProfile;

  @doc("The agent pools of the cluster.")
  agentPoolProfiles?: NamedAgentPoolProfile[];

  @doc("The underlying cloud infra provider properties.")
  cloudProviderProfile?: CloudProviderProfile;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("HybridAKSClusterStatus defines the observed state of HybridAKSCluster")
  @visibility("read")
  status?: ProvisionedClusterPropertiesStatus;

  @doc("The license profile of the provisioned cluster.")
  licenseProfile?: ProvisionedClusterLicenseProfile;
}

@doc("LinuxProfile - Profile for Linux VMs in the container service cluster.")
model LinuxProfileProperties {
  @doc("SSH - SSH configuration for Linux-based VMs running on Azure.")
  ssh?: LinuxProfilePropertiesSsh;
}

@doc("SSH - SSH configuration for Linux-based VMs running on Azure.")
model LinuxProfilePropertiesSsh {
  @doc("PublicKeys - The list of SSH public keys used to authenticate with Linux-based VMs. Only expect one key specified.")
  publicKeys?: LinuxProfilePropertiesSshPublicKeysItem[];
}

model LinuxProfilePropertiesSshPublicKeysItem {
  @doc("KeyData - Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.")
  keyData?: string;
}

@doc("ControlPlaneProfile - The control plane properties for the provisioned cluster.")
model ControlPlaneProfile {
  ...NamedAgentPoolProfile;
  ...ControlPlaneEndpointProfile;
  ...LinuxProfile;
}

@doc("Agent pool profile along with a name parameter")
model NamedAgentPoolProfile {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolName;
}

@doc("AgentPool configuration")
model AgentPoolProfile {
  @doc("AvailabilityZones - The list of Availability zones to use for nodes. Datacenter racks modelled as zones")
  availabilityZones?: string[];

  @doc("The particular KubernetesVersion's Image's OS Type (Linux, Windows)")
  osType?: OsType;

  @doc("Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.")
  osSKU?: Ossku;

  @doc("The version of node image")
  nodeImageVersion?: string;
}

@doc("AgentPool update configuration")
model AgentPoolUpdateProfile {
  @doc("Count - Number of agents to host docker containers. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.")
  count?: int32;

  @doc("VmSize - The size of the agent pool VMs.")
  vmSize?: string;
}

@doc("AgentPool Name")
model AgentPoolName {
  @doc("Unique name of the agent pool profile in the context of the subscription and resource group.")
  name?: string;
}

@doc("controlPlaneEndpoint - API server endpoint for the control plane")
model ControlPlaneEndpointProfile {
  @doc("API server endpoint for the control plane")
  controlPlaneEndpoint?: ControlPlaneEndpointProfileControlPlaneEndpoint;
}

@doc("API server endpoint for the control plane")
model ControlPlaneEndpointProfileControlPlaneEndpoint {
  @doc("Host IP address for API server")
  hostIP?: string;

  @doc("Port for the API server")
  port?: int32;
}

@doc("LinuxProfile - Profile for Linux VMs in the container service cluster.")
model LinuxProfile {
  @doc("Profile for Linux VMs in the container service cluster.")
  linuxProfile?: LinuxProfileProperties;
}

@doc("NetworkProfile - Profile of network configuration.")
model NetworkProfile {
  @doc("LoadBalancerProfile - Profile of the cluster load balancer.")
  loadBalancerProfile?: NetworkProfileLoadBalancerProfile;

  @doc("NetworkPolicy - Network policy used for building Kubernetes network. Possible values include: 'calico', 'flannel'. Default is 'calico'")
  networkPolicy?: NetworkPolicy;

  @doc("PodCidr - A CIDR notation IP range from which to assign pod IPs when kubenet is used.")
  podCidr?: string;
}

@doc("LoadBalancerProfile - Profile of the cluster load balancer.")
model NetworkProfileLoadBalancerProfile {
  @doc("Count - Number of load balancer VMs. The default value is 0.")
  count?: int32;
}

@doc("CloudProviderProfile - The underlying cloud infra provider properties.")
model CloudProviderProfile {
  @doc("InfraNetworkProfile - List of infra network profiles for the provisioned cluster")
  infraNetworkProfile?: CloudProviderProfileInfraNetworkProfile;
}

@doc("InfraNetworkProfile - List of infra network profiles for the provisioned cluster")
model CloudProviderProfileInfraNetworkProfile {
  @doc("Array of references to azure resource corresponding to the Network object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/logicalNetworks/{logicalNetworkName}")
  vnetSubnetIds?: ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/logicalNetworks";
    },
    {
      type: "Microsoft.ConnectedVMwarevSphere/virtualNetworks";
    },
    {
      type: "Microsoft.HybridContainerService/virtualNetworks";
    }
  ]>[];
}

@doc("HybridAKSClusterStatus defines the observed state of HybridAKSCluster")
model ProvisionedClusterPropertiesStatus {
  @doc("Status of the control plane components")
  controlPlaneStatus?: AddonStatusProfile[];

  @doc("ErrorMessage - Error messages during creation of cluster")
  errorMessage?: string;

  @doc("Contains Provisioning errors")
  operationStatus?: ProvisionedClusterPropertiesStatusOperationStatus;
}

@doc("Defines the addon status profile.")
model AddonStatusProfile {
  @doc("Name of the addon")
  name?: string;

  @doc("Observed phase of the addon on the target cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'")
  phase?: AddonPhase;

  @doc("Indicates whether the addon is ready")
  ready?: boolean;

  @doc("Error message while deploying the addon")
  errorMessage?: string;
}

@doc("Contains Provisioning errors")
model ProvisionedClusterPropertiesStatusOperationStatus {
  error?: ProvisionedClusterPropertiesStatusOperationStatusError;
  operationId?: string;
  status?: string;
}

model ProvisionedClusterPropertiesStatusOperationStatusError {
  code?: string;
  message?: string;
}

@doc("The license profile of the provisioned cluster.")
model ProvisionedClusterLicenseProfile {
  @doc("Indicates whether Azure Hybrid Benefit is opted in")
  azureHybridBenefit?: AzureHybridBenefit;
}

@doc("Extended Location definition")
model ExtendedLocation {
  @doc("The extended location type.")
  type?: ExtendedLocationTypes;

  @doc("The extended location name.")
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

  @doc("The list of available upgrade versions for the control plane.")
  controlPlaneProfile: ProvisionedClusterPoolUpgradeProfile;

  @doc("The list of available upgrade versions for agent pools.")
  agentPoolProfiles: ProvisionedClusterPoolUpgradeProfile[];
}

@doc("The list of available upgrade versions.")
model ProvisionedClusterPoolUpgradeProfile {
  @doc("The Kubernetes version (major.minor.patch).")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The Agent Pool name.")
  @visibility("read")
  name?: string;

  @doc("The particular KubernetesVersion's Image's OS Type (Linux, Windows)")
  @visibility("read")
  osType?: OsType;

  @doc("List of orchestrator types and versions available for upgrade.")
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

@doc("Defines the resource properties.")
model HybridIdentityMetadataProperties {
  @doc("Unique id of the parent provisioned cluster resource.")
  resourceUid?: string;

  @doc("Onboarding public key for provisioning the Managed identity for the HybridAKS cluster.")
  publicKey?: string;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...HybridaksAgentPoolProvisioningStatus;
}

@doc("The agentPool resource provisioning status definition")
model HybridaksAgentPoolProvisioningStatus {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Defines the observed state of the agent pool")
  status?: AgentPoolProvisioningStatusStatus;
}

@doc("Defines the observed state of the agent pool")
model AgentPoolProvisioningStatusStatus {
  @doc("ErrorMessage - Error messages during creation of agent pool")
  errorMessage?: string;

  @doc("Contains Provisioning errors")
  operationStatus?: AgentPoolProvisioningStatusStatusOperationStatus;

  readyReplicas?: AgentPoolUpdateProfile[];
}

@doc("Contains Provisioning errors")
model AgentPoolProvisioningStatusStatusOperationStatus {
  error?: AgentPoolProvisioningStatusStatusOperationStatusError;
  operationId?: string;
  status?: string;
}

model AgentPoolProvisioningStatusStatusOperationStatusError {
  code?: string;
  message?: string;
}

@doc("The agentPool resource patch definition")
model AgentPoolPatch {
  @doc("Resource tags")
  tags?: Record<string>;
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

  @doc("Capabilities on this kubernetes version")
  @visibility("read")
  capabilities?: KubernetesVersionCapabilities;

  @doc("Whether this version is in preview mode.")
  @visibility("read")
  isPreview?: boolean;

  @doc("Patch versions of a Kubernetes release")
  @visibility("read")
  patchVersions?: Record<KubernetesPatchVersions>;
}

@doc("Capabilities on this kubernetes version")
model KubernetesVersionCapabilities {
  supportPlan?: "KubernetesOfficial"[];
}

@doc("Kubernetes Patch Version profile")
model KubernetesPatchVersions {
  @doc("Whether the kubernetes version variant (Linux, Windows, Windows2022) is ready or not")
  readiness?: KubernetesVersionReadiness[];

  @doc("Possible upgrade path for given patch version")
  upgrades?: string[];
}

@doc("Whether a particular kubernetes version's variant (CBLMariner, Windows, Windows2022) is ready or not ")
model KubernetesVersionReadiness {
  @doc("The particular KubernetesVersion's Image's OS Type (Linux, Windows)")
  @visibility("read")
  osType?: OsType;

  @doc("Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.")
  osSku?: Ossku;

  @doc("Whether or not the given image is ready")
  @visibility("read")
  ready?: boolean;

  @doc("If image is not ready, the error message for version not being ready")
  @visibility("read")
  errorMessage?: string;
}

model VmSkuProfileProperties {
  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Array of HybridAKS Support VM Skus")
  values?: VmSkuProperties[];
}

@doc("The profile for supported VM skus")
model VmSkuProperties {
  @doc("The resource type of the vm")
  @visibility("read")
  resourceType?: string;

  @doc("A name value pair to describe the specific vm's capability")
  @visibility("read")
  capabilities?: VmSkuCapabilities[];

  @doc("The name of the VM Family")
  @visibility("read")
  name?: string;

  @doc("The tier of the VM Family")
  @visibility("read")
  tier?: string;

  @doc("The size of the VM Family")
  @visibility("read")
  size?: string;
}

@doc("describes the vm sku capabilities object")
model VmSkuCapabilities {
  @doc("An invariant to describe the feature")
  @visibility("read")
  name?: string;

  @doc("An invariant if the feature is measured by quantity")
  @visibility("read")
  value?: string;
}

@doc("HybridAKSNetworkSpec defines the desired state of HybridAKSNetwork")
model VirtualNetworkProperties {
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  @doc("Virtual IP Pool for Kubernetes")
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  @doc("IP Pool for Virtual Machines")
  vmipPool?: VirtualNetworkPropertiesVmipPoolItem[];

  @doc("Address of the DHCP servers associated with the network")
  dhcpServers?: string[];

  @doc("Address of the DNS servers associated with the network")
  dnsServers?: string[];

  @doc("Address of the Gateway associated with the network")
  gateway?: string;

  @doc("IP Address Prefix of the network")
  ipAddressPrefix?: string;

  @doc("VLAN Id used by the network")
  vlanID?: int32;

  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("HybridAKSNetworkStatus defines the observed state of HybridAKSNetwork")
  @visibility("read")
  status?: VirtualNetworkPropertiesStatus;
}

model VirtualNetworkPropertiesInfraVnetProfile {
  @doc("Infra network profile for HCI platform")
  hci?: VirtualNetworkPropertiesInfraVnetProfileHci;

  @doc("Infra network profile for VMware platform")
  vmware?: VirtualNetworkPropertiesInfraVnetProfileVmware;
}

@doc("Infra network profile for HCI platform")
model VirtualNetworkPropertiesInfraVnetProfileHci {
  @doc("Resource group in MOC(Microsoft On-premises Cloud)")
  mocGroup?: string;

  @doc("Location in MOC(Microsoft On-premises Cloud)")
  mocLocation?: string;

  @doc("Virtual Network name in MOC(Microsoft On-premises Cloud)")
  mocVnetName?: string;
}

@doc("Infra network profile for VMware platform")
model VirtualNetworkPropertiesInfraVnetProfileVmware {
  @doc("Name of the network segment in VSphere")
  segmentName?: string;
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

@doc("HybridAKSNetworkStatus defines the observed state of HybridAKSNetwork")
model VirtualNetworkPropertiesStatus {
  @doc("Contains Provisioning errors")
  operationStatus?: VirtualNetworkPropertiesStatusOperationStatus;
}

@doc("Contains Provisioning errors")
model VirtualNetworkPropertiesStatusOperationStatus {
  error?: VirtualNetworkPropertiesStatusOperationStatusError;
  operationId?: string;

  @doc("Phase represents the current phase of the virtual network provisioning. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  status?: string;
}

model VirtualNetworkPropertiesStatusOperationStatusError {
  code?: string;
  message?: string;
}

@doc("The virtualNetworks resource patch definition.")
model VirtualNetworksPatch {
  @doc("Resource tags")
  tags?: Record<string>;
}
