import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The name of a managed cluster SKU.")
enum ManagedClusterSKUName {
  Basic,
}

@doc("If not specified, the default is 'Free'. See [uptime SLA](https://docs.microsoft.com/azure/aks/uptime-sla) for more details.")
enum ManagedClusterSKUTier {
  @doc("Guarantees 99.95% availability of the Kubernetes API server endpoint for clusters that use Availability Zones and 99.9% of availability for clusters that don't use Availability Zones.")
  Paid,
  @doc("No guaranteed SLA, no additional charges. Free tier clusters have an SLO of 99.5%.")
  Free,
}

@doc("The type of extendedLocation.")
enum ExtendedLocationTypes {
  EdgeZone,
}

@doc("Tells whether the cluster is Running or Stopped")
enum Code {
  @doc("The cluster is running.") Running,
  @doc("The cluster is stopped.") Stopped,
}

@doc("The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).")
enum OSDiskType {
  @doc("Azure replicates the operating system disk for a virtual machine to Azure storage to avoid data loss should the VM need to be relocated to another host. Since containers aren't designed to have local state persisted, this behavior offers limited value while providing some drawbacks, including slower node provisioning and higher read/write latency.")
  Managed,
  @doc("Ephemeral OS disks are stored only on the host machine, just like a temporary disk. This provides lower read/write latency, along with faster node scaling and cluster upgrades.")
  Ephemeral,
}

@doc("Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.")
enum KubeletDiskType {
  @doc("Kubelet will use the OS disk for its data.") OS,
  @doc("Kubelet will use the temporary disk for its data.") Temporary,
}

@doc("Determines the type of workload a node can run.")
enum WorkloadRuntime {
  @doc("Nodes will use Kubelet to run standard OCI container workloads.")
  OCIContainer,
  @doc("Nodes will use Krustlet to run WASM workloads using the WASI provider (Preview).")
  WasmWasi,
  @doc("Nodes can use (Kata + Cloud Hypervisor + Hyper-V) to enable Nested VM-based pods (Preview). Due to the use Hyper-V, AKS node OS itself is a nested VM (the root OS) of Hyper-V. Thus it can only be used with VM series that support Nested Virtualization such as Dv3 series.")
  KataMshvVmIsolation,
}

@doc("The operating system type. The default is Linux.")
enum OSType {
  @doc("Use Linux.") Linux,
  @doc("Use Windows.") Windows,
}

@doc("Specifies the OS SKU used by the agent pool. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated.")
enum OSSku {
  Ubuntu,
  CBLMariner,
  Mariner,
  Windows2019,
  Windows2022,
}

@doc("Describes how VMs are added to or removed from Agent Pools. See [billing states](https://docs.microsoft.com/azure/virtual-machines/states-billing).")
enum ScaleDownMode {
  @doc("Create new instances during scale up and remove instances during scale down.")
  Delete,
  @doc("Attempt to start deallocated instances (if they exist) during scale up and deallocate instances during scale down.")
  Deallocate,
}

@doc("The type of Agent Pool.")
enum AgentPoolType {
  @doc("Create an Agent Pool backed by a Virtual Machine Scale Set.")
  VirtualMachineScaleSets,
  @doc("Use of this is strongly discouraged.") AvailabilitySet,
}

@doc("A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools")
enum AgentPoolMode {
  @doc("System agent pools are primarily for hosting critical system pods such as CoreDNS and metrics-server. System agent pools osType must be Linux. System agent pools VM SKU must have at least 2vCPUs and 4GB of memory.")
  System,
  @doc("User agent pools are primarily for hosting your application pods.")
  User,
}

@doc("The Virtual Machine Scale Set priority.")
enum ScaleSetPriority {
  @doc("Spot priority VMs will be used. There is no SLA for spot nodes. See [spot on AKS](https://docs.microsoft.com/azure/aks/spot-node-pool) for more information.")
  Spot,
  @doc("Regular VMs will be used.") Regular,
}

@doc("The eviction policy specifies what to do with the VM when it is evicted. The default is Delete. For more information about eviction see [spot VMs](https://docs.microsoft.com/azure/virtual-machines/spot-vms)")
enum ScaleSetEvictionPolicy {
  @doc("Nodes in the underlying Scale Set of the node pool are deleted when they're evicted.")
  Delete,
  @doc("Nodes in the underlying Scale Set of the node pool are set to the stopped-deallocated state upon eviction. Nodes in the stopped-deallocated state count against your compute quota and can cause issues with cluster scaling or upgrading.")
  Deallocate,
}

@doc("GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.")
enum GPUInstanceProfile {
  MIG1g,
  MIG2g,
  MIG3g,
  MIG4g,
  MIG7g,
}

@doc("The network protocol of the port.")
enum Protocol {
  @doc("TCP protocol.") TCP,
  @doc("UDP protocol.") UDP,
}

@doc("The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.")
enum LicenseType {
  @doc("No additional licensing is applied.") None,
  @doc("Enables Azure Hybrid User Benefits for Windows VMs.") Windows_Server,
}

@doc("The current provisioning state of the pod identity.")
enum ManagedClusterPodIdentityProvisioningState {
  Assigned,
  Canceled,
  Deleting,
  Failed,
  Succeeded,
  Updating,
}

@doc("The restriction level applied to the cluster's node resource group")
enum RestrictionLevel {
  @doc("All RBAC permissions are allowed on the managed node resource group")
  Unrestricted,
  @doc("Only */read RBAC permissions allowed on the managed node resource group")
  ReadOnly,
}

@doc("Network plugin used for building the Kubernetes network.")
enum NetworkPlugin {
  @doc("Use the Azure CNI network plugin. See [Azure CNI (advanced) networking](https://docs.microsoft.com/azure/aks/concepts-network#azure-cni-advanced-networking) for more information.")
  azure,
  @doc("Use the Kubenet network plugin. See [Kubenet (basic) networking](https://docs.microsoft.com/azure/aks/concepts-network#kubenet-basic-networking) for more information.")
  kubenet,
  @doc("Do not use a network plugin. A custom CNI will need to be installed after cluster creation for networking functionality.")
  none,
}

@doc("The mode the network plugin should use.")
enum NetworkPluginMode {
  @doc("Pods are given IPs from the PodCIDR address space but use Azure Routing Domains rather than Kubenet reference plugins host-local and bridge.")
  Overlay,
}

@doc("Network policy used for building the Kubernetes network.")
enum NetworkPolicy {
  @doc("Use Calico network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.")
  calico,
  @doc("Use Azure network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.")
  azure,
}

@doc("This cannot be specified if networkPlugin is anything other than 'azure'.")
enum NetworkMode {
  @doc("No bridge is created. Intra-VM Pod to Pod communication is through IP routes created by Azure CNI. See [Transparent Mode](https://docs.microsoft.com/azure/aks/faq#transparent-mode) for more information.")
  transparent,
  @doc("This is no longer supported") bridge,
}

@doc("The eBPF dataplane used for building the Kubernetes network.")
enum EbpfDataplane {
  @doc("Use Cilium for networking in the Kubernetes cluster.") cilium,
}

@doc("This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).")
enum OutboundType {
  @doc("The load balancer is used for egress through an AKS assigned public IP. This supports Kubernetes services of type 'loadBalancer'. For more information see [outbound type loadbalancer](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer).")
  loadBalancer,
  @doc("Egress paths must be defined by the user. This is an advanced scenario and requires proper network configuration. For more information see [outbound type userDefinedRouting](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting).")
  userDefinedRouting,
  @doc("The AKS-managed NAT gateway is used for egress.") managedNATGateway,
  @doc("The user-assigned NAT gateway associated to the cluster subnet is used for egress. This is an advanced scenario and requires proper network configuration.")
  userAssignedNATGateway,
}

@doc("The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.")
enum LoadBalancerSku {
  @doc("Use a a standard Load Balancer. This is the recommended Load Balancer SKU. For more information about on working with the load balancer in the managed cluster, see the [standard Load Balancer](https://docs.microsoft.com/azure/aks/load-balancer-standard) article.")
  standard,
  @doc("Use a basic Load Balancer with limited functionality.") basic,
}

@doc("The type of the managed inbound Load Balancer BackendPool.")
enum BackendPoolType {
  @doc("The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.")
  NodeIPConfiguration,
  @doc("The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.")
  NodeIP,
}

@doc("The IP version to use for cluster networking and IP assignment.")
enum IpFamily {
  IPv4,
  IPv6,
}

@doc("Specify which proxy mode to use ('IPTABLES' or 'IPVS')")
enum Mode {
  @doc("IPTables proxy mode") IPTABLES,
  @doc("IPVS proxy mode. Must be using Kubernetes version >= 1.22.") IPVS,
}

@doc("IPVS scheduler, for more information please see http://www.linuxvirtualserver.org/docs/scheduling.html.")
enum IpvsScheduler {
  @doc("Round Robin") RoundRobin,
  @doc("Least Connection") LeastConnection,
}

@doc("For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).")
enum UpgradeChannel {
  @doc("Automatically upgrade the cluster to the latest supported patch release on the latest supported minor version. In cases where the cluster is at a version of Kubernetes that is at an N-2 minor version where N is the latest supported minor version, the cluster first upgrades to the latest supported patch version on N-1 minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster first is upgraded to 1.18.6, then is upgraded to 1.19.1.")
  rapid,
  @doc("Automatically upgrade the cluster to the latest supported patch release on minor version N-1, where N is the latest supported minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.18.6.")
  stable,
  @doc("Automatically upgrade the cluster to the latest supported patch version when it becomes available while keeping the minor version the same. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.17.9.")
  patch,
  @doc("Automatically upgrade the node image to the latest version available. Consider using nodeOSUpgradeChannel instead as that allows you to configure node OS patching separate from Kubernetes version patching")
  `node-image`,
  @doc("Disables auto-upgrades and keeps the cluster at its current version of Kubernetes.")
  none,
}

@doc("The default is Unmanaged, but may change to either NodeImage or SecurityPatch at GA.")
enum NodeOSUpgradeChannel {
  @doc("No attempt to update your machines OS will be made either by OS or by rolling VHDs. This means you are responsible for your security updates")
  None,
  @doc("OS updates will be applied automatically through the OS built-in patching infrastructure. Newly scaled in machines will be unpatched initially, and will be patched at some later time by the OS's infrastructure. Behavior of this option depends on the OS in question. Ubuntu and Mariner apply security patches through unattended upgrade roughly once a day around 06:00 UTC. Windows does not apply security patches automatically and so for them this option is equivalent to None till further notice")
  Unmanaged,
  @doc("AKS will update the nodes VHD with patches from the image maintainer labelled \"security only\" on a regular basis. Where possible, patches will also be applied without reimaging to existing nodes. Some patches, such as kernel patches, cannot be applied to existing nodes without disruption. For such patches, the VHD will be updated, and machines will be rolling reimaged to that VHD following maintenance windows and surge settings. This option incurs the extra cost of hosting the VHDs in your node resource group.")
  SecurityPatch,
  @doc("AKS will update the nodes with a newly patched VHD containing security fixes and bugfixes on a weekly cadence. With the VHD update machines will be rolling reimaged to that VHD following maintenance windows and surge settings. No extra VHD cost is incurred when choosing this option as AKS hosts the images.")
  NodeImage,
}

