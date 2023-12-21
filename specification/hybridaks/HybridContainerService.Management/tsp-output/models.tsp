import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.HybridContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

enum LicenseType {
  Windows_Server,
  None,
}

enum AutoUpgradeOptions {
  Enabled,
  Disabled,
}

enum Mode {
  System,
  LB,
  User,
}

enum OsType {
  Linux,
  Windows,
}

enum LoadBalancerSku {
  `unstacked-haproxy`,
  `stacked-kube-vip`,
  `stacked-metallb`,
  unmanaged,
}

enum NetworkPolicy {
  calico,
  flannel,
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

enum DeploymentState {
  pending,
  provisioning,
  provisioned,
  deleting,
  failed,
  upgrading,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AgentPoolProvisioningState {
  Succeeded,
  Failed,
  Deleting,
  InProgress,
  Canceled,
}
@Azure.Core.fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
}

@doc("Identity for the Provisioned cluster.")
model ProvisionedClusterIdentity {
  @doc("The principal id of provisioned cluster identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id associated with the provisioned cluster. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of identity used for the provisioned cluster. The type SystemAssigned, includes a system created identity. The type None means no identity is assigned to the provisioned cluster.")
  type: ResourceIdentityType;
}

model ProvisionedClustersResponseProperties {
  ...ProvisionedClustersPropertiesWithoutSecrets;
  ...ProvisionedClustersCommonProperties;
}

@doc("Properties of provisioned clusters without the corresponding secrets")
model ProvisionedClustersPropertiesWithoutSecrets {
  @doc("AAD profile for the provisioned cluster.")
  aadProfile?: AADProfileResponse;

  @doc("WindowsProfile - Profile for Windows VMs in the Provisioned Cluster.")
  windowsProfile?: WindowsProfileResponse;

  @doc("HttpProxyConfig - Configurations for provisioning the cluster with HTTP proxy servers.")
  httpProxyConfig?: HttpProxyConfigResponse;
}

@doc("AAD Profile specifies attributes for Azure Active Directory integration.")
model AADProfileResponse {
  @doc("The list of AAD group object IDs that will have admin role of the cluster.")
  adminGroupObjectIDs?: string[];

  @doc("The client AAD application ID.")
  clientAppID?: string;

  @doc("Whether to enable Azure RBAC for Kubernetes authorization.")
  enableAzureRbac?: boolean;

  @doc("Whether to enable managed AAD.")
  managed?: boolean;

  @doc("The server AAD application ID.")
  serverAppID?: string;

  @doc("The AAD tenant ID to use for authentication. If not specified, will use the tenant of the deployment subscription.")
  tenantID?: string;
}

@doc("Profile for Windows VMs in the container service cluster.")
model WindowsProfileResponse {
  @doc("AdminUsername - Specifies the name of the administrator account. <br><br> **restriction:** Cannot end in \".\" <br><br> **Disallowed values:** \"administrator\", \"admin\", \"user\", \"user1\", \"test\", \"user2\", \"test1\", \"user3\", \"admin1\", \"1\", \"123\", \"a\", \"actuser\", \"adm\", \"admin2\", \"aspnet\", \"backup\", \"console\", \"david\", \"guest\", \"john\", \"owner\", \"root\", \"server\", \"sql\", \"support\", \"support_388945a0\", \"sys\", \"test2\", \"test3\", \"user4\", \"user5\". <br><br> **Minimum-length:** 1 character <br><br> **Max-length:** 20 characters")
  adminUsername?: string;

  @doc("EnableCSIProxy - Whether to enable CSI proxy.")
  enableCsiProxy?: boolean;

  @doc("LicenseType - The licenseType to use for Windows VMs. Windows_Server is used to enable Azure Hybrid User Benefits for Windows VMs. Possible values include: 'None', 'Windows_Server'")
  licenseType?: LicenseType;
}

@doc("Configurations for provisioning the cluster with HTTP proxy servers.")
model HttpProxyConfigResponse {
  @doc("The HTTP proxy server endpoint to use.")
  httpProxy?: string;

  @doc("The HTTPS proxy server endpoint to use.")
  httpsProxy?: string;

  @doc("The endpoints that should not go through proxy.")
  noProxy?: string[];

  @doc("Alternative CA cert to use for connecting to proxy servers.")
  trustedCa?: string;

  @doc("Username to use for connecting to proxy server")
  username?: string;
}

@doc("HybridAKSClusterSpec defines the desired state of HybridAKSCluster")
model ProvisionedClustersCommonProperties {
  @doc("EnableRBAC - Whether to enable Kubernetes Role-Based Access Control.")
  enableRbac?: boolean;

  @doc("LinuxProfile - The profile for Linux VMs in the Provisioned Cluster.")
  linuxProfile?: LinuxProfileProperties;

  @doc("Additional features specs like Arc Agent Onboarding.")
  features?: ProvisionedClustersCommonPropertiesFeatures;

  @doc("AddonProfiles - Profile of managed cluster add-on.")
  addonProfiles?: Record<AddonProfiles>;

  @doc("ControlPlane - ControlPlane Configuration")
  controlPlane?: ControlPlaneProfile;

  @doc("KubernetesVersion - Version of Kubernetes specified when creating the managed cluster.")
  kubernetesVersion?: string;

  @doc("NetworkProfile - Profile of network configuration.")
  networkProfile?: NetworkProfile;

  @doc("NodeResourceGroup - Name of the resource group containing agent pool nodes.")
  nodeResourceGroup?: string;

  @doc("The agent pools of the cluster.")
  agentPoolProfiles?: NamedAgentPoolProfile[];

  @doc("The underlying cloud infra provider properties.")
  cloudProviderProfile?: CloudProviderProfile;

  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("HybridAKSClusterStatus defines the observed state of HybridAKSCluster")
  @visibility("read")
  status?: ProvisionedClustersCommonPropertiesStatus;
}

@doc("LinuxProfile - Profile for Linux VMs in the container service cluster.")
model LinuxProfileProperties {
  @doc("AdminUsername - The administrator username to use for Linux VMs.")
  adminUsername?: string;

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

@doc("Additional features specs like Arc Agent Onboarding.")
model ProvisionedClustersCommonPropertiesFeatures {
  @doc("Arc agentry configuration for the provisioned cluster.")
  arcAgentProfile?: ArcAgentProfile;
}

@doc("Defines the Arc Agent properties for the Provisioned clusters.")
model ArcAgentProfile {
  @doc("Version of the Arc agents to be installed on the provisioned Provisioned cluster resource")
  agentVersion?: string;

  @doc("Indicates whether the Arc agents on the provisioned clusters be upgraded automatically to the latest version. Defaults to Enabled.")
  agentAutoUpgrade?: AutoUpgradeOptions;
}

@doc("Addon configurations")
model AddonProfiles {
  @doc("Config - Key-value pairs for configuring an add-on.")
  config?: Record<string>;

  @doc("Enabled - Whether the add-on is enabled or not.")
  enabled?: boolean;
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
  ...AgentPoolName;
}

@doc("NodePool configuration")
model AgentPoolProfile {
  @doc("Count - Number of agents to host docker containers. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.")
  count?: int32;

  @doc("AvailabilityZones - The list of Availability zones to use for nodes. Datacenter racks modelled as zones")
  availabilityZones?: string[];

  @doc("The maximum number of nodes for auto-scaling")
  maxCount?: int32;

  @doc("The maximum number of pods that can run on a node.")
  maxPods?: int32;

  @doc("The minimum number of nodes for auto-scaling")
  minCount?: int32;

  @doc("Mode - AgentPoolMode represents mode of an agent pool. Possible values include: 'System', 'LB', 'User'. Default is 'User'")
  mode?: Mode;

  @doc("NodeLabels - Agent pool node labels to be persisted across all nodes in agent pool.")
  nodeLabels?: Record<string>;

  @doc("NodeTaints - Taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.")
  nodeTaints?: string[];

  @doc("OsType - OsType to be used to specify os type. Choose from Linux and Windows. Default to Linux. Possible values include: 'Linux', 'Windows'")
  osType?: OsType;

  @doc("The version of node image")
  nodeImageVersion?: string;

  @doc("VmSize - The size of the agent pool VMs.")
  vmSize?: string;

  @doc("The underlying cloud infra provider properties.")
  cloudProviderProfile?: CloudProviderProfile;
}

@doc("CloudProviderProfile - The underlying cloud infra provider properties.")
model CloudProviderProfile {
  @doc("InfraNetworkProfile - List of infra network profiles for the provisioned cluster")
  infraNetworkProfile?: CloudProviderProfileInfraNetworkProfile;

  @doc("InfraStorageProfile - List of infra storage profiles for the provisioned cluster")
  infraStorageProfile?: CloudProviderProfileInfraStorageProfile;
}

@doc("InfraNetworkProfile - List of infra network profiles for the provisioned cluster")
model CloudProviderProfileInfraNetworkProfile {
  @doc("Array of references to azure resource corresponding to the new HybridAKSNetwork object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/virtualNetworks/{virtualNetworkName}")
  vnetSubnetIds?: string[];
}

@doc("InfraStorageProfile - List of infra storage profiles for the provisioned cluster")
model CloudProviderProfileInfraStorageProfile {
  @doc("Reference to azure resource corresponding to the new HybridAKSStorage object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridContainerService/storageSpaces/{storageSpaceName}")
  storageSpaceIds?: string[];
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
  port?: string;
}

@doc("LinuxProfile - Profile for Linux VMs in the container service cluster.")
model LinuxProfile {
  @doc("Profile for Linux VMs in the container service cluster.")
  linuxProfile?: LinuxProfileProperties;
}

@doc("NetworkProfile - Profile of network configuration.")
model NetworkProfile {
  @doc("LoadBalancerProfile - Profile of the cluster load balancer.")
  loadBalancerProfile?: LoadBalancerProfile;

  @doc("LoadBalancerSku - The load balancer sku for the provisioned cluster. Possible values: 'unstacked-haproxy', 'stacked-kube-vip', 'stacked-metallb', 'unmanaged'. The default is 'unmanaged'.")
  loadBalancerSku?: LoadBalancerSku;

  @doc("DNSServiceIP - An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.")
  dnsServiceIP?: string;

  @doc("NetworkPolicy - Network policy used for building Kubernetes network. Possible values include: 'calico', 'flannel'. Default is 'calico'")
  networkPolicy?: NetworkPolicy;

  @doc("PodCidr - A CIDR notation IP range from which to assign pod IPs when kubenet is used.")
  podCidr?: string;

  @doc("The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.")
  podCidrs?: string[];

  @doc("ServiceCidr - A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.")
  serviceCidr?: string;

  @doc("The CIDR notation IP ranges from which to assign service cluster IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking. They must not overlap with any Subnet IP ranges.")
  serviceCidrs?: string[];
}

@doc("LoadBalancerProfile - Profile of the cluster load balancer.")
model LoadBalancerProfile {
  ...NamedAgentPoolProfile;
  ...LinuxProfile;
}

@doc("HybridAKSClusterStatus defines the observed state of HybridAKSCluster")
model ProvisionedClustersCommonPropertiesStatus {
  @doc("Additional features status like Arc Agent Onboarding.")
  featuresStatus?: ProvisionedClustersCommonPropertiesStatusFeaturesStatus;

  @doc("AddonStatus - Status of Addons")
  addonStatus?: Record<AddonStatus>;

  @doc("ErrorMessage - Error messages during creation of cluster")
  errorMessage?: string;

  @doc("Contains Provisioning errors")
  provisioningStatus?: ProvisionedClustersCommonPropertiesStatusProvisioningStatus;
}

@doc("Additional features status like Arc Agent Onboarding.")
model ProvisionedClustersCommonPropertiesStatusFeaturesStatus {
  @doc("Defines the observed Arc Agent status that is resourceSynced back to the ARM resource.")
  arcAgentStatus?: ArcAgentStatus;
}

@doc("Defines the observed Arc Agent status that is resourceSynced back to the ARM resource.")
model ArcAgentStatus {
  @doc("Observed deployment state of the Arc Agents on the target cluster. Possible values include: 'pending', 'provisioning', 'provisioned', 'deleting', 'failed', 'upgrading'")
  deploymentState?: DeploymentState;

  @doc("Error messages while onboarding/upgrading/uninstalling the Arc agents")
  errorMessage?: string;

  @doc("Onboarding public key for provisioning the Managed identity for the HybridAKS cluster. Will be used to create the hybridIdentityMetadata proxy resource and will not be persisted.")
  onboardingPublicKey?: string;

  @doc("Version of the Arc agents currently running on the Provisioned cluster resource.")
  agentVersion?: string;

  @doc("Number of CPU cores present in the Provisioned cluster resource")
  coreCount?: int32;

  @doc("ManagedIdentity certificate expiration time (ValidUntil).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedIdentityCertificateExpirationTime?: utcDateTime;

  @doc("Last connected timestamp of the Provisioned cluster resource.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectivityTime?: utcDateTime;
}

@doc("Status of the addon")
model AddonStatus {
  @doc("ErrorMessage will be set in the event that there is a terminal problem reconciling the AddOn and will contain a more verbose string suitable for logging and human consumption.")
  errorMessage?: string;

  @doc("Phase represents the current phase of cluster actuation. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  ready?: boolean;
}

@doc("Contains Provisioning errors")
model ProvisionedClustersCommonPropertiesStatusProvisioningStatus {
  error?: ProvisionedClustersCommonPropertiesStatusProvisioningStatusError;
  operationId?: string;

  @doc("Phase represents the current phase of cluster actuation. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  status?: string;
}

model ProvisionedClustersCommonPropertiesStatusProvisioningStatusError {
  code?: string;
  message?: string;
}

model ProvisionedClustersResponseExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("The provisionedClusters resource definition.")
model ProvisionedClusters extends TrackedResource {
  @doc("Identity for the Provisioned cluster.")
  identity?: ProvisionedClusterIdentity;

  @doc("All properties of the provisioned cluster")
  properties?: ProvisionedClustersAllProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;

  extendedLocation?: ProvisionedClustersExtendedLocation;
}

@doc("All properties of the provisioned cluster")
model ProvisionedClustersAllProperties {
  ...ProvisionedClustersPropertiesWithSecrets;
  ...ProvisionedClustersCommonProperties;
}

@doc("Properties of provisioned clusters that contain secrets")
model ProvisionedClustersPropertiesWithSecrets {
  @doc("AAD profile for the provisioned cluster.")
  aadProfile?: AADProfile;

  @doc("WindowsProfile - Profile for Windows VMs in the Provisioned Cluster.")
  windowsProfile?: WindowsProfile;

  @doc("HttpProxyConfig - Configurations for provisioning the cluster with HTTP proxy servers.")
  httpProxyConfig?: HttpProxyConfig;
}

@doc("AAD Profile specifies attributes for Azure Active Directory integration.")
model AADProfile {
  ...AADProfileSecret;
  ...AADProfileResponse;
}

@doc("The server AAD application secret.")
model AADProfileSecret {
  @doc("The server AAD application secret.")
  serverAppSecret?: string;
}

@doc("WindowsProfile - Profile for Windows VMs in the container service cluster.")
model WindowsProfile {
  ...WindowsProfileResponse;
  ...WindowsProfilePassword;
}

@doc("Password for the Windows Profile to be used by the Windows VMs in the cluster")
model WindowsProfilePassword {
  @doc("AdminPassword - Specifies the password of the administrator account. <br><br> **Minimum-length:** 8 characters <br><br> **Max-length:** 123 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\"")
  adminPassword?: string;
}

@doc("Configurations for provisioning the cluster with HTTP proxy servers.")
model HttpProxyConfig {
  ...HttpProxyConfigResponse;
  ...HttpProxyConfigPassword;
}

model HttpProxyConfigPassword {
  @doc("Password to use for connecting to proxy server")
  password?: string;
}

model ProvisionedClustersExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("Control plane and agent pool upgrade profiles.")
model ProvisionedClusterUpgradeProfileProperties {
  @visibility("read")
  provisioningState?: string;

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

  @doc("OsType - OsType to be used to specify os type. Choose from Linux and Windows. Default to Linux. Possible values include: 'Linux', 'Windows'")
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

  @doc("The identity of the provisioned cluster.")
  identity?: ProvisionedClusterIdentity;

  @doc("provisioning state of the hybridIdentityMetadata resource.")
  @visibility("read")
  provisioningState?: string;
}

model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolProvisioningStatus;
}

@doc("The agentPool resource provisioning status definition")
model AgentPoolProvisioningStatus {
  @visibility("read")
  provisioningState?: AgentPoolProvisioningState;

  @doc("HybridAKSNodePoolStatus defines the observed state of HybridAKSNodePool")
  status?: AgentPoolProvisioningStatusStatus;
}

@doc("HybridAKSNodePoolStatus defines the observed state of HybridAKSNodePool")
model AgentPoolProvisioningStatusStatus {
  @doc("ErrorMessage - Error messages during creation of cluster")
  errorMessage?: string;

  @doc("Contains Provisioning errors")
  provisioningStatus?: AgentPoolProvisioningStatusStatusProvisioningStatus;

  @doc("Total number of ready machines targeted by this deployment.")
  readyReplicas?: int32;

  @doc("Total number of non-terminated machines targeted by this deployment")
  replicas?: int32;
}

@doc("Contains Provisioning errors")
model AgentPoolProvisioningStatusStatusProvisioningStatus {
  error?: AgentPoolProvisioningStatusStatusProvisioningStatusError;
  operationId?: string;

  @doc("Phase represents the current phase of cluster actuation. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  status?: string;
}

model AgentPoolProvisioningStatusStatusProvisioningStatusError {
  code?: string;
  message?: string;
}

model AgentPoolExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("The list of versions for supported orchestrators.")
model OrchestratorVersionProfileListResult {
  @doc("Profile of the orchestrator versions")
  orchestrators?: OrchestratorVersionProfile[];

  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource Name")
  @visibility("read")
  name?: string;

  @doc("Resource Type")
  @visibility("read")
  type?: string;
}

@doc("The profile of an orchestrator and its available versions.")
model OrchestratorVersionProfile {
  @doc("Whether Kubernetes version is currently in preview.")
  @visibility("read")
  isPreview?: boolean;

  @doc("Installed by default if version is not specified.")
  @visibility("read")
  default?: boolean;

  @doc("Orchestrator type.")
  @visibility("read")
  orchestratorType?: string;

  @doc("Orchestrator version major.minor.patch, for example 1.21.9")
  @visibility("read")
  orchestratorVersion?: string;

  @doc("The list of available upgrade versions.")
  upgrades?: OrchestratorProfile[];
}

@doc("Contains information about orchestrator.")
model OrchestratorProfile {
  @doc("Whether Kubernetes version is currently in preview.")
  @visibility("read")
  isPreview?: boolean;

  @doc("Orchestrator type.")
  @visibility("read")
  orchestratorType?: string;

  @doc("Orchestrator version (major, minor, patch).")
  @visibility("read")
  orchestratorVersion?: string;
}

@doc("The list of supported VM SKUs.")
model VMSkuListResult {
  @doc("Supported VM SKUs.")
  @visibility("read")
  vmSKUs?: string[];

  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource Name")
  @visibility("read")
  name?: string;

  @doc("Resource Type")
  @visibility("read")
  type?: string;
}

@doc("Results of the request to list operations.")
model ResourceProviderOperationList
  is Azure.Core.Page<ResourceProviderOperation>;

@doc("Results of the request to list operations.")
model ResourceProviderOperation {
  @doc("Indicates whether the operation applies to data-plane.")
  isDataAction?: string;

  @doc("Operation name, in format of {provider}/{resource}/{operation}")
  name?: string;

  @doc("Display metadata associated with the operation.")
  display?: ResourceProviderOperationDisplay;
}

@doc("Display metadata associated with the operation.")
model ResourceProviderOperationDisplay {
  @doc("The resource provider.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;

  @doc("Type of operation: get, read, delete, etc.")
  operation?: string;

  @doc("Description of this operation.")
  description?: string;
}

@doc("HybridAKSStorageSpec defines the desired state of HybridAKSStorage")
model StorageSpacesProperties {
  hciStorageProfile?: StorageSpacesPropertiesHciStorageProfile;
  vmwareStorageProfile?: StorageSpacesPropertiesVmwareStorageProfile;

  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("HybridAKSStorageStatus defines the observed state of HybridAKSStorage")
  status?: StorageSpacesPropertiesStatus;
}

model StorageSpacesPropertiesHciStorageProfile {
  @doc("Resource group in MOC(Microsoft On-premises Cloud)")
  mocGroup?: string;

  @doc("Location in MOC(Microsoft On-premises Cloud)")
  mocLocation?: string;

  @doc("Name of the storage container in MOC(Microsoft On-premises Cloud)")
  mocStorageContainer?: string;
}

model StorageSpacesPropertiesVmwareStorageProfile {
  @doc("Name of the datacenter in VSphere")
  datacenter?: string;

  @doc("Name of the datastore in VSphere")
  datastore?: string;

  @doc("Name of the folder in VSphere")
  folder?: string;

  @doc("Name of the resource pool in VSphere")
  resourcePool?: string;
}

@doc("HybridAKSStorageStatus defines the observed state of HybridAKSStorage")
model StorageSpacesPropertiesStatus {
  @doc("Contains Provisioning errors")
  provisioningStatus?: StorageSpacesPropertiesStatusProvisioningStatus;
}

@doc("Contains Provisioning errors")
model StorageSpacesPropertiesStatusProvisioningStatus {
  error?: StorageSpacesPropertiesStatusProvisioningStatusError;
  operationId?: string;

  @doc("Phase represents the current phase of cluster actuation. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  status?: string;
}

model StorageSpacesPropertiesStatusProvisioningStatusError {
  code?: string;
  message?: string;
}

model StorageSpacesExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}

@doc("HybridAKSNetworkSpec defines the desired state of HybridAKSNetwork")
model VirtualNetworksProperties {
  infraVnetProfile?: VirtualNetworksPropertiesInfraVnetProfile;

  @doc("Virtual IP Pool for Kubernetes")
  vipPool?: VirtualNetworksPropertiesVipPoolItem[];

  @doc("IP Pool for Virtual Machines")
  vmipPool?: VirtualNetworksPropertiesVmipPoolItem[];

  @doc("Address of the DHCP servers associated with the network")
  @visibility("read")
  dhcpServers?: string[];

  @doc("Address of the DNS servers associated with the network")
  dnsServers?: string[];

  @doc("Address of the Gateway associated with the network")
  gateway?: string;

  @doc("IP Address Prefix of the network")
  ipAddressPrefix?: string;

  @doc("VLAN Id used by the network")
  @visibility("read")
  vlanID?: string;

  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("HybridAKSNetworkStatus defines the observed state of HybridAKSNetwork")
  @visibility("read")
  status?: VirtualNetworksPropertiesStatus;
}

model VirtualNetworksPropertiesInfraVnetProfile {
  @doc("Infra network profile for HCI platform")
  hci?: VirtualNetworksPropertiesInfraVnetProfileHci;

  @doc("Infra network profile for the NetworkCloud platform")
  networkCloud?: VirtualNetworksPropertiesInfraVnetProfileNetworkCloud;

  @doc("Infra network profile for VMware platform")
  vmware?: VirtualNetworksPropertiesInfraVnetProfileVmware;
}

@doc("Infra network profile for HCI platform")
model VirtualNetworksPropertiesInfraVnetProfileHci {
  @doc("Resource group in MOC(Microsoft On-premises Cloud)")
  mocGroup?: string;

  @doc("Location in MOC(Microsoft On-premises Cloud)")
  mocLocation?: string;

  @doc("Virtual Network name in MOC(Microsoft On-premises Cloud)")
  mocVnetName?: string;
}

@doc("Infra network profile for the NetworkCloud platform")
model VirtualNetworksPropertiesInfraVnetProfileNetworkCloud {
  @doc("The ARM ID of Network Cloud Network Resource to Associate with this VirtualNetwork")
  networkId?: string;
}

@doc("Infra network profile for VMware platform")
model VirtualNetworksPropertiesInfraVnetProfileVmware {
  @doc("Name of the network segment in VSphere")
  segmentName?: string;
}

model VirtualNetworksPropertiesVipPoolItem {
  @doc("Ending IP address for the IP Pool")
  endIP?: string;

  @doc("Starting IP address for the IP Pool")
  startIP?: string;
}

model VirtualNetworksPropertiesVmipPoolItem {
  @doc("Ending IP address for the IP Pool")
  endIP?: string;

  @doc("Starting IP address for the IP Pool")
  startIP?: string;
}

@doc("HybridAKSNetworkStatus defines the observed state of HybridAKSNetwork")
model VirtualNetworksPropertiesStatus {
  @doc("Contains Provisioning errors")
  provisioningStatus?: VirtualNetworksPropertiesStatusProvisioningStatus;
}

@doc("Contains Provisioning errors")
model VirtualNetworksPropertiesStatusProvisioningStatus {
  error?: VirtualNetworksPropertiesStatusProvisioningStatusError;
  operationId?: string;

  @doc("Phase represents the current phase of cluster actuation. E.g. Pending, Running, Terminating, Failed etc.")
  phase?: string;

  status?: string;
}

model VirtualNetworksPropertiesStatusProvisioningStatusError {
  code?: string;
  message?: string;
}

model VirtualNetworksExtendedLocation {
  @doc("The extended location type.")
  type?: string;

  @doc("The extended location name.")
  name?: string;
}