@doc("If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.")
enum Expander {
  @doc("Selects the node group that will have the least idle CPU (if tied, unused memory) after scale-up. This is useful when you have different classes of nodes, for example, high CPU or high memory nodes, and only want to expand those when there are pending pods that need a lot of those resources.")
  `least-waste`,
  @doc("Selects the node group that would be able to schedule the most pods when scaling up. This is useful when you are using nodeSelector to make sure certain pods land on certain nodes. Note that this won't cause the autoscaler to select bigger nodes vs. smaller, as it can add multiple smaller nodes at once.")
  `most-pods`,
  @doc("Selects the node group that has the highest priority assigned by the user. It's configuration is described in more details [here](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md).")
  priority,
  @doc("Used when you don't have a particular need for the node groups to scale differently.")
  random,
}

@doc("Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.")
enum KeyVaultNetworkAccessTypes {
  Public,
  Private,
}

@doc("Allow or deny public network access for AKS")
enum PublicNetworkAccess {
  @doc("Inbound/Outbound to the managedCluster is allowed.") Enabled,
  @doc("Inbound traffic to managedCluster is disabled, traffic from managedCluster is allowed.")
  Disabled,
  @doc("Inbound/Outbound traffic is managed by Microsoft.Network/NetworkSecurityPerimeters.")
  SecuredByPerimeter,
}

@doc("Controls which resource value autoscaler will change. Default value is RequestsAndLimits.")
enum ControlledValues {
  @doc("Autoscaler will control resource requests and limits.")
  RequestsAndLimits,
  @doc("Autoscaler will control resource requests only.") RequestsOnly,
}

@doc("Each update mode level is a superset of the lower levels. Off<Initial<Recreate<=Auto. For example: if UpdateMode is Initial, it means VPA sets the recommended resources in the VerticalPodAutoscaler Custom Resource (from UpdateMode Off) and also assigns resources on pod creation (from Initial). The default value is Off.")
enum UpdateMode {
  @doc("Autoscaler never changes pod resources but provides recommendations.")
  Off,
  @doc("Autoscaler only assigns resources on pod creation and doesn't change them during the lifetime of the pod.")
  Initial,
  @doc("Autoscaler assigns resources on pod creation and updates pods that need further scaling during their lifetime by deleting and recreating.")
  Recreate,
  @doc("Autoscaler chooses the update mode. Autoscaler currently does the same as Recreate. In the future, it may take advantage of restart-free mechanisms once they are available.")
  Auto,
}

@doc("The guardrails level to be used. By default, Guardrails is enabled for all namespaces except those that AKS excludes via systemExcludedNamespaces")
enum Level {
  Off,
  Warning,
  Enforcement,
}

enum Format {
  @doc("Return azure auth-provider kubeconfig. This format is deprecated in v1.22 and will be fully removed in v1.26. See: https://aka.ms/k8s/changes-1-26.")
  azure,
  @doc("Return exec format kubeconfig. This format requires kubelogin binary in the path.")
  exec,
}

@doc("The weekday enum.")
enum WeekDay {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

@doc("Specifies on which instance of the allowed days specified in daysOfWeek the maintenance occurs.")
enum Type {
  @doc("First.") First,
  @doc("Second.") Second,
  @doc("Third.") Third,
  @doc("Fourth.") Fourth,
  @doc("Last.") Last,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Canceled,
  Creating,
  Deleting,
  Failed,
  Succeeded,
}

@doc("The private link service connection status.")
enum ConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

@doc("The type of a snapshot. The default is NodePool.")
enum SnapshotType {
  @doc("The snapshot is a snapshot of a node pool.") NodePool,
  @doc("The snapshot is a snapshot of a managed cluster.") ManagedCluster,
}

@doc("The current provisioning state of trusted access role binding.")
enum TrustedAccessRoleBindingProvisioningState {
  Canceled,
  Deleting,
  Failed,
  Succeeded,
  Updating,
}

@doc("The provisioning state of the last accepted operation.")
enum FleetProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

@doc("The provisioning state of the last accepted operation.")
enum FleetMemberProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Joining,
  Leaving,
  Updating,
}

@doc("Size of agent VMs. Note: This is no longer maintained.")
enum ContainerServiceVMSizeTypes {
  Standard_A1,
  Standard_A10,
  Standard_A11,
  Standard_A1_v2,
  Standard_A2,
  Standard_A2_v2,
  Standard_A2m_v2,
  Standard_A3,
  Standard_A4,
  Standard_A4_v2,
  Standard_A4m_v2,
  Standard_A5,
  Standard_A6,
  Standard_A7,
  Standard_A8,
  Standard_A8_v2,
  Standard_A8m_v2,
  Standard_A9,
  Standard_B2ms,
  Standard_B2s,
  Standard_B4ms,
  Standard_B8ms,
  Standard_D1,
  Standard_D11,
  Standard_D11_v2,
  Standard_D11_v2_Promo,
  Standard_D12,
  Standard_D12_v2,
  Standard_D12_v2_Promo,
  Standard_D13,
  Standard_D13_v2,
  Standard_D13_v2_Promo,
  Standard_D14,
  Standard_D14_v2,
  Standard_D14_v2_Promo,
  Standard_D15_v2,
  Standard_D16_v3,
  Standard_D16s_v3,
  Standard_D1_v2,
  Standard_D2,
  Standard_D2_v2,
  Standard_D2_v2_Promo,
  Standard_D2_v3,
  Standard_D2s_v3,
  Standard_D3,
  Standard_D32_v3,
  Standard_D32s_v3,
  Standard_D3_v2,
  Standard_D3_v2_Promo,
  Standard_D4,
  Standard_D4_v2,
  Standard_D4_v2_Promo,
  Standard_D4_v3,
  Standard_D4s_v3,
  Standard_D5_v2,
  Standard_D5_v2_Promo,
  Standard_D64_v3,
  Standard_D64s_v3,
  Standard_D8_v3,
  Standard_D8s_v3,
  Standard_DS1,
  Standard_DS11,
  Standard_DS11_v2,
  Standard_DS11_v2_Promo,
  Standard_DS12,
  Standard_DS12_v2,
  Standard_DS12_v2_Promo,
  Standard_DS13,
  `Standard_DS13-2_v2`,
  `Standard_DS13-4_v2`,
  Standard_DS13_v2,
  Standard_DS13_v2_Promo,
  Standard_DS14,
  `Standard_DS14-4_v2`,
  `Standard_DS14-8_v2`,
  Standard_DS14_v2,
  Standard_DS14_v2_Promo,
  Standard_DS15_v2,
  Standard_DS1_v2,
  Standard_DS2,
  Standard_DS2_v2,
  Standard_DS2_v2_Promo,
  Standard_DS3,
  Standard_DS3_v2,
  Standard_DS3_v2_Promo,
  Standard_DS4,
  Standard_DS4_v2,
  Standard_DS4_v2_Promo,
  Standard_DS5_v2,
  Standard_DS5_v2_Promo,
  Standard_E16_v3,
  Standard_E16s_v3,
  Standard_E2_v3,
  Standard_E2s_v3,
  `Standard_E32-16s_v3`,
  `Standard_E32-8s_v3`,
  Standard_E32_v3,
  Standard_E32s_v3,
  Standard_E4_v3,
  Standard_E4s_v3,
  `Standard_E64-16s_v3`,
  `Standard_E64-32s_v3`,
  Standard_E64_v3,
  Standard_E64s_v3,
  Standard_E8_v3,
  Standard_E8s_v3,
  Standard_F1,
  Standard_F16,
  Standard_F16s,
  Standard_F16s_v2,
  Standard_F1s,
  Standard_F2,
  Standard_F2s,
  Standard_F2s_v2,
  Standard_F32s_v2,
  Standard_F4,
  Standard_F4s,
  Standard_F4s_v2,
  Standard_F64s_v2,
  Standard_F72s_v2,
  Standard_F8,
  Standard_F8s,
  Standard_F8s_v2,
  Standard_G1,
  Standard_G2,
  Standard_G3,
  Standard_G4,
  Standard_G5,
  Standard_GS1,
  Standard_GS2,
  Standard_GS3,
  Standard_GS4,
  `Standard_GS4-4`,
  `Standard_GS4-8`,
  Standard_GS5,
  `Standard_GS5-16`,
  `Standard_GS5-8`,
  Standard_H16,
  Standard_H16m,
  Standard_H16mr,
  Standard_H16r,
  Standard_H8,
  Standard_H8m,
  Standard_L16s,
  Standard_L32s,
  Standard_L4s,
  Standard_L8s,
  `Standard_M128-32ms`,
  `Standard_M128-64ms`,
  Standard_M128ms,
  Standard_M128s,
  `Standard_M64-16ms`,
  `Standard_M64-32ms`,
  Standard_M64ms,
  Standard_M64s,
  Standard_NC12,
  Standard_NC12s_v2,
  Standard_NC12s_v3,
  Standard_NC24,
  Standard_NC24r,
  Standard_NC24rs_v2,
  Standard_NC24rs_v3,
  Standard_NC24s_v2,
  Standard_NC24s_v3,
  Standard_NC6,
  Standard_NC6s_v2,
  Standard_NC6s_v3,
  Standard_ND12s,
  Standard_ND24rs,
  Standard_ND24s,
  Standard_ND6s,
  Standard_NV12,
  Standard_NV24,
  Standard_NV6,
}

@doc("Specifies what kind of storage to use. If omitted, the default will be chosen on your behalf based on the choice of orchestrator.")
enum ContainerServiceStorageProfileTypes {
  StorageAccount,
  ManagedDisks,
}

@doc("For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).")
@fixed
enum ResourceIdentityType {
  @doc("Use an implicitly created system assigned managed identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the system assigned managed identity to manipulate Azure resources.")
  SystemAssigned,
  @doc("Use a user-specified identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the specified user assigned managed identity to manipulate Azure resources.")
  UserAssigned,
  @doc("Do not use a managed identity for the Managed Cluster, service principal will be used instead.")
  None,
}

@doc("Number of masters (VMs) in the container service cluster. Allowed values are 1, 3, and 5. The default value is 1.")
@fixed
enum Count {
  `1`: 1,
  `3`: 3,
  `5`: 5,
}

@doc("Describes the properties of a Operation value.")
model OperationValue {
  @doc("The origin of the operation.")
  @visibility("read")
  origin?: string;

  @doc("The name of the operation.")
  @visibility("read")
  name?: string;

  @doc("Describes the properties of a Operation Value Display.")
  display?: OperationValueDisplay;
}

@doc("Describes the properties of a Operation Value Display.")
model OperationValueDisplay {
  @doc("The display name of the operation.")
  @visibility("read")
  operation?: string;

  @doc("The display name of the resource the operation applies to.")
  @visibility("read")
  resource?: string;

  @doc("The description of the operation.")
  @visibility("read")
  description?: string;

  @doc("The resource provider for the operation.")
  @visibility("read")
  provider?: string;
}

@doc("An error response from the Container service.")
@error
model CloudError {
  @doc("Details about the error.")
  error?: CloudErrorBody;
}

@doc("An error response from the Container service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("The list of OS option properties.")
model OSOptionPropertyList {
  @doc("The list of OS options.")
  osOptionPropertyList: OSOptionProperty[];
}

@doc("OS option property.")
model OSOptionProperty {
  @doc("The OS type.")
  @projectedName("json", "os-type")
  osType: string;

  @doc("Whether the image is FIPS-enabled.")
  @projectedName("json", "enable-fips-image")
  enableFipsImage: boolean;
}

@doc("The SKU of a Managed Cluster.")
model ManagedClusterSKU {
  @doc("The name of a managed cluster SKU.")
  name?: ManagedClusterSKUName;

  @doc("If not specified, the default is 'Free'. See [uptime SLA](https://docs.microsoft.com/azure/aks/uptime-sla) for more details.")
  tier?: ManagedClusterSKUTier;
}

@doc("The complex type of the extended location.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name?: string;

  @doc("The type of the extended location.")
  type?: ExtendedLocationTypes;
}

@doc("Identity for the managed cluster.")
model ManagedClusterIdentity {
  @doc("The principal id of the system assigned identity which is used by master components.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id of the system assigned identity which is used by master components.")
  @visibility("read")
  tenantId?: string;

  @doc("For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).")
  type?: ResourceIdentityType;

  @doc("The keys must be ARM resource IDs in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<ManagedServiceIdentityUserAssignedIdentitiesValue>;
}

model ManagedServiceIdentityUserAssignedIdentitiesValue {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Properties of the managed cluster.")
model ManagedClusterProperties {
  @doc("The current provisioning state.")
  @visibility("read")
  provisioningState?: string;

  @doc("The Power State of the cluster.")
  @visibility("read")
  powerState?: PowerState;

  @doc("CreationData to be used to specify the source Snapshot ID if the cluster will be created/upgraded using a snapshot.")
  creationData?: CreationData;

  @doc("The max number of agent pools for the managed cluster.")
  @visibility("read")
  maxAgentPools?: int32;

  @doc("When you upgrade a supported AKS cluster, Kubernetes minor versions cannot be skipped. All upgrades must be performed sequentially by major version number. For example, upgrades between 1.14.x -> 1.15.x or 1.15.x -> 1.16.x are allowed, however 1.14.x -> 1.16.x is not allowed. See [upgrading an AKS cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster) for more details.")
  kubernetesVersion?: string;

  @doc("The version of Kubernetes the Managed Cluster is running.")
  @visibility("read")
  currentKubernetesVersion?: string;

  @doc("This cannot be updated once the Managed Cluster has been created.")
  dnsPrefix?: string;

  @doc("This cannot be updated once the Managed Cluster has been created.")
  fqdnSubdomain?: string;

  @doc("The FQDN of the master pool.")
  @visibility("read")
  fqdn?: string;

  @doc("The FQDN of private cluster.")
  @visibility("read")
  @projectedName("json", "privateFQDN")
  privateFqdn?: string;

  @doc("The Azure Portal requires certain Cross-Origin Resource Sharing (CORS) headers to be sent in some responses, which Kubernetes APIServer doesn't handle by default. This special FQDN supports CORS, allowing the Azure Portal to function properly.")
  @visibility("read")
  @projectedName("json", "azurePortalFQDN")
  azurePortalFqdn?: string;

  @doc("The agent pool properties.")
  agentPoolProfiles?: ManagedClusterAgentPoolProfile[];

  @doc("The profile for Linux VMs in the Managed Cluster.")
  linuxProfile?: ContainerServiceLinuxProfile;

  @doc("The profile for Windows VMs in the Managed Cluster.")
  windowsProfile?: ManagedClusterWindowsProfile;

  @doc("Information about a service principal identity for the cluster to use for manipulating Azure APIs.")
  servicePrincipalProfile?: ManagedClusterServicePrincipalProfile;

  @doc("The profile of managed cluster add-on.")
  addonProfiles?: Record<ManagedClusterAddonProfile>;

  @doc("See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on AAD pod identity integration.")
  podIdentityProfile?: ManagedClusterPodIdentityProfile;

  @doc("The OIDC issuer profile of the Managed Cluster.")
  oidcIssuerProfile?: ManagedClusterOidcIssuerProfile;

  @doc("The name of the resource group containing agent pool nodes.")
  nodeResourceGroup?: string;

  @doc("The node resource group configuration profile.")
  nodeResourceGroupProfile?: ManagedClusterNodeResourceGroupProfile;

  @doc("Whether to enable Kubernetes Role-Based Access Control.")
  @projectedName("json", "enableRBAC")
  enableRbac?: boolean;

  @doc("(DEPRECATED) Whether to enable Kubernetes pod security policy (preview). PodSecurityPolicy was deprecated in Kubernetes v1.21, and removed from Kubernetes in v1.25. Learn more at https://aka.ms/k8s/psp and https://aka.ms/aks/psp.")
  enablePodSecurityPolicy?: boolean;

  @doc("The default value is false. It can be enabled/disabled on creation and updating of the managed cluster. See [https://aka.ms/NamespaceARMResource](https://aka.ms/NamespaceARMResource) for more details on Namespace as a ARM Resource.")
  enableNamespaceResources?: boolean;

  @doc("The network configuration profile.")
  networkProfile?: ContainerServiceNetworkProfile;

  @doc("The Azure Active Directory configuration.")
  aadProfile?: ManagedClusterAADProfile;

  @doc("The auto upgrade configuration.")
  autoUpgradeProfile?: ManagedClusterAutoUpgradeProfile;

  @doc("Parameters to be applied to the cluster-autoscaler when enabled")
  autoScalerProfile?: ManagedClusterPropertiesAutoScalerProfile;

  @doc("The access profile for managed cluster API server.")
  apiServerAccessProfile?: ManagedClusterAPIServerAccessProfile;

  @doc("This is of the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/diskEncryptionSets/{encryptionSetName}'")
  diskEncryptionSetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/diskEncryptionSets";
    }
  ]>;

  @doc("Identities associated with the cluster.")
  identityProfile?: Record<UserAssignedIdentity>;

  @doc("Private link resources associated with the cluster.")
  privateLinkResources?: PrivateLinkResource[];

  @doc("If set to true, getting static credentials will be disabled for this cluster. This must only be used on Managed Clusters that are AAD enabled. For more details see [disable local accounts](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts-preview).")
  disableLocalAccounts?: boolean;

  @doc("Configurations for provisioning the cluster with HTTP proxy servers.")
  httpProxyConfig?: ManagedClusterHttpProxyConfig;

  @doc("Security profile for the managed cluster.")
  securityProfile?: ManagedClusterSecurityProfile;

  @doc("Storage profile for the managed cluster.")
  storageProfile?: ManagedClusterStorageProfile;

  @doc("Ingress profile for the managed cluster.")
  ingressProfile?: ManagedClusterIngressProfile;

  @doc("Allow or deny public network access for AKS")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Workload Auto-scaler profile for the managed cluster.")
  workloadAutoScalerProfile?: ManagedClusterWorkloadAutoScalerProfile;

  @doc("Prometheus addon profile for the container service cluster")
  azureMonitorProfile?: ManagedClusterAzureMonitorProfile;

  @doc("The guardrails profile holds all the guardrails information for a given cluster")
  guardrailsProfile?: GuardrailsProfile;
}

@doc("Describes the Power State of the cluster")
model PowerState {
  @doc("Tells whether the cluster is Running or Stopped")
  code?: Code;
}

@doc("Data used when creating a target resource from a source resource.")
model CreationData {
  @doc("This is the ARM ID of the source object to be used to create the target object.")
  sourceResourceId?: ResourceIdentifier;
}

@doc("Profile for the container service agent pool.")
model ManagedClusterAgentPoolProfile
  extends ManagedClusterAgentPoolProfileProperties {
  @doc("Windows agent pool names must be 6 characters or less.")
  @pattern("^[a-z][a-z0-9]{0,11}$")
  name: string;
}

@doc("Properties for the container service agent pool profile.")
model ManagedClusterAgentPoolProfileProperties {
  @doc("Number of agents (VMs) to host docker containers. Allowed values must be in the range of 0 to 1000 (inclusive) for user pools and in the range of 1 to 1000 (inclusive) for system pools. The default value is 1.")
  count?: int32;

  @doc("VM size availability varies by region. If a node contains insufficient compute resources (memory, cpu, etc) pods might fail to run correctly. For more details on restricted VM sizes, see: https://docs.microsoft.com/azure/aks/quotas-skus-regions")
  vmSize?: string;

  @doc("OS Disk Size in GB to be used to specify the disk size for every machine in the master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.")
  @maxValue(2048)
  @projectedName("json", "osDiskSizeGB")
  OSDiskSizeInGB?: int32;

  @doc("The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).")
  osDiskType?: OSDiskType;

  @doc("Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.")
  kubeletDiskType?: KubeletDiskType;

  @doc("Determines the type of workload a node can run.")
  workloadRuntime?: WorkloadRuntime;

  @doc("A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It must not be specified for Windows nodes. It must be a static string (i.e., will be printed raw and not be executed as a script).")
  messageOfTheDay?: string;

  @doc("If this is not specified, a VNET and subnet will be generated and used. If no podSubnetID is specified, this applies to nodes and pods, otherwise it applies to just nodes. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}")
  vnetSubnetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}")
  podSubnetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("The maximum number of pods that can run on a node.")
  maxPods?: int32;

  @doc("The operating system type. The default is Linux.")
  osType?: OSType;

  @doc("Specifies the OS SKU used by the agent pool. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated.")
  osSKU?: OSSku;

  @doc("The maximum number of nodes for auto-scaling")
  maxCount?: int32;

  @doc("The minimum number of nodes for auto-scaling")
  minCount?: int32;

  @doc("Whether to enable auto-scaler")
  enableAutoScaling?: boolean;

  @doc("This also effects the cluster autoscaler behavior. If not specified, it defaults to Delete.")
  scaleDownMode?: ScaleDownMode;

  @doc("The type of Agent Pool.")
  type?: AgentPoolType;

  @doc("A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools")
  mode?: AgentPoolMode;

  @doc("Both patch version <major.minor.patch> and <major.minor> are supported. When <major.minor> is specified, the latest supported patch version is chosen automatically. Updating the agent pool with the same <major.minor> once it has been created will not trigger an upgrade, even if a newer patch version is available. As a best practice, you should upgrade all node pools in an AKS cluster to the same Kubernetes version. The node pool version must have the same major version as the control plane. The node pool minor version must be within two minor versions of the control plane version. The node pool version cannot be greater than the control plane version. For more information see [upgrading a node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#upgrade-a-node-pool).")
  orchestratorVersion?: string;

  @doc("If orchestratorVersion was a fully specified version <major.minor.patch>, this field will be exactly equal to it. If orchestratorVersion was <major.minor>, this field will contain the full <major.minor.patch> version being used.")
  @visibility("read")
  currentOrchestratorVersion?: string;

  @doc("The version of node image")
  @visibility("read")
  nodeImageVersion?: string;

  @doc("Settings for upgrading the agentpool")
  upgradeSettings?: AgentPoolUpgradeSettings;

  @doc("The current deployment or provisioning state.")
  @visibility("read")
  provisioningState?: string;

  @doc("When an Agent Pool is first created it is initially Running. The Agent Pool can be stopped by setting this field to Stopped. A stopped Agent Pool stops all of its VMs and does not accrue billing charges. An Agent Pool can only be stopped if it is Running and provisioning state is Succeeded")
  powerState?: PowerState;

  @doc("The list of Availability zones to use for nodes. This can only be specified if the AgentPoolType property is 'VirtualMachineScaleSets'.")
  availabilityZones?: string[];

  @doc("Some scenarios may require nodes in a node pool to receive their own dedicated public IP addresses. A common scenario is for gaming workloads, where a console needs to make a direct connection to a cloud virtual machine to minimize hops. For more information see [assigning a public IP per node](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#assign-a-public-ip-per-node-for-your-node-pools). The default is false.")
  enableNodePublicIP?: boolean;

  @doc("When set to true, AKS adds a label to the node indicating that the feature is enabled and deploys a daemonset along with host services to sync custom certificate authorities from user-provided list of base64 encoded certificates into node trust stores. Defaults to false.")
  enableCustomCATrust?: boolean;

  @doc("This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}")
  nodePublicIPPrefixID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  @doc("The Virtual Machine Scale Set priority. If not specified, the default is 'Regular'.")
  scaleSetPriority?: ScaleSetPriority;

  @doc("This cannot be specified unless the scaleSetPriority is 'Spot'. If not specified, the default is 'Delete'.")
  scaleSetEvictionPolicy?: ScaleSetEvictionPolicy;

  @doc("Possible values are any decimal value greater than zero or -1 which indicates the willingness to pay any on-demand price. For more details on spot pricing, see [spot VMs pricing](https://docs.microsoft.com/azure/virtual-machines/spot-vms#pricing)")
  spotMaxPrice?: float32;

  @doc("The tags to be persisted on the agent pool virtual machine scale set.")
  tags?: Record<string>;

  @doc("The node labels to be persisted across all nodes in agent pool.")
  nodeLabels?: Record<string>;

  @doc("The taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.")
  nodeTaints?: string[];

  @doc("The ID for Proximity Placement Group.")
  proximityPlacementGroupID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/proximityPlacementGroups";
    }
  ]>;

  @doc("The Kubelet configuration on the agent pool nodes.")
  kubeletConfig?: KubeletConfig;

  @doc("The OS configuration of Linux agent nodes.")
  linuxOSConfig?: LinuxOSConfig;

  @doc("This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption")
  enableEncryptionAtHost?: boolean;

  @doc("Whether to enable UltraSSD")
  enableUltraSSD?: boolean;

  @doc("See [Add a FIPS-enabled node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview) for more details.")
  @projectedName("json", "enableFIPS")
  enableFips?: boolean;

  @doc("GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.")
  gpuInstanceProfile?: GPUInstanceProfile;

  @doc("CreationData to be used to specify the source Snapshot ID if the node pool will be created/upgraded using a snapshot.")
  creationData?: CreationData;

  @doc("AKS will associate the specified agent pool with the Capacity Reservation Group.")
  capacityReservationGroupID?: string;

  @doc("This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}. For more information see [Azure dedicated hosts](https://docs.microsoft.com/azure/virtual-machines/dedicated-hosts).")
  hostGroupID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/hostGroups";
    }
  ]>;

  @doc("The Windows agent pool's specific profile.")
  windowsProfile?: AgentPoolWindowsProfile;

  @doc("Network-related settings of an agent pool.")
  networkProfile?: AgentPoolNetworkProfile;
}

@doc("Settings for upgrading an agentpool")
model AgentPoolUpgradeSettings {
  @doc("This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 1. For more information, including best practices, see: https://docs.microsoft.com/azure/aks/upgrade-cluster#customize-node-surge-upgrade")
  maxSurge?: string;
}

@doc("See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.")
model KubeletConfig {
  @doc("The default is 'none'. See [Kubernetes CPU management policies](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#cpu-management-policies) for more information. Allowed values are 'none' and 'static'.")
  cpuManagerPolicy?: string;

  @doc("The default is true.")
  cpuCfsQuota?: boolean;

  @doc("The default is '100ms.' Valid values are a sequence of decimal numbers with an optional fraction and a unit suffix. For example: '300ms', '2h45m'. Supported units are 'ns', 'us', 'ms', 's', 'm', and 'h'.")
  cpuCfsQuotaPeriod?: string;

  @doc("To disable image garbage collection, set to 100. The default is 85%")
  imageGcHighThreshold?: int32;

  @doc("This cannot be set higher than imageGcHighThreshold. The default is 80%")
  imageGcLowThreshold?: int32;

  @doc("For more information see [Kubernetes Topology Manager](https://kubernetes.io/docs/tasks/administer-cluster/topology-manager). The default is 'none'. Allowed values are 'none', 'best-effort', 'restricted', and 'single-numa-node'.")
  topologyManagerPolicy?: string;

  @doc("Allowed list of unsafe sysctls or unsafe sysctl patterns (ending in `*`).")
  allowedUnsafeSysctls?: string[];

  @doc("If set to true it will make the Kubelet fail to start if swap is enabled on the node.")
  failSwapOn?: boolean;

  @doc("The maximum size (e.g. 10Mi) of container log file before it is rotated.")
  containerLogMaxSizeMB?: int32;

  @doc("The maximum number of container log files that can be present for a container. The number must be ≥ 2.")
  @minValue(2)
  containerLogMaxFiles?: int32;

  @doc("The maximum number of processes per pod.")
  podMaxPids?: int32;
}

@doc("See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.")
model LinuxOSConfig {
  @doc("Sysctl settings for Linux agent nodes.")
  sysctls?: SysctlConfig;

  @doc("Valid values are 'always', 'madvise', and 'never'. The default is 'always'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).")
  transparentHugePageEnabled?: string;

  @doc("Valid values are 'always', 'defer', 'defer+madvise', 'madvise' and 'never'. The default is 'madvise'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).")
  transparentHugePageDefrag?: string;

  @doc("The size in MB of a swap file that will be created on each node.")
  swapFileSizeMB?: int32;
}

@doc("Sysctl settings for Linux agent nodes.")
model SysctlConfig {
  @doc("Sysctl setting net.core.somaxconn.")
  netCoreSomaxconn?: int32;

  @doc("Sysctl setting net.core.netdev_max_backlog.")
  netCoreNetdevMaxBacklog?: int32;

  @doc("Sysctl setting net.core.rmem_default.")
  netCoreRmemDefault?: int32;

  @doc("Sysctl setting net.core.rmem_max.")
  netCoreRmemMax?: int32;

  @doc("Sysctl setting net.core.wmem_default.")
  netCoreWmemDefault?: int32;

  @doc("Sysctl setting net.core.wmem_max.")
  netCoreWmemMax?: int32;

  @doc("Sysctl setting net.core.optmem_max.")
  netCoreOptmemMax?: int32;

  @doc("Sysctl setting net.ipv4.tcp_max_syn_backlog.")
  netIpv4TcpMaxSynBacklog?: int32;

  @doc("Sysctl setting net.ipv4.tcp_max_tw_buckets.")
  netIpv4TcpMaxTwBuckets?: int32;

  @doc("Sysctl setting net.ipv4.tcp_fin_timeout.")
  netIpv4TcpFinTimeout?: int32;

  @doc("Sysctl setting net.ipv4.tcp_keepalive_time.")
  netIpv4TcpKeepaliveTime?: int32;

  @doc("Sysctl setting net.ipv4.tcp_keepalive_probes.")
  netIpv4TcpKeepaliveProbes?: int32;

  @doc("Sysctl setting net.ipv4.tcp_keepalive_intvl.")
  netIpv4TcpkeepaliveIntvl?: int32;

  @doc("Sysctl setting net.ipv4.tcp_tw_reuse.")
  netIpv4TcpTwReuse?: boolean;

  @doc("Sysctl setting net.ipv4.ip_local_port_range.")
  netIpv4IpLocalPortRange?: string;

  @doc("Sysctl setting net.ipv4.neigh.default.gc_thresh1.")
  netIpv4NeighDefaultGcThresh1?: int32;

  @doc("Sysctl setting net.ipv4.neigh.default.gc_thresh2.")
  netIpv4NeighDefaultGcThresh2?: int32;

  @doc("Sysctl setting net.ipv4.neigh.default.gc_thresh3.")
  netIpv4NeighDefaultGcThresh3?: int32;

  @doc("Sysctl setting net.netfilter.nf_conntrack_max.")
  netNetfilterNfConntrackMax?: int32;

  @doc("Sysctl setting net.netfilter.nf_conntrack_buckets.")
  netNetfilterNfConntrackBuckets?: int32;

  @doc("Sysctl setting fs.inotify.max_user_watches.")
  fsInotifyMaxUserWatches?: int32;

  @doc("Sysctl setting fs.file-max.")
  fsFileMax?: int32;

  @doc("Sysctl setting fs.aio-max-nr.")
  fsAioMaxNr?: int32;

  @doc("Sysctl setting fs.nr_open.")
  fsNrOpen?: int32;

  @doc("Sysctl setting kernel.threads-max.")
  kernelThreadsMax?: int32;

  @doc("Sysctl setting vm.max_map_count.")
  vmMaxMapCount?: int32;

  @doc("Sysctl setting vm.swappiness.")
  vmSwappiness?: int32;

  @doc("Sysctl setting vm.vfs_cache_pressure.")
  vmVfsCachePressure?: int32;
}

@doc("The Windows agent pool's specific profile.")
model AgentPoolWindowsProfile {
  @doc("The default value is false. Outbound NAT can only be disabled if the cluster outboundType is NAT Gateway and the Windows agent pool does not have node public IP enabled.")
  disableOutboundNat?: boolean;
}

@doc("Network settings of an agent pool.")
model AgentPoolNetworkProfile {
  @doc("IPTags of instance-level public IPs.")
  nodePublicIPTags?: IPTag[];

  @doc("The port ranges that are allowed to access. The specified ranges are allowed to overlap.")
  allowedHostPorts?: PortRange[];

  @doc("The IDs of the application security groups which agent pool will associate when created.")
  applicationSecurityGroups?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationSecurityGroups";
    }
  ]>[];
}

@doc("Contains the IPTag associated with the object.")
model IPTag {
  @doc("The IP tag type. Example: RoutingPreference.")
  ipTagType?: string;

  @doc("The value of the IP tag associated with the public IP. Example: Internet.")
  tag?: string;
}

@doc("The port range.")
model PortRange {
  @doc("The minimum port that is included in the range. It should be ranged from 1 to 65535, and be less than or equal to portEnd.")
  @maxValue(65535)
  @minValue(1)
  portStart?: int32;

  @doc("The maximum port that is included in the range. It should be ranged from 1 to 65535, and be greater than or equal to portStart.")
  @maxValue(65535)
  @minValue(1)
  portEnd?: int32;

  @doc("The network protocol of the port.")
  protocol?: Protocol;
}

@doc("Profile for Linux VMs in the container service cluster.")
model ContainerServiceLinuxProfile {
  @doc("The administrator username to use for Linux VMs.")
  @pattern("^[A-Za-z][-A-Za-z0-9_]*$")
  adminUsername: string;

  @doc("The SSH configuration for Linux-based VMs running on Azure.")
  ssh: ContainerServiceSshConfiguration;
}

@doc("SSH configuration for Linux-based VMs running on Azure.")
model ContainerServiceSshConfiguration {
  @doc("The list of SSH public keys used to authenticate with Linux-based VMs. A maximum of 1 key may be specified.")
  publicKeys: ContainerServiceSshPublicKey[];
}

@doc("Contains information about SSH certificate public key data.")
model ContainerServiceSshPublicKey {
  @doc("Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.")
  keyData: string;
}

@doc("Profile for Windows VMs in the managed cluster.")
model ManagedClusterWindowsProfile {
  @doc("Specifies the name of the administrator account. <br><br> **Restriction:** Cannot end in \".\" <br><br> **Disallowed values:** \"administrator\", \"admin\", \"user\", \"user1\", \"test\", \"user2\", \"test1\", \"user3\", \"admin1\", \"1\", \"123\", \"a\", \"actuser\", \"adm\", \"admin2\", \"aspnet\", \"backup\", \"console\", \"david\", \"guest\", \"john\", \"owner\", \"root\", \"server\", \"sql\", \"support\", \"support_388945a0\", \"sys\", \"test2\", \"test3\", \"user4\", \"user5\". <br><br> **Minimum-length:** 1 character <br><br> **Max-length:** 20 characters")
  adminUsername: string;

  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length:** 8 characters <br><br> **Max-length:** 123 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\"")
  adminPassword?: string;

  @doc("The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.")
  licenseType?: LicenseType;

  @doc("For more details on CSI proxy, see the [CSI proxy GitHub repo](https://github.com/kubernetes-csi/csi-proxy).")
  @projectedName("json", "enableCSIProxy")
  IsCsiProxyEnabled?: boolean;

  @doc("The Windows gMSA Profile in the Managed Cluster.")
  gmsaProfile?: WindowsGmsaProfile;
}

@doc("Windows gMSA Profile in the managed cluster.")
model WindowsGmsaProfile {
  @doc("Specifies whether to enable Windows gMSA in the managed cluster.")
  enabled?: boolean;

  @doc("Specifies the DNS server for Windows gMSA. <br><br> Set it to empty if you have configured the DNS server in the vnet which is used to create the managed cluster.")
  dnsServer?: string;

  @doc("Specifies the root domain name for Windows gMSA. <br><br> Set it to empty if you have configured the DNS server in the vnet which is used to create the managed cluster.")
  rootDomainName?: string;
}

@doc("Information about a service principal identity for the cluster to use for manipulating Azure APIs.")
model ManagedClusterServicePrincipalProfile {
  @doc("The ID for the service principal.")
  clientId: string;

  @doc("The secret password associated with the service principal in plain text.")
  secret?: string;
}

@doc("A Kubernetes add-on profile for a managed cluster.")
model ManagedClusterAddonProfile {
  @doc("Whether the add-on is enabled or not.")
  enabled: boolean;

  @doc("Key-value pairs for configuring an add-on.")
  config?: Record<string>;

  @doc("Information of user assigned identity used by this add-on.")
  @visibility("read")
  identity?: ManagedClusterAddonProfileIdentity;
}

@doc("Information of user assigned identity used by this add-on.")
model ManagedClusterAddonProfileIdentity extends UserAssignedIdentity {}

@doc("See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on pod identity integration.")
model ManagedClusterPodIdentityProfile {
  @doc("Whether the pod identity addon is enabled.")
  enabled?: boolean;

  @doc("Running in Kubenet is disabled by default due to the security related nature of AAD Pod Identity and the risks of IP spoofing. See [using Kubenet network plugin with AAD Pod Identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity#using-kubenet-network-plugin-with-azure-active-directory-pod-managed-identities) for more information.")
  allowNetworkPluginKubenet?: boolean;

  @doc("The pod identities to use in the cluster.")
  userAssignedIdentities?: ManagedClusterPodIdentity[];

  @doc("The pod identity exceptions to allow.")
  userAssignedIdentityExceptions?: ManagedClusterPodIdentityException[];
}

@doc("Details about the pod identity assigned to the Managed Cluster.")
model ManagedClusterPodIdentity {
  @doc("The name of the pod identity.")
  name: string;

  @doc("The namespace of the pod identity.")
  `namespace`: string;

  @doc("The binding selector to use for the AzureIdentityBinding resource.")
  bindingSelector?: string;

  @doc("The user assigned identity details.")
  identity: UserAssignedIdentity;

  @doc("The current provisioning state of the pod identity.")
  @visibility("read")
  provisioningState?: ManagedClusterPodIdentityProvisioningState;

  @visibility("read")
  provisioningInfo?: ManagedClusterPodIdentityProvisioningInfo;
}

model ManagedClusterPodIdentityProvisioningInfo {
  @doc("Pod identity assignment error (if any).")
  error?: ManagedClusterPodIdentityProvisioningError;
}

@doc("An error response from the pod identity provisioning.")
model ManagedClusterPodIdentityProvisioningError {
  @doc("Details about the error.")
  error?: ManagedClusterPodIdentityProvisioningErrorBody;
}

@doc("An error response from the pod identity provisioning.")
model ManagedClusterPodIdentityProvisioningErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: ManagedClusterPodIdentityProvisioningErrorBody[];
}

@doc("See [disable AAD Pod Identity for a specific Pod/Application](https://azure.github.io/aad-pod-identity/docs/configure/application_exception/) for more details.")
model ManagedClusterPodIdentityException {
  @doc("The name of the pod identity exception.")
  name: string;

  @doc("The namespace of the pod identity exception.")
  `namespace`: string;

  @doc("The pod labels to match.")
  podLabels: Record<string>;
}

@doc("The OIDC issuer profile of the Managed Cluster.")
model ManagedClusterOidcIssuerProfile {
  @doc("The OIDC issuer url of the Managed Cluster.")
  @visibility("read")
  issuerURL?: string;

  @doc("Whether the OIDC issuer is enabled.")
  enabled?: boolean;
}

@doc("Node resource group lockdown profile for a managed cluster.")
model ManagedClusterNodeResourceGroupProfile {
  @doc("The restriction level applied to the cluster's node resource group")
  restrictionLevel?: RestrictionLevel;
}

@doc("Profile of network configuration.")
model ContainerServiceNetworkProfile {
  @doc("Network plugin used for building the Kubernetes network.")
  networkPlugin?: NetworkPlugin;

  @doc("Network plugin mode used for building the Kubernetes network.")
  networkPluginMode?: NetworkPluginMode;

  @doc("Network policy used for building the Kubernetes network.")
  networkPolicy?: NetworkPolicy;

  @doc("This cannot be specified if networkPlugin is anything other than 'azure'.")
  networkMode?: NetworkMode;

  @doc("The eBPF dataplane used for building the Kubernetes network.")
  ebpfDataplane?: EbpfDataplane;

  @doc("A CIDR notation IP range from which to assign pod IPs when kubenet is used.")
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  podCidr?: string;

  @doc("A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.")
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  serviceCidr?: string;

  @doc("An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.")
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string;

  @doc("A CIDR notation IP range assigned to the Docker bridge network. It must not overlap with any Subnet IP ranges or the Kubernetes service address range.")
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  dockerBridgeCidr?: string;

  @doc("This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).")
  outboundType?: OutboundType;

  @doc("The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.")
  loadBalancerSku?: LoadBalancerSku;

  @doc("Profile of the cluster load balancer.")
  loadBalancerProfile?: ManagedClusterLoadBalancerProfile;

  @doc("Profile of the cluster NAT gateway.")
  natGatewayProfile?: ManagedClusterNATGatewayProfile;

  @doc("One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.")
  podCidrs?: string[];

  @doc("One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking. They must not overlap with any Subnet IP ranges.")
  serviceCidrs?: string[];

  @doc("IP families are used to determine single-stack or dual-stack clusters. For single-stack, the expected value is IPv4. For dual-stack, the expected values are IPv4 and IPv6.")
  ipFamilies?: IpFamily[];

  @doc("Holds configuration customizations for kube-proxy. Any values not defined will use the kube-proxy defaulting behavior. See https://v<version>.docs.kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/ where <version> is represented by a <major version>-<minor version> string. Kubernetes version 1.23 would be '1-23'.")
  kubeProxyConfig?: ContainerServiceNetworkProfileKubeProxyConfig;
}

@doc("Profile of the managed cluster load balancer.")
model ManagedClusterLoadBalancerProfile {
  @doc("Desired managed outbound IPs for the cluster load balancer.")
  managedOutboundIPs?: ManagedClusterLoadBalancerProfileManagedOutboundIPs;

  @doc("Desired outbound IP Prefix resources for the cluster load balancer.")
  outboundIPPrefixes?: ManagedClusterLoadBalancerProfileOutboundIPPrefixes;

  @doc("Desired outbound IP resources for the cluster load balancer.")
  outboundIPs?: ManagedClusterLoadBalancerProfileOutboundIPs;

  @doc("The effective outbound IP resources of the cluster load balancer.")
  effectiveOutboundIPs?: ResourceReference[];

  @doc("The desired number of allocated SNAT ports per VM. Allowed values are in the range of 0 to 64000 (inclusive). The default value is 0 which results in Azure dynamically allocating ports.")
  @maxValue(64000)
  allocatedOutboundPorts?: int32;

  @doc("Desired outbound flow idle timeout in minutes. Allowed values are in the range of 4 to 120 (inclusive). The default value is 30 minutes.")
  @maxValue(120)
  @minValue(4)
  idleTimeoutInMinutes?: int32;

  @doc("Enable multiple standard load balancers per AKS cluster or not.")
  enableMultipleStandardLoadBalancers?: boolean;

  @doc("The type of the managed inbound Load Balancer BackendPool.")
  backendPoolType?: BackendPoolType;
}

@doc("Desired managed outbound IPs for the cluster load balancer.")
model ManagedClusterLoadBalancerProfileManagedOutboundIPs {
  @doc("The desired number of IPv4 outbound IPs created/managed by Azure for the cluster load balancer. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1. ")
  @maxValue(100)
  @minValue(1)
  count?: int32;

  @doc("The desired number of IPv6 outbound IPs created/managed by Azure for the cluster load balancer. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack. ")
  @maxValue(100)
  countIPv6?: int32;
}

@doc("Desired outbound IP Prefix resources for the cluster load balancer.")
model ManagedClusterLoadBalancerProfileOutboundIPPrefixes {
  @doc("A list of public IP prefix resources.")
  publicIPPrefixes?: ResourceReference[];
}

@doc("A reference to an Azure resource.")
model ResourceReference {
  @doc("The fully qualified Azure resource id.")
  id?: ResourceIdentifier;
}

@doc("Desired outbound IP resources for the cluster load balancer.")
model ManagedClusterLoadBalancerProfileOutboundIPs {
  @doc("A list of public IP resources.")
  publicIPs?: ResourceReference[];
}

@doc("Profile of the managed cluster NAT gateway.")
model ManagedClusterNATGatewayProfile {
  @doc("Profile of the managed outbound IP resources of the cluster NAT gateway.")
  managedOutboundIPProfile?: ManagedClusterManagedOutboundIPProfile;

  @doc("The effective outbound IP resources of the cluster NAT gateway.")
  effectiveOutboundIPs?: ResourceReference[];

  @doc("Desired outbound flow idle timeout in minutes. Allowed values are in the range of 4 to 120 (inclusive). The default value is 4 minutes.")
  @maxValue(120)
  @minValue(4)
  idleTimeoutInMinutes?: int32;
}

@doc("Profile of the managed outbound IP resources of the managed cluster.")
model ManagedClusterManagedOutboundIPProfile {
  @doc("The desired number of outbound IPs created/managed by Azure. Allowed values must be in the range of 1 to 16 (inclusive). The default value is 1. ")
  @maxValue(16)
  @minValue(1)
  count?: int32;
}

@doc("Holds configuration customizations for kube-proxy. Any values not defined will use the kube-proxy defaulting behavior. See https://v<version>.docs.kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/ where <version> is represented by a <major version>-<minor version> string. Kubernetes version 1.23 would be '1-23'.")
model ContainerServiceNetworkProfileKubeProxyConfig {
  @doc("Whether to enable on kube-proxy on the cluster (if no 'kubeProxyConfig' exists, kube-proxy is enabled in AKS by default without these customizations).")
  enabled?: boolean;

  @doc("Specify which proxy mode to use ('IPTABLES' or 'IPVS')")
  mode?: Mode;

  @doc("Holds configuration customizations for IPVS. May only be specified if 'mode' is set to 'IPVS'.")
  ipvsConfig?: ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig;
}

@doc("Holds configuration customizations for IPVS. May only be specified if 'mode' is set to 'IPVS'.")
model ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig {
  @doc("IPVS scheduler, for more information please see http://www.linuxvirtualserver.org/docs/scheduling.html.")
  scheduler?: IpvsScheduler;

  @doc("The timeout value used for idle IPVS TCP sessions in seconds. Must be a positive integer value.")
  tcpTimeoutSeconds?: int32;

  @doc("The timeout value used for IPVS TCP sessions after receiving a FIN in seconds. Must be a positive integer value.")
  tcpFinTimeoutSeconds?: int32;

  @doc("The timeout value used for IPVS UDP packets in seconds. Must be a positive integer value.")
  udpTimeoutSeconds?: int32;
}

@doc("For more details see [managed AAD on AKS](https://docs.microsoft.com/azure/aks/managed-aad).")
model ManagedClusterAADProfile {
  @doc("Whether to enable managed AAD.")
  managed?: boolean;

  @doc("Whether to enable Azure RBAC for Kubernetes authorization.")
  @projectedName("json", "enableAzureRBAC")
  enableAzureRbac?: boolean;

  @doc("The list of AAD group object IDs that will have admin role of the cluster.")
  adminGroupObjectIDs?: string[];

  @doc("The client AAD application ID.")
  clientAppID?: string;

  @doc("The server AAD application ID.")
  serverAppID?: string;

  @doc("The server AAD application secret.")
  serverAppSecret?: string;

  @doc("The AAD tenant ID to use for authentication. If not specified, will use the tenant of the deployment subscription.")
  tenantID?: string;
}

@doc("Auto upgrade profile for a managed cluster.")
model ManagedClusterAutoUpgradeProfile {
  @doc("For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).")
  upgradeChannel?: UpgradeChannel;

  @doc("The default is Unmanaged, but may change to either NodeImage or SecurityPatch at GA.")
  nodeOSUpgradeChannel?: NodeOSUpgradeChannel;
}

@doc("Parameters to be applied to the cluster-autoscaler when enabled")
model ManagedClusterPropertiesAutoScalerProfile {
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
  scanIntervalInSeconds?: string;

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

@doc("Access profile for managed cluster API server.")
model ManagedClusterAPIServerAccessProfile {
  @doc("IP ranges are specified in CIDR format, e.g. 137.117.106.88/29. This feature is not compatible with clusters that use Public IP Per Node, or clusters that are using a Basic Load Balancer. For more information see [API server authorized IP ranges](https://docs.microsoft.com/azure/aks/api-server-authorized-ip-ranges).")
  authorizedIPRanges?: string[];

  @doc("For more details, see [Creating a private AKS cluster](https://docs.microsoft.com/azure/aks/private-clusters).")
  enablePrivateCluster?: boolean;

  @doc("The default is System. For more details see [configure private DNS zone](https://docs.microsoft.com/azure/aks/private-clusters#configure-private-dns-zone). Allowed values are 'system' and 'none'.")
  privateDNSZone?: string;

  @doc("Whether to create additional public FQDN for private cluster or not.")
  @projectedName("json", "enablePrivateClusterPublicFQDN")
  enablePrivateClusterPublicFqdn?: boolean;

  @doc("Whether to disable run command for the cluster or not.")
  disableRunCommand?: boolean;

  @doc("Whether to enable apiserver vnet integration for the cluster or not.")
  enableVnetIntegration?: boolean;

  @doc("It is required when: 1. creating a new cluster with BYO Vnet; 2. updating an existing cluster to enable apiserver vnet integration.")
  subnetId?: string;
}

@doc("A private link resource")
model PrivateLinkResource {
  @doc("The ID of the private link resource.")
  id?: string;

  @doc("The name of the private link resource.")
  name?: string;

  @doc("The resource type.")
  type?: string;

  @doc("The group ID of the resource.")
  groupId?: string;

  @doc("The RequiredMembers of the resource")
  requiredMembers?: string[];

  @doc("The private link service ID of the resource, this field is exposed only to NRP internally.")
  @visibility("read")
  privateLinkServiceID?: ResourceIdentifier;
}

@doc("Cluster HTTP proxy configuration.")
model ManagedClusterHttpProxyConfig {
  @doc("The HTTP proxy server endpoint to use.")
  httpProxy?: string;

  @doc("The HTTPS proxy server endpoint to use.")
  httpsProxy?: string;

  @doc("The endpoints that should not go through proxy.")
  noProxy?: string[];

  @doc("A read-only list of all endpoints for which traffic should not be sent to the proxy. This list is a superset of noProxy and values injected by AKS.")
  @visibility("read")
  effectiveNoProxy?: string[];

  @doc("Alternative CA cert to use for connecting to proxy servers.")
  trustedCa?: string;
}

@doc("Security profile for the container service cluster.")
model ManagedClusterSecurityProfile {
  @doc("Microsoft Defender settings for the security profile.")
  defender?: ManagedClusterSecurityProfileDefender;

  @doc("Azure Key Vault [key management service](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) settings for the security profile.")
  azureKeyVaultKms?: AzureKeyVaultKms;

  @doc("[Workload Identity](https://azure.github.io/azure-workload-identity/docs/) settings for the security profile.")
  workloadIdentity?: ManagedClusterSecurityProfileWorkloadIdentity;

  @doc("ImageCleaner settings for the security profile.")
  imageCleaner?: ManagedClusterSecurityProfileImageCleaner;

  @doc("[Node Restriction](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction) settings for the security profile.")
  nodeRestriction?: ManagedClusterSecurityProfileNodeRestriction;

  @doc("A list of up to 10 base64 encoded CAs that will be added to the trust store on nodes with the Custom CA Trust feature enabled. For more information see [Custom CA Trust Certificates](https://learn.microsoft.com/en-us/azure/aks/custom-certificate-authority)")
  customCATrustCertificates?: bytes[];
}

@doc("Microsoft Defender settings for the security profile.")
model ManagedClusterSecurityProfileDefender {
  @doc("Resource ID of the Log Analytics workspace to be associated with Microsoft Defender. When Microsoft Defender is enabled, this field is required and must be a valid workspace resource ID. When Microsoft Defender is disabled, leave the field empty.")
  logAnalyticsWorkspaceResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  @doc("Microsoft Defender threat detection for Cloud settings for the security profile.")
  securityMonitoring?: ManagedClusterSecurityProfileDefenderSecurityMonitoring;
}

@doc("Microsoft Defender settings for the security profile threat detection.")
model ManagedClusterSecurityProfileDefenderSecurityMonitoring {
  @doc("Whether to enable Defender threat detection")
  enabled?: boolean;
}

@doc("Azure Key Vault key management service settings for the security profile.")
model AzureKeyVaultKms {
  @doc("Whether to enable Azure Key Vault key management service. The default is false.")
  enabled?: boolean;

  @doc("Identifier of Azure Key Vault key. See [key identifier format](https://docs.microsoft.com/en-us/azure/key-vault/general/about-keys-secrets-certificates#vault-name-and-object-name) for more details. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When Azure Key Vault key management service is disabled, leave the field empty.")
  keyId?: string;

  @doc("Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.")
  keyVaultNetworkAccess?: KeyVaultNetworkAccessTypes;

  @doc("Resource ID of key vault. When keyVaultNetworkAccess is `Private`, this field is required and must be a valid resource ID. When keyVaultNetworkAccess is `Public`, leave the field empty.")
  keyVaultResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

@doc("Workload Identity settings for the security profile.")
model ManagedClusterSecurityProfileWorkloadIdentity {
  @doc("Whether to enable Workload Identity")
  enabled?: boolean;
}

@doc("ImageCleaner removes unused images from nodes, freeing up disk space and helping to reduce attack surface area. Here are settings for the security profile.")
model ManagedClusterSecurityProfileImageCleaner {
  @doc("Whether to enable ImageCleaner on AKS cluster.")
  enabled?: boolean;

  @doc("ImageCleaner scanning interval.")
  intervalHours?: int32;
}

@doc("Node Restriction settings for the security profile.")
model ManagedClusterSecurityProfileNodeRestriction {
  @doc("Whether to enable Node Restriction")
  enabled?: boolean;
}

@doc("Storage profile for the container service cluster.")
model ManagedClusterStorageProfile {
  @doc("AzureDisk CSI Driver settings for the storage profile.")
  diskCSIDriver?: ManagedClusterStorageProfileDiskCSIDriver;

  @doc("AzureFile CSI Driver settings for the storage profile.")
  fileCSIDriver?: ManagedClusterStorageProfileFileCSIDriver;

  @doc("Snapshot Controller settings for the storage profile.")
  snapshotController?: ManagedClusterStorageProfileSnapshotController;

  @doc("AzureBlob CSI Driver settings for the storage profile.")
  blobCSIDriver?: ManagedClusterStorageProfileBlobCSIDriver;
}

@doc("AzureDisk CSI Driver settings for the storage profile.")
model ManagedClusterStorageProfileDiskCSIDriver {
  @doc("Whether to enable AzureDisk CSI Driver. The default value is true.")
  enabled?: boolean;

  @doc("The version of AzureDisk CSI Driver. The default value is v1.")
  version?: string;
}

@doc("AzureFile CSI Driver settings for the storage profile.")
model ManagedClusterStorageProfileFileCSIDriver {
  @doc("Whether to enable AzureFile CSI Driver. The default value is true.")
  enabled?: boolean;
}

@doc("Snapshot Controller settings for the storage profile.")
model ManagedClusterStorageProfileSnapshotController {
  @doc("Whether to enable Snapshot Controller. The default value is true.")
  enabled?: boolean;
}

@doc("AzureBlob CSI Driver settings for the storage profile.")
model ManagedClusterStorageProfileBlobCSIDriver {
  @doc("Whether to enable AzureBlob CSI Driver. The default value is false.")
  enabled?: boolean;
}

@doc("Ingress profile for the container service cluster.")
model ManagedClusterIngressProfile {
  @doc("Web App Routing settings for the ingress profile.")
  webAppRouting?: ManagedClusterIngressProfileWebAppRouting;
}

@doc("Web App Routing settings for the ingress profile.")
model ManagedClusterIngressProfileWebAppRouting {
  @doc("Whether to enable Web App Routing.")
  enabled?: boolean;

  @doc("Resource ID of the DNS Zone to be associated with the web app. Used only when Web App Routing is enabled.")
  dnsZoneResourceId?: ResourceIdentifier;
}

@doc("Workload Auto-scaler profile for the managed cluster.")
model ManagedClusterWorkloadAutoScalerProfile {
  @doc("KEDA (Kubernetes Event-driven Autoscaling) settings for the workload auto-scaler profile.")
  keda?: ManagedClusterWorkloadAutoScalerProfileKeda;

  verticalPodAutoscaler?: ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler;
}

@doc("KEDA (Kubernetes Event-driven Autoscaling) settings for the workload auto-scaler profile.")
model ManagedClusterWorkloadAutoScalerProfileKeda {
  @doc("Whether to enable KEDA.")
  enabled: boolean;
}

model ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler {
  @doc("Whether to enable VPA. Default value is false.")
  enabled: boolean;

  @doc("Controls which resource value autoscaler will change. Default value is RequestsAndLimits.")
  controlledValues: ControlledValues;

  @doc("Each update mode level is a superset of the lower levels. Off<Initial<Recreate<=Auto. For example: if UpdateMode is Initial, it means VPA sets the recommended resources in the VerticalPodAutoscaler Custom Resource (from UpdateMode Off) and also assigns resources on pod creation (from Initial). The default value is Off.")
  updateMode: UpdateMode;
}

@doc("Prometheus addon profile for the container service cluster")
model ManagedClusterAzureMonitorProfile {
  @doc("Metrics profile for the prometheus service addon")
  metrics?: ManagedClusterAzureMonitorProfileMetrics;
}

@doc("Metrics profile for the prometheus service addon")
model ManagedClusterAzureMonitorProfileMetrics {
  @doc("Whether to enable the Prometheus collector")
  enabled: boolean;

  @doc("Kube State Metrics for prometheus addon profile for the container service cluster")
  kubeStateMetrics?: ManagedClusterAzureMonitorProfileKubeStateMetrics;
}

@doc("Kube State Metrics for prometheus addon profile for the container service cluster")
model ManagedClusterAzureMonitorProfileKubeStateMetrics {
  @doc("Comma-separated list of Kubernetes annotations keys that will be used in the resource's labels metric. ")
  metricLabelsAllowlist?: string;

  @doc("Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.")
  metricAnnotationsAllowList?: string;
}

@doc("The Guardrails profile.")
model GuardrailsProfile {
  @doc("List of namespaces specified by AKS to be excluded from Guardrails")
  @visibility("read")
  systemExcludedNamespaces?: string[];

  @doc("The version of constraints to use")
  version: string;

  @doc("The guardrails level to be used. By default, Guardrails is enabled for all namespaces except those that AKS excludes via systemExcludedNamespaces")
  level: Level;

  @doc("List of namespaces excluded from guardrails checks")
  excludedNamespaces?: string[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

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
model ManagedClusterUpgradeProfileProperties {
  @doc("The list of available upgrade versions for the control plane.")
  controlPlaneProfile: ManagedClusterPoolUpgradeProfile;

  @doc("The list of available upgrade versions for agent pools.")
  agentPoolProfiles: ManagedClusterPoolUpgradeProfile[];
}

@doc("The list of available upgrade versions.")
model ManagedClusterPoolUpgradeProfile {
  @doc("The Kubernetes version (major.minor.patch).")
  kubernetesVersion: string;

  @doc("The Agent Pool name.")
  name?: string;

  @doc("The operating system type. The default is Linux.")
  osType: OSType;

  @doc("List of orchestrator types and versions available for upgrade.")
  upgrades?: ManagedClusterPoolUpgradeProfileUpgradesItem[];
}

model ManagedClusterPoolUpgradeProfileUpgradesItem {
  @doc("The Kubernetes version (major.minor.patch).")
  kubernetesVersion?: string;

  @doc("Whether the Kubernetes version is currently in preview.")
  isPreview?: boolean;
}

@doc("Managed cluster Access Profile.")
model ManagedClusterAccessProfile extends TrackedResource {
  @doc("AccessProfile of a managed cluster.")
  properties?: AccessProfile;
}

@doc("Profile for enabling a user to access a managed cluster.")
model AccessProfile {
  @doc("Base64-encoded Kubernetes configuration file.")
  kubeConfig?: bytes;
}

@doc("The list credential result response.")
model CredentialResults {
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

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties used to configure planned maintenance for a Managed Cluster.")
model MaintenanceConfigurationProperties {
  @doc("If two array entries specify the same day of the week, the applied configuration is the union of times in both entries.")
  @projectedName("json", "timeInWeek")
  timesInWeek?: TimeInWeek[];

  @doc("Time slots on which upgrade is not allowed.")
  @projectedName("json", "notAllowedTime")
  notAllowedTimes?: TimeSpan[];

  @doc("Maintenance window for the maintenance configuration.")
  maintenanceWindow?: MaintenanceWindow;
}

@doc("Time in a week.")
model TimeInWeek {
  @doc("The day of the week.")
  day?: WeekDay;

  @doc("Each integer hour represents a time range beginning at 0m after the hour ending at the next hour (non-inclusive). 0 corresponds to 00:00 UTC, 23 corresponds to 23:00 UTC. Specifying [0, 1] means the 00:00 - 02:00 UTC time range.")
  hourSlots?: int32[];
}

@doc("For example, between 2021-05-25T13:00:00Z and 2021-05-25T14:00:00Z.")
model TimeSpan {
  @doc("The start of a time span")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start?: utcDateTime;

  @doc("The end of a time span")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end?: utcDateTime;
}

@doc("Maintenance window used to configure scheduled auto-upgrade for a Managed Cluster.")
model MaintenanceWindow {
  @doc("Recurrence schedule for the maintenance window.")
  schedule: Schedule;

  @doc("Length of maintenance window range from 4 to 24 hours.")
  @maxValue(24)
  @minValue(4)
  durationHours: int32;

  @doc("The UTC offset in format +/-HH:mm. For example, '+05:30' for IST and '-07:00' for PST. If not specified, the default is '+00:00'.")
  @pattern("^(-|\\+)[0-9]{2}:[0-9]{2}$")
  utcOffset?: string;

  @doc("The date the maintenance window activates. If the current date is before this date, the maintenance window is inactive and will not be used for upgrades. If not specified, the maintenance window will be active right away.")
  startDate?: plainDate;

  @doc("The start time of the maintenance window. Accepted values are from '00:00' to '23:59'. 'utcOffset' applies to this field. For example: '02:00' with 'utcOffset: +02:00' means UTC time '00:00'.")
  @pattern("^\\d{2}:\\d{2}$")
  startTime: string;

  @doc("Date ranges on which upgrade is not allowed. 'utcOffset' applies to this field. For example, with 'utcOffset: +02:00' and 'dateSpan' being '2022-12-23' to '2023-01-03', maintenance will be blocked from '2022-12-22 22:00' to '2023-01-03 22:00' in UTC time.")
  notAllowedDates?: DateSpan[];
}

@doc("One and only one of the schedule types should be specified. Choose either 'daily', 'weekly', 'absoluteMonthly' or 'relativeMonthly' for your maintenance schedule.")
model Schedule {
  @doc("For schedules like: 'recur every day' or 'recur every 3 days'.")
  daily?: DailySchedule;

  @doc("For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.")
  weekly?: WeeklySchedule;

  @doc("For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.")
  absoluteMonthly?: AbsoluteMonthlySchedule;

  @doc("For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.")
  relativeMonthly?: RelativeMonthlySchedule;
}

@doc("For schedules like: 'recur every day' or 'recur every 3 days'.")
model DailySchedule {
  @doc("Specifies the number of days between each set of occurrences.")
  @maxValue(7)
  @minValue(1)
  intervalDays: int32;
}

@doc("For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.")
model WeeklySchedule {
  @doc("Specifies the number of weeks between each set of occurrences.")
  @maxValue(4)
  @minValue(1)
  intervalWeeks: int32;

  @doc("Specifies on which day of the week the maintenance occurs.")
  dayOfWeek: WeekDay;
}

@doc("For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.")
model AbsoluteMonthlySchedule {
  @doc("Specifies the number of months between each set of occurrences.")
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  @doc("The date of the month.")
  @maxValue(31)
  @minValue(1)
  dayOfMonth: int32;
}

@doc("For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.")
model RelativeMonthlySchedule {
  @doc("Specifies the number of months between each set of occurrences.")
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  @doc("Specifies on which instance of the allowed days specified in daysOfWeek the maintenance occurs.")
  weekIndex: Type;

  @doc("Specifies on which day of the week the maintenance occurs.")
  dayOfWeek: WeekDay;
}

@doc("For example, between '2022-12-23' and '2023-01-05'.")
model DateSpan {
  @doc("The start date of the date span.")
  start: plainDate;

  @doc("The end date of the date span.")
  end: plainDate;
}

@doc("Reference to another subresource.")
model SubResource {
  @doc("Resource ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource that is unique within a resource group. This name can be used to access the resource.")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;
}

@doc("The list of available upgrade versions.")
model AgentPoolUpgradeProfileProperties {
  @doc("The Kubernetes version (major.minor.patch).")
  kubernetesVersion: string;

  @doc("The operating system type. The default is Linux.")
  osType: OSType;

  @doc("List of orchestrator types and versions available for upgrade.")
  upgrades?: AgentPoolUpgradeProfilePropertiesUpgradesItem[];

  @doc("The latest AKS supported node image version.")
  latestNodeImageVersion?: string;
}

model AgentPoolUpgradeProfilePropertiesUpgradesItem {
  @doc("The Kubernetes version (major.minor.patch).")
  kubernetesVersion?: string;

  @doc("Whether the Kubernetes version is currently in preview.")
  isPreview?: boolean;
}

@doc("The list of available versions for an agent pool.")
model AgentPoolAvailableVersions {
  @doc("The ID of the agent pool version list.")
  @visibility("read")
  id?: string;

  @doc("The name of the agent pool version list.")
  @visibility("read")
  name?: string;

  @doc("Type of the agent pool version list.")
  @visibility("read")
  type?: string;

  @doc("Properties of agent pool available versions.")
  properties: AgentPoolAvailableVersionsProperties;
}

@doc("The list of available agent pool versions.")
model AgentPoolAvailableVersionsProperties {
  @doc("List of versions available for agent pool.")
  agentPoolVersions?: AgentPoolAvailableVersion[];
}

model AgentPoolAvailableVersion {
  @doc("Whether this version is the default agent pool version.")
  @projectedName("json", "default")
  IsDefault?: boolean;

  @doc("The Kubernetes version (major.minor.patch).")
  kubernetesVersion?: string;

  @doc("Whether Kubernetes version is currently in preview.")
  isPreview?: boolean;
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The current provisioning state.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  @doc("The resource of private endpoint.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

@doc("Private endpoint which a connection belongs to.")
model PrivateEndpoint {
  @doc("The resource ID of the private endpoint")
  id?: string;
}

@doc("The state of a private link service connection.")
model PrivateLinkServiceConnectionState {
  @doc("The private link service connection status.")
  status?: ConnectionStatus;

  @doc("The private link service connection description.")
  description?: string;
}

@doc("A list of private link resources")
model PrivateLinkResourcesListResult {
  @doc("The collection value.")
  value?: PrivateLinkResource[];
}

@doc("A run command request")
model RunCommandRequest {
  @doc("The command to run.")
  command: string;

  @doc("A base64 encoded zip file containing the files required by the command.")
  context?: string;

  @doc("AuthToken issued for AKS AAD Server App.")
  clusterToken?: string;
}

@doc("run command result.")
model RunCommandResult {
  @doc("The command id.")
  @visibility("read")
  id?: string;

  @doc("Properties of command result.")
  properties?: CommandResultProperties;
}

@doc("The results of a run command")
model CommandResultProperties {
  @doc("provisioning State")
  @visibility("read")
  provisioningState?: string;

  @doc("The exit code of the command")
  @visibility("read")
  exitCode?: int32;

  @doc("The time when the command started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  @doc("The time when the command finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedAt?: utcDateTime;

  @doc("The command output.")
  @visibility("read")
  logs?: string;

  @doc("An explanation of why provisioningState is set to failed (if so).")
  @visibility("read")
  reason?: string;
}

@doc("Collection of OutboundEnvironmentEndpoint")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("Egress endpoints which AKS agent nodes connect to for common purpose.")
model OutboundEnvironmentEndpoint {
  @doc("The category of endpoints accessed by the AKS agent node, e.g. azure-resource-management, apiserver, etc.")
  category?: string;

  @doc("The endpoints that AKS agent nodes connect to")
  endpoints?: EndpointDependency[];
}

@doc("A domain name that AKS agent nodes are reaching at.")
model EndpointDependency {
  @doc("The domain name of the dependency.")
  domainName?: string;

  @doc("The Ports and Protocols used when connecting to domainName.")
  endpointDetails?: EndpointDetail[];
}

@doc("connect information from the AKS agent nodes to a single endpoint.")
model EndpointDetail {
  @doc("An IP Address that Domain Name currently resolves to.")
  ipAddress?: string;

  @doc("The port an endpoint is connected to.")
  port?: int32;

  @doc("The protocol used for connection")
  protocol?: string;

  @doc("Description of the detail")
  description?: string;
}

@doc("Properties used to configure a node pool snapshot.")
model SnapshotProperties {
  @doc("CreationData to be used to specify the source agent pool resource ID to create this snapshot.")
  creationData?: CreationData;

  @doc("The type of a snapshot. The default is NodePool.")
  snapshotType?: SnapshotType;

  @doc("The version of Kubernetes.")
  @visibility("read")
  kubernetesVersion?: string;

  @doc("The version of node image.")
  @visibility("read")
  nodeImageVersion?: string;

  @doc("The operating system type. The default is Linux.")
  @visibility("read")
  osType?: OSType;

  @doc("Specifies the OS SKU used by the agent pool. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated.")
  @visibility("read")
  osSku?: OSSku;

  @doc("The size of the VM.")
  @visibility("read")
  vmSize?: string;

  @doc("Whether to use a FIPS-enabled OS.")
  @visibility("read")
  @projectedName("json", "enableFIPS")
  enableFips?: boolean;
}

@doc("Properties for a managed cluster snapshot.")
model ManagedClusterSnapshotProperties {
  @doc("CreationData to be used to specify the source resource ID to create this snapshot.")
  creationData?: CreationData;

  @doc("The type of a snapshot. The default is NodePool.")
  snapshotType?: SnapshotType;

  @doc("What the properties will be showed when getting managed cluster snapshot. Those properties are read-only.")
  @visibility("read")
  managedClusterPropertiesReadOnly?: ManagedClusterPropertiesForSnapshot;
}

@doc("managed cluster properties for snapshot, these properties are read only.")
model ManagedClusterPropertiesForSnapshot {
  @doc("The current kubernetes version.")
  kubernetesVersion?: string;

  @doc("The current managed cluster sku.")
  sku?: ManagedClusterSKU;

  @doc("Whether the cluster has enabled Kubernetes Role-Based Access Control or not.")
  enableRbac?: boolean;

  @doc("The current network profile.")
  @visibility("read")
  networkProfile?: NetworkProfileForSnapshot;
}

@doc("network profile for managed cluster snapshot, these properties are read only.")
model NetworkProfileForSnapshot {
  @doc("networkPlugin for managed cluster snapshot.")
  networkPlugin?: NetworkPlugin;

  @doc("NetworkPluginMode for managed cluster snapshot.")
  networkPluginMode?: NetworkPluginMode;

  @doc("networkPolicy for managed cluster snapshot.")
  networkPolicy?: NetworkPolicy;

  @doc("networkMode for managed cluster snapshot.")
  networkMode?: NetworkMode;

  @doc("loadBalancerSku for managed cluster snapshot.")
  loadBalancerSku?: LoadBalancerSku;
}

@doc("List of trusted access roles")
model TrustedAccessRoleListResult is Azure.Core.Page<TrustedAccessRole>;

@doc("Trusted access role definition.")
model TrustedAccessRole {
  @doc("Resource type of Azure resource")
  @visibility("read")
  sourceResourceType?: string;

  @doc("Name of role, name is unique under a source resource type")
  @visibility("read")
  name?: string;

  @doc("List of rules for the role. This maps to 'rules' property of [Kubernetes Cluster Role](https://kubernetes.io/docs/reference/kubernetes-api/authorization-resources/cluster-role-v1/#ClusterRole).")
  @visibility("read")
  rules?: TrustedAccessRoleRule[];
}

@doc("Rule for trusted access role")
model TrustedAccessRoleRule {
  @doc("List of allowed verbs")
  @visibility("read")
  verbs?: string[];

  @doc("List of allowed apiGroups")
  @visibility("read")
  apiGroups?: string[];

  @doc("List of allowed resources")
  @visibility("read")
  resources?: string[];

  @doc("List of allowed names")
  @visibility("read")
  resourceNames?: string[];

  @doc("List of allowed nonResourceURLs")
  @visibility("read")
  nonResourceURLs?: string[];
}

@doc("Properties for trusted access role binding")
model TrustedAccessRoleBindingProperties {
  @doc("The current provisioning state of trusted access role binding.")
  @visibility("read")
  provisioningState?: TrustedAccessRoleBindingProvisioningState;

  @doc("The ARM resource ID of source resource that trusted access is configured for.")
  sourceResourceId: string;

  @doc("A list of roles to bind, each item is a resource type qualified role name. For example: 'Microsoft.MachineLearningServices/workspaces/reader'.")
  roles: string[];
}

@doc("Properties of a Fleet.")
model FleetProperties {
  @doc("The FleetHubProfile configures the Fleet's hub.")
  hubProfile?: FleetHubProfile;

  @doc("The provisioning state of the last accepted operation.")
  @visibility("read")
  provisioningState?: FleetProvisioningState;
}

@doc("The FleetHubProfile configures the fleet hub.")
model FleetHubProfile {
  @doc("DNS prefix used to create the FQDN for the Fleet hub.")
  @visibility("read", "create")
  @maxLength(54)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][a-zA-Z0-9-]{0,52}[a-zA-Z0-9]$")
  dnsPrefix?: string;

  @doc("The FQDN of the Fleet hub.")
  @visibility("read")
  fqdn?: string;

  @doc("The Kubernetes version of the Fleet hub.")
  @visibility("read")
  kubernetesVersion?: string;
}

@doc("Properties of a Fleet that can be patched.")
model FleetPatch {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("The list credential result response.")
model FleetCredentialResults {
  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  kubeconfigs?: FleetCredentialResult[];
}

@doc("The credential result response.")
model FleetCredentialResult {
  @doc("The name of the credential.")
  @visibility("read")
  name?: string;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility("read")
  value?: bytes;
}

@doc("Properties of a Fleet member.")
model FleetMemberProperties {
  @doc("The ARM resource id of the cluster that joins the Fleet. Must be a valid Azure resource id. e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/{clusterName}'.")
  @visibility("read", "create")
  clusterResourceId?: string;

  @doc("The provisioning state of the last accepted operation.")
  @visibility("read")
  provisioningState?: FleetMemberProvisioningState;
}

@doc("The resource model definition for an Azure Resource Manager resource with an etag.")
model AzureEntityResource extends Resource {
  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;
}

@doc("Profile for the container service master.")
model ContainerServiceMasterProfile {
  @doc("Number of masters (VMs) in the container service cluster. Allowed values are 1, 3, and 5. The default value is 1.")
  count?: Count;

  @doc("DNS prefix to be used to create the FQDN for the master pool.")
  dnsPrefix: string;

  @doc("Size of agent VMs.")
  vmSize: ContainerServiceVMSizeTypes;

  @doc("OS Disk Size in GB to be used to specify the disk size for every machine in this master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.")
  @maxValue(2048)
  @projectedName("json", "osDiskSizeGB")
  OSDiskSizeInGB?: int32;

  @doc("VNet SubnetID specifies the VNet's subnet identifier.")
  vnetSubnetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("FirstConsecutiveStaticIP used to specify the first static ip of masters.")
  firstConsecutiveStaticIP?: string;

  @doc("Storage profile specifies what kind of storage used. Choose from StorageAccount and ManagedDisks. Leave it empty, we will choose for you based on the orchestrator choice.")
  storageProfile?: ContainerServiceStorageProfileTypes;

  @doc("FQDN for the master pool.")
  @visibility("read")
  fqdn?: string;
}

@doc("Profile for diagnostics on the container service cluster.")
model ContainerServiceDiagnosticsProfile {
  @doc("Profile for diagnostics on the container service VMs.")
  vmDiagnostics: ContainerServiceVMDiagnostics;
}

@doc("Profile for diagnostics on the container service VMs.")
model ContainerServiceVMDiagnostics {
  @doc("Whether the VM diagnostic agent is provisioned on the VM.")
  enabled: boolean;

  @doc("The URI of the storage account where diagnostics are stored.")
  @visibility("read")
  storageUri?: string;
}
