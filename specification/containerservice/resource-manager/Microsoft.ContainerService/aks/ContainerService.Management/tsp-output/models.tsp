import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Different support tiers for AKS managed clusters
 */
enum KubernetesSupportPlan {
  /**
   * Support for the version is the same as for the open source Kubernetes offering. Official Kubernetes open source community support versions for 1 year after release.
   */
  KubernetesOfficial,

  /**
   * Support for the version extended past the KubernetesOfficial support of 1 year. AKS continues to patch CVEs for another 1 year, for a total of 2 years of support.
   */
  AKSLongTermSupport,
}

/**
 * The name of a managed cluster SKU.
 */
enum ManagedClusterSKUName {
  /**
   * Base option for the AKS control plane.
   */
  Base,
}

/**
 * If not specified, the default is 'Free'. See [AKS Pricing Tier](https://learn.microsoft.com/azure/aks/free-standard-pricing-tiers) for more details.
 */
enum ManagedClusterSKUTier {
  /**
   * Cluster has premium capabilities in addition to all of the capabilities included in 'Standard'. Premium enables selection of LongTermSupport (aka.ms/aks/lts) for certain Kubernetes versions.
   */
  Premium,

  /**
   * Recommended for mission-critical and production workloads. Includes Kubernetes control plane autoscaling, workload-intensive testing, and up to 5,000 nodes per cluster. Guarantees 99.95% availability of the Kubernetes API server endpoint for clusters that use Availability Zones and 99.9% of availability for clusters that don't use Availability Zones.
   */
  Standard,

  /**
   * The cluster management is free, but charged for VM, storage, and networking usage. Best for experimenting, learning, simple testing, or workloads with fewer than 10 nodes. Not recommended for production use cases.
   */
  Free,
}

/**
 * The type of extendedLocation.
 */
enum ExtendedLocationTypes {
  EdgeZone,
}

/**
 * Tells whether the cluster is Running or Stopped
 */
enum Code {
  /**
   * The cluster is running.
   */
  Running,

  /**
   * The cluster is stopped.
   */
  Stopped,
}

/**
 * The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
 */
enum OSDiskType {
  /**
   * Azure replicates the operating system disk for a virtual machine to Azure storage to avoid data loss should the VM need to be relocated to another host. Since containers aren't designed to have local state persisted, this behavior offers limited value while providing some drawbacks, including slower node provisioning and higher read/write latency.
   */
  Managed,

  /**
   * Ephemeral OS disks are stored only on the host machine, just like a temporary disk. This provides lower read/write latency, along with faster node scaling and cluster upgrades.
   */
  Ephemeral,
}

/**
 * Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.
 */
enum KubeletDiskType {
  /**
   * Kubelet will use the OS disk for its data.
   */
  OS,

  /**
   * Kubelet will use the temporary disk for its data.
   */
  Temporary,
}

/**
 * Determines the type of workload a node can run.
 */
enum WorkloadRuntime {
  /**
   * Nodes will use Kubelet to run standard OCI container workloads.
   */
  OCIContainer,

  /**
   * Nodes will use Krustlet to run WASM workloads using the WASI provider (Preview).
   */
  WasmWasi,
}

/**
 * The operating system type. The default is Linux.
 */
enum OSType {
  /**
   * Use Linux.
   */
  Linux,

  /**
   * Use Windows.
   */
  Windows,
}

/**
 * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
 */
enum OSSku {
  /**
   * Use Ubuntu as the OS for node images.
   */
  Ubuntu,

  /**
   * Use AzureLinux as the OS for node images. Azure Linux is a container-optimized Linux distro built by Microsoft, visit https://aka.ms/azurelinux for more information.
   */
  AzureLinux,

  /**
   * Deprecated OSSKU. Microsoft recommends that new deployments choose 'AzureLinux' instead.
   */
  CBLMariner,

  /**
   * Use Windows2019 as the OS for node images. Unsupported for system node pools. Windows2019 only supports Windows2019 containers; it cannot run Windows2022 containers and vice versa.
   */
  Windows2019,

  /**
   * Use Windows2022 as the OS for node images. Unsupported for system node pools. Windows2022 only supports Windows2022 containers; it cannot run Windows2019 containers and vice versa.
   */
  Windows2022,
}

/**
 * Describes how VMs are added to or removed from Agent Pools. See [billing states](https://docs.microsoft.com/azure/virtual-machines/states-billing).
 */
enum ScaleDownMode {
  /**
   * Create new instances during scale up and remove instances during scale down.
   */
  Delete,

  /**
   * Attempt to start deallocated instances (if they exist) during scale up and deallocate instances during scale down.
   */
  Deallocate,
}

/**
 * The type of Agent Pool.
 */
enum AgentPoolType {
  /**
   * Create an Agent Pool backed by a Virtual Machine Scale Set.
   */
  VirtualMachineScaleSets,

  /**
   * Use of this is strongly discouraged.
   */
  AvailabilitySet,
}

/**
 * A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools
 */
enum AgentPoolMode {
  /**
   * System agent pools are primarily for hosting critical system pods such as CoreDNS and metrics-server. System agent pools osType must be Linux. System agent pools VM SKU must have at least 2vCPUs and 4GB of memory.
   */
  System,

  /**
   * User agent pools are primarily for hosting your application pods.
   */
  User,
}

/**
 * The Virtual Machine Scale Set priority.
 */
enum ScaleSetPriority {
  /**
   * Spot priority VMs will be used. There is no SLA for spot nodes. See [spot on AKS](https://docs.microsoft.com/azure/aks/spot-node-pool) for more information.
   */
  Spot,

  /**
   * Regular VMs will be used.
   */
  Regular,
}

/**
 * The eviction policy specifies what to do with the VM when it is evicted. The default is Delete. For more information about eviction see [spot VMs](https://docs.microsoft.com/azure/virtual-machines/spot-vms)
 */
enum ScaleSetEvictionPolicy {
  /**
   * Nodes in the underlying Scale Set of the node pool are deleted when they're evicted.
   */
  Delete,

  /**
   * Nodes in the underlying Scale Set of the node pool are set to the stopped-deallocated state upon eviction. Nodes in the stopped-deallocated state count against your compute quota and can cause issues with cluster scaling or upgrading.
   */
  Deallocate,
}

/**
 * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
 */
enum GPUInstanceProfile {
  MIG1g,
  MIG2g,
  MIG3g,
  MIG4g,
  MIG7g,
}

/**
 * The network protocol of the port.
 */
enum Protocol {
  /**
   * TCP protocol.
   */
  TCP,

  /**
   * UDP protocol.
   */
  UDP,
}

/**
 * The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.
 */
enum LicenseType {
  /**
   * No additional licensing is applied.
   */
  None,

  /**
   * Enables Azure Hybrid User Benefits for Windows VMs.
   */
  Windows_Server,
}

/**
 * The current provisioning state of the pod identity.
 */
enum ManagedClusterPodIdentityProvisioningState {
  Assigned,
  Canceled,
  Deleting,
  Failed,
  Succeeded,
  Updating,
}

/**
 * Network plugin used for building the Kubernetes network.
 */
enum NetworkPlugin {
  /**
   * Use the Azure CNI network plugin. See [Azure CNI (advanced) networking](https://docs.microsoft.com/azure/aks/concepts-network#azure-cni-advanced-networking) for more information.
   */
  azure,

  /**
   * Use the Kubenet network plugin. See [Kubenet (basic) networking](https://docs.microsoft.com/azure/aks/concepts-network#kubenet-basic-networking) for more information.
   */
  kubenet,

  /**
   * No CNI plugin is pre-installed. See [BYO CNI](https://docs.microsoft.com/en-us/azure/aks/use-byo-cni) for more information.
   */
  none,
}

/**
 * The mode the network plugin should use.
 */
enum NetworkPluginMode {
  /**
   * Used with networkPlugin=azure, pods are given IPs from the PodCIDR address space but use Azure Routing Domains rather than Kubenet's method of route tables. For more information visit https://aka.ms/aks/azure-cni-overlay.
   */
  overlay,
}

/**
 * Network policy used for building the Kubernetes network.
 */
enum NetworkPolicy {
  /**
   * Use Calico network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.
   */
  calico,

  /**
   * Use Azure network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.
   */
  azure,

  /**
   * Use Cilium to enforce network policies. This requires networkDataplane to be 'cilium'.
   */
  cilium,
}

/**
 * This cannot be specified if networkPlugin is anything other than 'azure'.
 */
enum NetworkMode {
  /**
   * No bridge is created. Intra-VM Pod to Pod communication is through IP routes created by Azure CNI. See [Transparent Mode](https://docs.microsoft.com/azure/aks/faq#transparent-mode) for more information.
   */
  transparent,

  /**
   * This is no longer supported
   */
  bridge,
}

/**
 * Network dataplane used in the Kubernetes cluster.
 */
enum NetworkDataplane {
  /**
   * Use Azure network dataplane.
   */
  azure,

  /**
   * Use Cilium network dataplane. See [Azure CNI Powered by Cilium](https://learn.microsoft.com/azure/aks/azure-cni-powered-by-cilium) for more information.
   */
  cilium,
}

/**
 * This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).
 */
enum OutboundType {
  /**
   * The load balancer is used for egress through an AKS assigned public IP. This supports Kubernetes services of type 'loadBalancer'. For more information see [outbound type loadbalancer](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer).
   */
  loadBalancer,

  /**
   * Egress paths must be defined by the user. This is an advanced scenario and requires proper network configuration. For more information see [outbound type userDefinedRouting](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting).
   */
  userDefinedRouting,

  /**
   * The AKS-managed NAT gateway is used for egress.
   */
  managedNATGateway,

  /**
   * The user-assigned NAT gateway associated to the cluster subnet is used for egress. This is an advanced scenario and requires proper network configuration.
   */
  userAssignedNATGateway,
}

/**
 * The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.
 */
enum LoadBalancerSku {
  /**
   * Use a a standard Load Balancer. This is the recommended Load Balancer SKU. For more information about on working with the load balancer in the managed cluster, see the [standard Load Balancer](https://docs.microsoft.com/azure/aks/load-balancer-standard) article.
   */
  standard,

  /**
   * Use a basic Load Balancer with limited functionality.
   */
  basic,
}

/**
 * The type of the managed inbound Load Balancer BackendPool.
 */
enum BackendPoolType {
  /**
   * The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.
   */
  NodeIPConfiguration,

  /**
   * The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.
   */
  NodeIP,
}

/**
 * The IP version to use for cluster networking and IP assignment.
 */
enum IpFamily {
  IPv4,
  IPv6,
}

/**
 * For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).
 */
enum UpgradeChannel {
  /**
   * Automatically upgrade the cluster to the latest supported patch release on the latest supported minor version. In cases where the cluster is at a version of Kubernetes that is at an N-2 minor version where N is the latest supported minor version, the cluster first upgrades to the latest supported patch version on N-1 minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster first is upgraded to 1.18.6, then is upgraded to 1.19.1.
   */
  rapid,

  /**
   * Automatically upgrade the cluster to the latest supported patch release on minor version N-1, where N is the latest supported minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.18.6.
   */
  stable,

  /**
   * Automatically upgrade the cluster to the latest supported patch version when it becomes available while keeping the minor version the same. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.17.9.
   */
  patch,

  /**
   * Automatically upgrade the node image to the latest version available. Consider using nodeOSUpgradeChannel instead as that allows you to configure node OS patching separate from Kubernetes version patching
   */
  `node-image`,

  /**
   * Disables auto-upgrades and keeps the cluster at its current version of Kubernetes.
   */
  none,
}

/**
 * Manner in which the OS on your nodes is updated. The default is NodeImage.
 */
enum NodeOSUpgradeChannel {
  /**
   * No attempt to update your machines OS will be made either by OS or by rolling VHDs. This means you are responsible for your security updates
   */
  None,

  /**
   * OS updates will be applied automatically through the OS built-in patching infrastructure. Newly scaled in machines will be unpatched initially and will be patched at some point by the OS's infrastructure. Behavior of this option depends on the OS in question. Ubuntu and Mariner apply security patches through unattended upgrade roughly once a day around 06:00 UTC. Windows does not apply security patches automatically and so for them this option is equivalent to None till further notice
   */
  Unmanaged,

  /**
   * AKS will update the nodes with a newly patched VHD containing security fixes and bugfixes on a weekly cadence. With the VHD update machines will be rolling reimaged to that VHD following maintenance windows and surge settings. No extra VHD cost is incurred when choosing this option as AKS hosts the images.
   */
  NodeImage,
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
 * Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.
 */
enum KeyVaultNetworkAccessTypes {
  Public,
  Private,
}

/**
 * Allow or deny public network access for AKS
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Mode of the service mesh.
 */
enum ServiceMeshMode {
  /**
   * Istio deployed as an AKS addon.
   */
  Istio,

  /**
   * Mesh is disabled.
   */
  Disabled,
}

/**
 * Mode of an ingress gateway.
 */
enum IstioIngressGatewayMode {
  /**
   * The ingress gateway is assigned a public IP address and is publicly accessible.
   */
  External,

  /**
   * The ingress gateway is assigned an internal IP address and cannot is accessed publicly.
   */
  Internal,
}

enum Format {
  /**
   * Return azure auth-provider kubeconfig. This format is deprecated in v1.22 and will be fully removed in v1.26. See: https://aka.ms/k8s/changes-1-26.
   */
  azure,

  /**
   * Return exec format kubeconfig. This format requires kubelogin binary in the path.
   */
  exec,
}

/**
 * The weekday enum.
 */
enum WeekDay {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * Specifies on which week of the month the dayOfWeek applies.
 */
enum Type {
  /**
   * First week of the month.
   */
  First,

  /**
   * Second week of the month.
   */
  Second,

  /**
   * Third week of the month.
   */
  Third,

  /**
   * Fourth week of the month.
   */
  Fourth,

  /**
   * Last week of the month.
   */
  Last,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Canceled,
  Creating,
  Deleting,
  Failed,
  Succeeded,
}

/**
 * The private link service connection status.
 */
enum ConnectionStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * The type of a snapshot. The default is NodePool.
 */
enum SnapshotType {
  /**
   * The snapshot is a snapshot of a node pool.
   */
  NodePool,
}

/**
 * The current provisioning state of trusted access role binding.
 */
enum TrustedAccessRoleBindingProvisioningState {
  Canceled,
  Deleting,
  Failed,
  Succeeded,
  Updating,
}

/**
 * For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).
 */
@fixed
enum ResourceIdentityType {
  /**
   * Use an implicitly created system assigned managed identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the system assigned managed identity to manipulate Azure resources.
   */
  SystemAssigned,

  /**
   * Use a user-specified identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the specified user assigned managed identity to manipulate Azure resources.
   */
  UserAssigned,

  /**
   * Do not use a managed identity for the Managed Cluster, service principal will be used instead.
   */
  None,
}

/**
 * Describes the properties of a Operation value.
 */
model OperationValue {
  /**
   * The origin of the operation.
   */
  @visibility("read")
  origin?: string;

  /**
   * The name of the operation.
   */
  @visibility("read")
  name?: string;

  /**
   * Describes the properties of a Operation Value Display.
   */
  @extension("x-ms-client-flatten", true)
  display?: OperationValueDisplay;
}

/**
 * Describes the properties of a Operation Value Display.
 */
model OperationValueDisplay {
  /**
   * The display name of the operation.
   */
  @visibility("read")
  operation?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility("read")
  resource?: string;

  /**
   * The description of the operation.
   */
  @visibility("read")
  description?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility("read")
  provider?: string;
}

/**
 * An error response from the Container service.
 */
@error
model CloudError {
  /**
   * Details about the error.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Container service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * The list of OS option properties.
 */
model OSOptionPropertyList {
  /**
   * The list of OS options.
   */
  osOptionPropertyList: OSOptionProperty[];
}

/**
 * OS option property.
 */
model OSOptionProperty {
  /**
   * The OS type.
   */
  @projectedName("json", "os-type")
  osType: string;

  /**
   * Whether the image is FIPS-enabled.
   */
  @projectedName("json", "enable-fips-image")
  enableFipsImage: boolean;
}

/**
 * Hold values properties, which is array of KubernetesVersion
 */
model KubernetesVersionListResult {
  /**
   * Array of AKS supported Kubernetes versions.
   */
  values?: KubernetesVersion[];
}

/**
 * Kubernetes version profile for given major.minor release.
 */
model KubernetesVersion {
  /**
   * major.minor version of Kubernetes release
   */
  version?: string;

  /**
   * Capabilities on this Kubernetes version.
   */
  capabilities?: KubernetesVersionCapabilities;

  /**
   * Whether this version is in preview mode.
   */
  isPreview?: boolean;

  /**
   * Patch versions of Kubernetes release
   */
  patchVersions?: Record<KubernetesPatchVersion>;
}

/**
 * Capabilities on this Kubernetes version.
 */
model KubernetesVersionCapabilities {
  supportPlan?: KubernetesSupportPlan[];
}

/**
 * Kubernetes patch version profile
 */
model KubernetesPatchVersion {
  /**
   * Possible upgrade path for given patch version
   */
  upgrades?: string[];
}

/**
 * The SKU of a Managed Cluster.
 */
model ManagedClusterSKU {
  /**
   * The name of a managed cluster SKU.
   */
  name?: ManagedClusterSKUName;

  /**
   * If not specified, the default is 'Free'. See [AKS Pricing Tier](https://learn.microsoft.com/azure/aks/free-standard-pricing-tiers) for more details.
   */
  tier?: ManagedClusterSKUTier;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * Identity for the managed cluster.
 */
model ManagedClusterIdentity {
  /**
   * The principal id of the system assigned identity which is used by master components.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id of the system assigned identity which is used by master components.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).
   */
  type?: ResourceIdentityType;

  /**
   * The delegated identity resources assigned to this managed cluster. This can only be set by another Azure Resource Provider, and managed cluster only accept one delegated identity resource. Internal use only.
   */
  delegatedResources?: Record<DelegatedResource>;

  /**
   * The keys must be ARM resource IDs in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<ManagedServiceIdentityUserAssignedIdentitiesValue>;
}

/**
 * Delegated resource properties - internal use only.
 */
model DelegatedResource {
  /**
   * The ARM resource id of the delegated resource - internal use only.
   */
  resourceId?: string;

  /**
   * The tenant id of the delegated resource - internal use only.
   */
  tenantId?: string;

  /**
   * The delegation id of the referral delegation (optional) - internal use only.
   */
  referralResource?: string;

  /**
   * The source resource location - internal use only.
   */
  location?: string;
}

model ManagedServiceIdentityUserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Properties of the managed cluster.
 */
model ManagedClusterProperties {
  /**
   * The current provisioning state.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The Power State of the cluster.
   */
  @visibility("read")
  powerState?: PowerState;

  /**
   * The max number of agent pools for the managed cluster.
   */
  @visibility("read")
  maxAgentPools?: int32;

  /**
   * Both patch version <major.minor.patch> (e.g. 1.20.13) and <major.minor> (e.g. 1.20) are supported. When <major.minor> is specified, the latest supported GA patch version is chosen automatically. Updating the cluster with the same <major.minor> once it has been created (e.g. 1.14.x -> 1.14) will not trigger an upgrade, even if a newer patch version is available. When you upgrade a supported AKS cluster, Kubernetes minor versions cannot be skipped. All upgrades must be performed sequentially by major version number. For example, upgrades between 1.14.x -> 1.15.x or 1.15.x -> 1.16.x are allowed, however 1.14.x -> 1.16.x is not allowed. See [upgrading an AKS cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster) for more details.
   */
  kubernetesVersion?: string;

  /**
   * If kubernetesVersion was a fully specified version <major.minor.patch>, this field will be exactly equal to it. If kubernetesVersion was <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility("read")
  currentKubernetesVersion?: string;

  /**
   * This cannot be updated once the Managed Cluster has been created.
   */
  dnsPrefix?: string;

  /**
   * This cannot be updated once the Managed Cluster has been created.
   */
  fqdnSubdomain?: string;

  /**
   * The FQDN of the master pool.
   */
  @visibility("read")
  fqdn?: string;

  /**
   * The FQDN of private cluster.
   */
  @visibility("read")
  @projectedName("json", "privateFQDN")
  privateFqdn?: string;

  /**
   * The Azure Portal requires certain Cross-Origin Resource Sharing (CORS) headers to be sent in some responses, which Kubernetes APIServer doesn't handle by default. This special FQDN supports CORS, allowing the Azure Portal to function properly.
   */
  @visibility("read")
  @projectedName("json", "azurePortalFQDN")
  azurePortalFqdn?: string;

  /**
   * The agent pool properties.
   */
  agentPoolProfiles?: ManagedClusterAgentPoolProfile[];

  /**
   * The profile for Linux VMs in the Managed Cluster.
   */
  linuxProfile?: ContainerServiceLinuxProfile;

  /**
   * The profile for Windows VMs in the Managed Cluster.
   */
  windowsProfile?: ManagedClusterWindowsProfile;

  /**
   * Information about a service principal identity for the cluster to use for manipulating Azure APIs.
   */
  servicePrincipalProfile?: ManagedClusterServicePrincipalProfile;

  /**
   * The profile of managed cluster add-on.
   */
  addonProfiles?: Record<ManagedClusterAddonProfile>;

  /**
   * See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on AAD pod identity integration.
   */
  podIdentityProfile?: ManagedClusterPodIdentityProfile;

  /**
   * The OIDC issuer profile of the Managed Cluster.
   */
  oidcIssuerProfile?: ManagedClusterOidcIssuerProfile;

  /**
   * The name of the resource group containing agent pool nodes.
   */
  nodeResourceGroup?: string;

  /**
   * Whether to enable Kubernetes Role-Based Access Control.
   */
  @projectedName("json", "enableRBAC")
  enableRbac?: boolean;

  /**
   * The support plan for the Managed Cluster. If unspecified, the default is 'KubernetesOfficial'.
   */
  supportPlan?: KubernetesSupportPlan;

  /**
   * (DEPRECATED) Whether to enable Kubernetes pod security policy (preview). PodSecurityPolicy was deprecated in Kubernetes v1.21, and removed from Kubernetes in v1.25. Learn more at https://aka.ms/k8s/psp and https://aka.ms/aks/psp.
   */
  enablePodSecurityPolicy?: boolean;

  /**
   * The network configuration profile.
   */
  networkProfile?: ContainerServiceNetworkProfile;

  /**
   * The Azure Active Directory configuration.
   */
  aadProfile?: ManagedClusterAADProfile;

  /**
   * The auto upgrade configuration.
   */
  autoUpgradeProfile?: ManagedClusterAutoUpgradeProfile;

  /**
   * Settings for upgrading a cluster.
   */
  upgradeSettings?: ClusterUpgradeSettings;

  /**
   * Parameters to be applied to the cluster-autoscaler when enabled
   */
  autoScalerProfile?: ManagedClusterPropertiesAutoScalerProfile;

  /**
   * The access profile for managed cluster API server.
   */
  apiServerAccessProfile?: ManagedClusterAPIServerAccessProfile;

  /**
   * This is of the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/diskEncryptionSets/{encryptionSetName}'
   */
  diskEncryptionSetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/diskEncryptionSets";
    }
  ]>;

  /**
   * Identities associated with the cluster.
   */
  identityProfile?: Record<UserAssignedIdentity>;

  /**
   * Private link resources associated with the cluster.
   */
  privateLinkResources?: PrivateLinkResource[];

  /**
   * If set to true, getting static credentials will be disabled for this cluster. This must only be used on Managed Clusters that are AAD enabled. For more details see [disable local accounts](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts-preview).
   */
  disableLocalAccounts?: boolean;

  /**
   * Configurations for provisioning the cluster with HTTP proxy servers.
   */
  httpProxyConfig?: ManagedClusterHttpProxyConfig;

  /**
   * Security profile for the managed cluster.
   */
  securityProfile?: ManagedClusterSecurityProfile;

  /**
   * Storage profile for the managed cluster.
   */
  storageProfile?: ManagedClusterStorageProfile;

  /**
   * Allow or deny public network access for AKS
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Workload Auto-scaler profile for the managed cluster.
   */
  workloadAutoScalerProfile?: ManagedClusterWorkloadAutoScalerProfile;

  /**
   * Azure Monitor addon profiles for monitoring the managed cluster.
   */
  azureMonitorProfile?: ManagedClusterAzureMonitorProfile;

  /**
   * Service mesh profile for a managed cluster.
   */
  serviceMeshProfile?: ServiceMeshProfile;

  /**
   * The resourceUID uniquely identifies ManagedClusters that reuse ARM ResourceIds (i.e: create, delete, create sequence)
   */
  @visibility("read")
  resourceUID?: string;
}

/**
 * Describes the Power State of the cluster
 */
model PowerState {
  /**
   * Tells whether the cluster is Running or Stopped
   */
  code?: Code;
}

/**
 * Profile for the container service agent pool.
 */
model ManagedClusterAgentPoolProfile
  extends ManagedClusterAgentPoolProfileProperties {
  /**
   * Windows agent pool names must be 6 characters or less.
   */
  @pattern("^[a-z][a-z0-9]{0,11}$")
  name: string;
}

/**
 * Properties for the container service agent pool profile.
 */
model ManagedClusterAgentPoolProfileProperties {
  /**
   * Number of agents (VMs) to host docker containers. Allowed values must be in the range of 0 to 1000 (inclusive) for user pools and in the range of 1 to 1000 (inclusive) for system pools. The default value is 1.
   */
  count?: int32;

  /**
   * VM size availability varies by region. If a node contains insufficient compute resources (memory, cpu, etc) pods might fail to run correctly. For more details on restricted VM sizes, see: https://docs.microsoft.com/azure/aks/quotas-skus-regions
   */
  vmSize?: string;

  /**
   * OS Disk Size in GB to be used to specify the disk size for every machine in the master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.
   */
  @maxValue(2048)
  @projectedName("json", "osDiskSizeGB")
  OSDiskSizeInGB?: int32;

  /**
   * The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
   */
  osDiskType?: OSDiskType;

  /**
   * Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.
   */
  kubeletDiskType?: KubeletDiskType;

  /**
   * Determines the type of workload a node can run.
   */
  workloadRuntime?: WorkloadRuntime;

  /**
   * If this is not specified, a VNET and subnet will be generated and used. If no podSubnetID is specified, this applies to nodes and pods, otherwise it applies to just nodes. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  vnetSubnetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  podSubnetID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The maximum number of pods that can run on a node.
   */
  maxPods?: int32;

  /**
   * The operating system type. The default is Linux.
   */
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
   */
  osSKU?: OSSku;

  /**
   * The maximum number of nodes for auto-scaling
   */
  maxCount?: int32;

  /**
   * The minimum number of nodes for auto-scaling
   */
  minCount?: int32;

  /**
   * Whether to enable auto-scaler
   */
  enableAutoScaling?: boolean;

  /**
   * This also effects the cluster autoscaler behavior. If not specified, it defaults to Delete.
   */
  scaleDownMode?: ScaleDownMode;

  /**
   * The type of Agent Pool.
   */
  type?: AgentPoolType;

  /**
   * A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools
   */
  mode?: AgentPoolMode;

  /**
   * Both patch version <major.minor.patch> (e.g. 1.20.13) and <major.minor> (e.g. 1.20) are supported. When <major.minor> is specified, the latest supported GA patch version is chosen automatically. Updating the cluster with the same <major.minor> once it has been created (e.g. 1.14.x -> 1.14) will not trigger an upgrade, even if a newer patch version is available. As a best practice, you should upgrade all node pools in an AKS cluster to the same Kubernetes version. The node pool version must have the same major version as the control plane. The node pool minor version must be within two minor versions of the control plane version. The node pool version cannot be greater than the control plane version. For more information see [upgrading a node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#upgrade-a-node-pool).
   */
  orchestratorVersion?: string;

  /**
   * If orchestratorVersion is a fully specified version <major.minor.patch>, this field will be exactly equal to it. If orchestratorVersion is <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility("read")
  currentOrchestratorVersion?: string;

  /**
   * The version of node image
   */
  @visibility("read")
  nodeImageVersion?: string;

  /**
   * Settings for upgrading the agentpool
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * The current deployment or provisioning state.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * When an Agent Pool is first created it is initially Running. The Agent Pool can be stopped by setting this field to Stopped. A stopped Agent Pool stops all of its VMs and does not accrue billing charges. An Agent Pool can only be stopped if it is Running and provisioning state is Succeeded
   */
  powerState?: PowerState;

  /**
   * The list of Availability zones to use for nodes. This can only be specified if the AgentPoolType property is 'VirtualMachineScaleSets'.
   */
  availabilityZones?: string[];

  /**
   * Some scenarios may require nodes in a node pool to receive their own dedicated public IP addresses. A common scenario is for gaming workloads, where a console needs to make a direct connection to a cloud virtual machine to minimize hops. For more information see [assigning a public IP per node](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#assign-a-public-ip-per-node-for-your-node-pools). The default is false.
   */
  enableNodePublicIP?: boolean;

  /**
   * This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}
   */
  nodePublicIPPrefixID?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * The Virtual Machine Scale Set priority. If not specified, the default is 'Regular'.
   */
  scaleSetPriority?: ScaleSetPriority = ScaleSetPriority.Regular;

  /**
   * This cannot be specified unless the scaleSetPriority is 'Spot'. If not specified, the default is 'Delete'.
   */
  scaleSetEvictionPolicy?: ScaleSetEvictionPolicy = ScaleSetEvictionPolicy.Delete;

  /**
   * Possible values are any decimal value greater than zero or -1 which indicates the willingness to pay any on-demand price. For more details on spot pricing, see [spot VMs pricing](https://docs.microsoft.com/azure/virtual-machines/spot-vms#pricing)
   */
  spotMaxPrice?: float32 = -1;

  /**
   * The tags to be persisted on the agent pool virtual machine scale set.
   */
  tags?: Record<string>;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
  nodeLabels?: Record<string>;

  /**
   * The taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * The ID for Proximity Placement Group.
   */
  proximityPlacementGroupID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/proximityPlacementGroups";
    }
  ]>;

  /**
   * The Kubelet configuration on the agent pool nodes.
   */
  kubeletConfig?: KubeletConfig;

  /**
   * The OS configuration of Linux agent nodes.
   */
  linuxOSConfig?: LinuxOSConfig;

  /**
   * This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption
   */
  enableEncryptionAtHost?: boolean;

  /**
   * Whether to enable UltraSSD
   */
  enableUltraSSD?: boolean;

  /**
   * See [Add a FIPS-enabled node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview) for more details.
   */
  @projectedName("json", "enableFIPS")
  enableFips?: boolean;

  /**
   * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
   */
  gpuInstanceProfile?: GPUInstanceProfile;

  /**
   * CreationData to be used to specify the source Snapshot ID if the node pool will be created/upgraded using a snapshot.
   */
  creationData?: CreationData;

  /**
   * AKS will associate the specified agent pool with the Capacity Reservation Group.
   */
  capacityReservationGroupID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/CapacityReservationGroups";
    }
  ]>;

  /**
   * This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}. For more information see [Azure dedicated hosts](https://docs.microsoft.com/azure/virtual-machines/dedicated-hosts).
   */
  hostGroupID?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/hostGroups";
    }
  ]>;

  /**
   * Network-related settings of an agent pool.
   */
  networkProfile?: AgentPoolNetworkProfile;
}

/**
 * Settings for upgrading an agentpool
 */
model AgentPoolUpgradeSettings {
  /**
   * This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 1. For more information, including best practices, see: https://docs.microsoft.com/azure/aks/upgrade-cluster#customize-node-surge-upgrade
   */
  maxSurge?: string;

  /**
   * The amount of time (in minutes) to wait on eviction of pods and graceful termination per node. This eviction wait time honors waiting on pod disruption budgets. If this time is exceeded, the upgrade fails. If not specified, the default is 30 minutes.
   */
  @maxValue(1440)
  @minValue(1)
  drainTimeoutInMinutes?: int32;
}

/**
 * See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.
 */
model KubeletConfig {
  /**
   * The default is 'none'. See [Kubernetes CPU management policies](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#cpu-management-policies) for more information. Allowed values are 'none' and 'static'.
   */
  cpuManagerPolicy?: string;

  /**
   * The default is true.
   */
  cpuCfsQuota?: boolean;

  /**
   * The default is '100ms.' Valid values are a sequence of decimal numbers with an optional fraction and a unit suffix. For example: '300ms', '2h45m'. Supported units are 'ns', 'us', 'ms', 's', 'm', and 'h'.
   */
  cpuCfsQuotaPeriod?: string;

  /**
   * To disable image garbage collection, set to 100. The default is 85%
   */
  imageGcHighThreshold?: int32;

  /**
   * This cannot be set higher than imageGcHighThreshold. The default is 80%
   */
  imageGcLowThreshold?: int32;

  /**
   * For more information see [Kubernetes Topology Manager](https://kubernetes.io/docs/tasks/administer-cluster/topology-manager). The default is 'none'. Allowed values are 'none', 'best-effort', 'restricted', and 'single-numa-node'.
   */
  topologyManagerPolicy?: string;

  /**
   * Allowed list of unsafe sysctls or unsafe sysctl patterns (ending in `*`).
   */
  allowedUnsafeSysctls?: string[];

  /**
   * If set to true it will make the Kubelet fail to start if swap is enabled on the node.
   */
  failSwapOn?: boolean;

  /**
   * The maximum size (e.g. 10Mi) of container log file before it is rotated.
   */
  containerLogMaxSizeMB?: int32;

  /**
   * The maximum number of container log files that can be present for a container. The number must be ≥ 2.
   */
  @minValue(2)
  containerLogMaxFiles?: int32;

  /**
   * The maximum number of processes per pod.
   */
  podMaxPids?: int32;
}

/**
 * See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.
 */
model LinuxOSConfig {
  /**
   * Sysctl settings for Linux agent nodes.
   */
  sysctls?: SysctlConfig;

  /**
   * Valid values are 'always', 'madvise', and 'never'. The default is 'always'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).
   */
  transparentHugePageEnabled?: string;

  /**
   * Valid values are 'always', 'defer', 'defer+madvise', 'madvise' and 'never'. The default is 'madvise'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).
   */
  transparentHugePageDefrag?: string;

  /**
   * The size in MB of a swap file that will be created on each node.
   */
  swapFileSizeMB?: int32;
}

/**
 * Sysctl settings for Linux agent nodes.
 */
model SysctlConfig {
  /**
   * Sysctl setting net.core.somaxconn.
   */
  netCoreSomaxconn?: int32;

  /**
   * Sysctl setting net.core.netdev_max_backlog.
   */
  netCoreNetdevMaxBacklog?: int32;

  /**
   * Sysctl setting net.core.rmem_default.
   */
  netCoreRmemDefault?: int32;

  /**
   * Sysctl setting net.core.rmem_max.
   */
  netCoreRmemMax?: int32;

  /**
   * Sysctl setting net.core.wmem_default.
   */
  netCoreWmemDefault?: int32;

  /**
   * Sysctl setting net.core.wmem_max.
   */
  netCoreWmemMax?: int32;

  /**
   * Sysctl setting net.core.optmem_max.
   */
  netCoreOptmemMax?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_max_syn_backlog.
   */
  netIpv4TcpMaxSynBacklog?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_max_tw_buckets.
   */
  netIpv4TcpMaxTwBuckets?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_fin_timeout.
   */
  netIpv4TcpFinTimeout?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_keepalive_time.
   */
  netIpv4TcpKeepaliveTime?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_keepalive_probes.
   */
  netIpv4TcpKeepaliveProbes?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_keepalive_intvl.
   */
  @maxValue(90)
  @minValue(10)
  netIpv4TcpkeepaliveIntvl?: int32;

  /**
   * Sysctl setting net.ipv4.tcp_tw_reuse.
   */
  netIpv4TcpTwReuse?: boolean;

  /**
   * Sysctl setting net.ipv4.ip_local_port_range.
   */
  netIpv4IpLocalPortRange?: string;

  /**
   * Sysctl setting net.ipv4.neigh.default.gc_thresh1.
   */
  netIpv4NeighDefaultGcThresh1?: int32;

  /**
   * Sysctl setting net.ipv4.neigh.default.gc_thresh2.
   */
  netIpv4NeighDefaultGcThresh2?: int32;

  /**
   * Sysctl setting net.ipv4.neigh.default.gc_thresh3.
   */
  netIpv4NeighDefaultGcThresh3?: int32;

  /**
   * Sysctl setting net.netfilter.nf_conntrack_max.
   */
  @maxValue(2097152)
  @minValue(131072)
  netNetfilterNfConntrackMax?: int32;

  /**
   * Sysctl setting net.netfilter.nf_conntrack_buckets.
   */
  @maxValue(524288)
  @minValue(65536)
  netNetfilterNfConntrackBuckets?: int32;

  /**
   * Sysctl setting fs.inotify.max_user_watches.
   */
  fsInotifyMaxUserWatches?: int32;

  /**
   * Sysctl setting fs.file-max.
   */
  fsFileMax?: int32;

  /**
   * Sysctl setting fs.aio-max-nr.
   */
  fsAioMaxNr?: int32;

  /**
   * Sysctl setting fs.nr_open.
   */
  fsNrOpen?: int32;

  /**
   * Sysctl setting kernel.threads-max.
   */
  kernelThreadsMax?: int32;

  /**
   * Sysctl setting vm.max_map_count.
   */
  vmMaxMapCount?: int32;

  /**
   * Sysctl setting vm.swappiness.
   */
  vmSwappiness?: int32;

  /**
   * Sysctl setting vm.vfs_cache_pressure.
   */
  vmVfsCachePressure?: int32;
}

/**
 * Data used when creating a target resource from a source resource.
 */
model CreationData {
  /**
   * This is the ARM ID of the source object to be used to create the target object.
   */
  sourceResourceId?: ResourceIdentifier;
}

/**
 * Network settings of an agent pool.
 */
model AgentPoolNetworkProfile {
  /**
   * IPTags of instance-level public IPs.
   */
  nodePublicIPTags?: IPTag[];

  /**
   * The port ranges that are allowed to access. The specified ranges are allowed to overlap.
   */
  allowedHostPorts?: PortRange[];

  /**
   * The IDs of the application security groups which agent pool will associate when created.
   */
  applicationSecurityGroups?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationSecurityGroups";
    }
  ]>[];
}

/**
 * Contains the IPTag associated with the object.
 */
model IPTag {
  /**
   * The IP tag type. Example: RoutingPreference.
   */
  ipTagType?: string;

  /**
   * The value of the IP tag associated with the public IP. Example: Internet.
   */
  tag?: string;
}

/**
 * The port range.
 */
model PortRange {
  /**
   * The minimum port that is included in the range. It should be ranged from 1 to 65535, and be less than or equal to portEnd.
   */
  @maxValue(65535)
  @minValue(1)
  portStart?: int32;

  /**
   * The maximum port that is included in the range. It should be ranged from 1 to 65535, and be greater than or equal to portStart.
   */
  @maxValue(65535)
  @minValue(1)
  portEnd?: int32;

  /**
   * The network protocol of the port.
   */
  protocol?: Protocol;
}

/**
 * Profile for Linux VMs in the container service cluster.
 */
model ContainerServiceLinuxProfile {
  /**
   * The administrator username to use for Linux VMs.
   */
  @pattern("^[A-Za-z][-A-Za-z0-9_]*$")
  adminUsername: string;

  /**
   * The SSH configuration for Linux-based VMs running on Azure.
   */
  ssh: ContainerServiceSshConfiguration;
}

/**
 * SSH configuration for Linux-based VMs running on Azure.
 */
model ContainerServiceSshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with Linux-based VMs. A maximum of 1 key may be specified.
   */
  publicKeys: ContainerServiceSshPublicKey[];
}

/**
 * Contains information about SSH certificate public key data.
 */
model ContainerServiceSshPublicKey {
  /**
   * Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.
   */
  keyData: string;
}

/**
 * Profile for Windows VMs in the managed cluster.
 */
model ManagedClusterWindowsProfile {
  /**
   * Specifies the name of the administrator account. <br><br> **Restriction:** Cannot end in "." <br><br> **Disallowed values:** "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5". <br><br> **Minimum-length:** 1 character <br><br> **Max-length:** 20 characters
   */
  adminUsername: string;

  /**
   * Specifies the password of the administrator account. <br><br> **Minimum-length:** 8 characters <br><br> **Max-length:** 123 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\W_]) <br><br> **Disallowed values:** "abc@123", "P@$$w0rd", "P@ssw0rd", "P@ssword123", "Pa$$word", "pass@word1", "Password!", "Password1", "Password22", "iloveyou!"
   */
  adminPassword?: string;

  /**
   * The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.
   */
  licenseType?: LicenseType;

  /**
   * For more details on CSI proxy, see the [CSI proxy GitHub repo](https://github.com/kubernetes-csi/csi-proxy).
   */
  @projectedName("json", "enableCSIProxy")
  IsCsiProxyEnabled?: boolean;

  /**
   * The Windows gMSA Profile in the Managed Cluster.
   */
  gmsaProfile?: WindowsGmsaProfile;
}

/**
 * Windows gMSA Profile in the managed cluster.
 */
model WindowsGmsaProfile {
  /**
   * Specifies whether to enable Windows gMSA in the managed cluster.
   */
  enabled?: boolean;

  /**
   * Specifies the DNS server for Windows gMSA. <br><br> Set it to empty if you have configured the DNS server in the vnet which is used to create the managed cluster.
   */
  dnsServer?: string;

  /**
   * Specifies the root domain name for Windows gMSA. <br><br> Set it to empty if you have configured the DNS server in the vnet which is used to create the managed cluster.
   */
  rootDomainName?: string;
}

/**
 * Information about a service principal identity for the cluster to use for manipulating Azure APIs.
 */
model ManagedClusterServicePrincipalProfile {
  /**
   * The ID for the service principal.
   */
  clientId: string;

  /**
   * The secret password associated with the service principal in plain text.
   */
  secret?: string;
}

/**
 * A Kubernetes add-on profile for a managed cluster.
 */
model ManagedClusterAddonProfile {
  /**
   * Whether the add-on is enabled or not.
   */
  enabled: boolean;

  /**
   * Key-value pairs for configuring an add-on.
   */
  config?: Record<string>;

  /**
   * Information of user assigned identity used by this add-on.
   */
  @visibility("read")
  identity?: ManagedClusterAddonProfileIdentity;
}

/**
 * Information of user assigned identity used by this add-on.
 */
model ManagedClusterAddonProfileIdentity extends UserAssignedIdentity {}

/**
 * See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on pod identity integration.
 */
model ManagedClusterPodIdentityProfile {
  /**
   * Whether the pod identity addon is enabled.
   */
  enabled?: boolean;

  /**
   * Running in Kubenet is disabled by default due to the security related nature of AAD Pod Identity and the risks of IP spoofing. See [using Kubenet network plugin with AAD Pod Identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity#using-kubenet-network-plugin-with-azure-active-directory-pod-managed-identities) for more information.
   */
  allowNetworkPluginKubenet?: boolean;

  /**
   * The pod identities to use in the cluster.
   */
  userAssignedIdentities?: ManagedClusterPodIdentity[];

  /**
   * The pod identity exceptions to allow.
   */
  userAssignedIdentityExceptions?: ManagedClusterPodIdentityException[];
}

/**
 * Details about the pod identity assigned to the Managed Cluster.
 */
model ManagedClusterPodIdentity {
  /**
   * The name of the pod identity.
   */
  name: string;

  /**
   * The namespace of the pod identity.
   */
  `namespace`: string;

  /**
   * The binding selector to use for the AzureIdentityBinding resource.
   */
  bindingSelector?: string;

  /**
   * The user assigned identity details.
   */
  identity: UserAssignedIdentity;

  /**
   * The current provisioning state of the pod identity.
   */
  @visibility("read")
  provisioningState?: ManagedClusterPodIdentityProvisioningState;

  @visibility("read")
  provisioningInfo?: ManagedClusterPodIdentityProvisioningInfo;
}

model ManagedClusterPodIdentityProvisioningInfo {
  /**
   * Pod identity assignment error (if any).
   */
  error?: ManagedClusterPodIdentityProvisioningError;
}

/**
 * An error response from the pod identity provisioning.
 */
model ManagedClusterPodIdentityProvisioningError {
  /**
   * Details about the error.
   */
  error?: ManagedClusterPodIdentityProvisioningErrorBody;
}

/**
 * An error response from the pod identity provisioning.
 */
model ManagedClusterPodIdentityProvisioningErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: ManagedClusterPodIdentityProvisioningErrorBody[];
}

/**
 * See [disable AAD Pod Identity for a specific Pod/Application](https://azure.github.io/aad-pod-identity/docs/configure/application_exception/) for more details.
 */
model ManagedClusterPodIdentityException {
  /**
   * The name of the pod identity exception.
   */
  name: string;

  /**
   * The namespace of the pod identity exception.
   */
  `namespace`: string;

  /**
   * The pod labels to match.
   */
  podLabels: Record<string>;
}

/**
 * The OIDC issuer profile of the Managed Cluster.
 */
model ManagedClusterOidcIssuerProfile {
  /**
   * The OIDC issuer url of the Managed Cluster.
   */
  @visibility("read")
  issuerURL?: string;

  /**
   * Whether the OIDC issuer is enabled.
   */
  enabled?: boolean;
}

/**
 * Profile of network configuration.
 */
model ContainerServiceNetworkProfile {
  /**
   * Network plugin used for building the Kubernetes network.
   */
  networkPlugin?: NetworkPlugin = NetworkPlugin.kubenet;

  /**
   * The mode the network plugin should use.
   */
  networkPluginMode?: NetworkPluginMode;

  /**
   * Network policy used for building the Kubernetes network.
   */
  networkPolicy?: NetworkPolicy;

  /**
   * This cannot be specified if networkPlugin is anything other than 'azure'.
   */
  networkMode?: NetworkMode;

  /**
   * Network dataplane used in the Kubernetes cluster.
   */
  networkDataplane?: NetworkDataplane;

  /**
   * A CIDR notation IP range from which to assign pod IPs when kubenet is used.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  podCidr?: string = "10.244.0.0/16";

  /**
   * A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges.
   */
  @pattern("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$")
  serviceCidr?: string = "10.0.0.0/16";

  /**
   * An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in serviceCidr.
   */
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string = "10.0.0.10";

  /**
   * This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).
   */
  outboundType?: OutboundType = OutboundType.loadBalancer;

  /**
   * The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.
   */
  loadBalancerSku?: LoadBalancerSku;

  /**
   * Profile of the cluster load balancer.
   */
  loadBalancerProfile?: ManagedClusterLoadBalancerProfile;

  /**
   * Profile of the cluster NAT gateway.
   */
  natGatewayProfile?: ManagedClusterNATGatewayProfile;

  /**
   * One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  podCidrs?: string[];

  /**
   * One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking. They must not overlap with any Subnet IP ranges.
   */
  serviceCidrs?: string[];

  /**
   * IP families are used to determine single-stack or dual-stack clusters. For single-stack, the expected value is IPv4. For dual-stack, the expected values are IPv4 and IPv6.
   */
  ipFamilies?: IpFamily[];
}

/**
 * Profile of the managed cluster load balancer.
 */
model ManagedClusterLoadBalancerProfile {
  /**
   * Desired managed outbound IPs for the cluster load balancer.
   */
  managedOutboundIPs?: ManagedClusterLoadBalancerProfileManagedOutboundIPs;

  /**
   * Desired outbound IP Prefix resources for the cluster load balancer.
   */
  outboundIPPrefixes?: ManagedClusterLoadBalancerProfileOutboundIPPrefixes;

  /**
   * Desired outbound IP resources for the cluster load balancer.
   */
  outboundIPs?: ManagedClusterLoadBalancerProfileOutboundIPs;

  /**
   * The effective outbound IP resources of the cluster load balancer.
   */
  effectiveOutboundIPs?: ResourceReference[];

  /**
   * The desired number of allocated SNAT ports per VM. Allowed values are in the range of 0 to 64000 (inclusive). The default value is 0 which results in Azure dynamically allocating ports.
   */
  @maxValue(64000)
  allocatedOutboundPorts?: int32;

  /**
   * Desired outbound flow idle timeout in minutes. Allowed values are in the range of 4 to 120 (inclusive). The default value is 30 minutes.
   */
  @maxValue(120)
  @minValue(4)
  idleTimeoutInMinutes?: int32 = 30;

  /**
   * Enable multiple standard load balancers per AKS cluster or not.
   */
  enableMultipleStandardLoadBalancers?: boolean;

  /**
   * The type of the managed inbound Load Balancer BackendPool.
   */
  backendPoolType?: BackendPoolType = BackendPoolType.NodeIPConfiguration;
}

/**
 * Desired managed outbound IPs for the cluster load balancer.
 */
model ManagedClusterLoadBalancerProfileManagedOutboundIPs {
  /**
   * The desired number of IPv4 outbound IPs created/managed by Azure for the cluster load balancer. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 1.
   */
  @maxValue(100)
  @minValue(1)
  count?: int32 = 1;

  /**
   * The desired number of IPv6 outbound IPs created/managed by Azure for the cluster load balancer. Allowed values must be in the range of 1 to 100 (inclusive). The default value is 0 for single-stack and 1 for dual-stack.
   */
  @maxValue(100)
  countIPv6?: int32;
}

/**
 * Desired outbound IP Prefix resources for the cluster load balancer.
 */
model ManagedClusterLoadBalancerProfileOutboundIPPrefixes {
  /**
   * A list of public IP prefix resources.
   */
  publicIPPrefixes?: ResourceReference[];
}

/**
 * A reference to an Azure resource.
 */
model ResourceReference {
  /**
   * The fully qualified Azure resource id.
   */
  id?: ResourceIdentifier;
}

/**
 * Desired outbound IP resources for the cluster load balancer.
 */
model ManagedClusterLoadBalancerProfileOutboundIPs {
  /**
   * A list of public IP resources.
   */
  publicIPs?: ResourceReference[];
}

/**
 * Profile of the managed cluster NAT gateway.
 */
model ManagedClusterNATGatewayProfile {
  /**
   * Profile of the managed outbound IP resources of the cluster NAT gateway.
   */
  managedOutboundIPProfile?: ManagedClusterManagedOutboundIPProfile;

  /**
   * The effective outbound IP resources of the cluster NAT gateway.
   */
  effectiveOutboundIPs?: ResourceReference[];

  /**
   * Desired outbound flow idle timeout in minutes. Allowed values are in the range of 4 to 120 (inclusive). The default value is 4 minutes.
   */
  @maxValue(120)
  @minValue(4)
  idleTimeoutInMinutes?: int32 = 4;
}

/**
 * Profile of the managed outbound IP resources of the managed cluster.
 */
model ManagedClusterManagedOutboundIPProfile {
  /**
   * The desired number of outbound IPs created/managed by Azure. Allowed values must be in the range of 1 to 16 (inclusive). The default value is 1.
   */
  @maxValue(16)
  @minValue(1)
  count?: int32 = 1;
}

/**
 * For more details see [managed AAD on AKS](https://docs.microsoft.com/azure/aks/managed-aad).
 */
model ManagedClusterAADProfile {
  /**
   * Whether to enable managed AAD.
   */
  managed?: boolean;

  /**
   * Whether to enable Azure RBAC for Kubernetes authorization.
   */
  @projectedName("json", "enableAzureRBAC")
  enableAzureRbac?: boolean;

  /**
   * The list of AAD group object IDs that will have admin role of the cluster.
   */
  adminGroupObjectIDs?: string[];

  /**
   * (DEPRECATED) The client AAD application ID. Learn more at https://aka.ms/aks/aad-legacy.
   */
  clientAppID?: string;

  /**
   * (DEPRECATED) The server AAD application ID. Learn more at https://aka.ms/aks/aad-legacy.
   */
  serverAppID?: string;

  /**
   * (DEPRECATED) The server AAD application secret. Learn more at https://aka.ms/aks/aad-legacy.
   */
  serverAppSecret?: string;

  /**
   * The AAD tenant ID to use for authentication. If not specified, will use the tenant of the deployment subscription.
   */
  tenantID?: string;
}

/**
 * Auto upgrade profile for a managed cluster.
 */
model ManagedClusterAutoUpgradeProfile {
  /**
   * For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).
   */
  upgradeChannel?: UpgradeChannel;

  /**
   * Manner in which the OS on your nodes is updated. The default is NodeImage.
   */
  nodeOSUpgradeChannel?: NodeOSUpgradeChannel;
}

/**
 * Settings for upgrading a cluster.
 */
model ClusterUpgradeSettings {
  /**
   * Settings for overrides.
   */
  overrideSettings?: UpgradeOverrideSettings;
}

/**
 * Settings for overrides when upgrading a cluster.
 */
model UpgradeOverrideSettings {
  /**
   * Whether to force upgrade the cluster. Note that this option instructs upgrade operation to bypass upgrade protections such as checking for deprecated API usage. Enable this option only with caution.
   */
  forceUpgrade?: boolean;

  /**
   * Until when the overrides are effective. Note that this only matches the start time of an upgrade, and the effectiveness won't change once an upgrade starts even if the `until` expires as upgrade proceeds. This field is not set by default. It must be set for the overrides to take effect.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  until?: utcDateTime;
}

/**
 * Parameters to be applied to the cluster-autoscaler when enabled
 */
model ManagedClusterPropertiesAutoScalerProfile {
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
  scanIntervalInSeconds?: string;

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
 * Access profile for managed cluster API server.
 */
model ManagedClusterAPIServerAccessProfile {
  /**
   * IP ranges are specified in CIDR format, e.g. 137.117.106.88/29. This feature is not compatible with clusters that use Public IP Per Node, or clusters that are using a Basic Load Balancer. For more information see [API server authorized IP ranges](https://docs.microsoft.com/azure/aks/api-server-authorized-ip-ranges).
   */
  authorizedIPRanges?: string[];

  /**
   * For more details, see [Creating a private AKS cluster](https://docs.microsoft.com/azure/aks/private-clusters).
   */
  enablePrivateCluster?: boolean;

  /**
   * The default is System. For more details see [configure private DNS zone](https://docs.microsoft.com/azure/aks/private-clusters#configure-private-dns-zone). Allowed values are 'system' and 'none'.
   */
  privateDNSZone?: string;

  /**
   * Whether to create additional public FQDN for private cluster or not.
   */
  @projectedName("json", "enablePrivateClusterPublicFQDN")
  enablePrivateClusterPublicFqdn?: boolean;

  /**
   * Whether to disable run command for the cluster or not.
   */
  disableRunCommand?: boolean;
}

/**
 * A private link resource
 */
model PrivateLinkResource {
  /**
   * The ID of the private link resource.
   */
  id?: string;

  /**
   * The name of the private link resource.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;

  /**
   * The group ID of the resource.
   */
  groupId?: string;

  /**
   * The RequiredMembers of the resource
   */
  requiredMembers?: string[];

  /**
   * The private link service ID of the resource, this field is exposed only to NRP internally.
   */
  @visibility("read")
  privateLinkServiceID?: ResourceIdentifier;
}

/**
 * Cluster HTTP proxy configuration.
 */
model ManagedClusterHttpProxyConfig {
  /**
   * The HTTP proxy server endpoint to use.
   */
  httpProxy?: string;

  /**
   * The HTTPS proxy server endpoint to use.
   */
  httpsProxy?: string;

  /**
   * The endpoints that should not go through proxy.
   */
  noProxy?: string[];

  /**
   * Alternative CA cert to use for connecting to proxy servers.
   */
  trustedCa?: string;
}

/**
 * Security profile for the container service cluster.
 */
model ManagedClusterSecurityProfile {
  /**
   * Microsoft Defender settings for the security profile.
   */
  defender?: ManagedClusterSecurityProfileDefender;

  /**
   * Azure Key Vault [key management service](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) settings for the security profile.
   */
  azureKeyVaultKms?: AzureKeyVaultKms;

  /**
   * Workload identity settings for the security profile. Workload identity enables Kubernetes applications to access Azure cloud resources securely with Azure AD. See https://aka.ms/aks/wi for more details.
   */
  workloadIdentity?: ManagedClusterSecurityProfileWorkloadIdentity;

  /**
   * Image Cleaner settings for the security profile.
   */
  imageCleaner?: ManagedClusterSecurityProfileImageCleaner;
}

/**
 * Microsoft Defender settings for the security profile.
 */
model ManagedClusterSecurityProfileDefender {
  /**
   * Resource ID of the Log Analytics workspace to be associated with Microsoft Defender. When Microsoft Defender is enabled, this field is required and must be a valid workspace resource ID. When Microsoft Defender is disabled, leave the field empty.
   */
  logAnalyticsWorkspaceResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * Microsoft Defender threat detection for Cloud settings for the security profile.
   */
  securityMonitoring?: ManagedClusterSecurityProfileDefenderSecurityMonitoring;
}

/**
 * Microsoft Defender settings for the security profile threat detection.
 */
model ManagedClusterSecurityProfileDefenderSecurityMonitoring {
  /**
   * Whether to enable Defender threat detection
   */
  enabled?: boolean;
}

/**
 * Azure Key Vault key management service settings for the security profile.
 */
model AzureKeyVaultKms {
  /**
   * Whether to enable Azure Key Vault key management service. The default is false.
   */
  enabled?: boolean;

  /**
   * Identifier of Azure Key Vault key. See [key identifier format](https://docs.microsoft.com/en-us/azure/key-vault/general/about-keys-secrets-certificates#vault-name-and-object-name) for more details. When Azure Key Vault key management service is enabled, this field is required and must be a valid key identifier. When Azure Key Vault key management service is disabled, leave the field empty.
   */
  keyId?: string;

  /**
   * Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.
   */
  keyVaultNetworkAccess?: KeyVaultNetworkAccessTypes = KeyVaultNetworkAccessTypes.Public;

  /**
   * Resource ID of key vault. When keyVaultNetworkAccess is `Private`, this field is required and must be a valid resource ID. When keyVaultNetworkAccess is `Public`, leave the field empty.
   */
  keyVaultResourceId?: ResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

/**
 * Workload identity settings for the security profile.
 */
model ManagedClusterSecurityProfileWorkloadIdentity {
  /**
   * Whether to enable workload identity.
   */
  enabled?: boolean;
}

/**
 * Image Cleaner removes unused images from nodes, freeing up disk space and helping to reduce attack surface area. Here are settings for the security profile.
 */
model ManagedClusterSecurityProfileImageCleaner {
  /**
   * Whether to enable Image Cleaner on AKS cluster.
   */
  enabled?: boolean;

  /**
   * Image Cleaner scanning interval in hours.
   */
  intervalHours?: int32;
}

/**
 * Storage profile for the container service cluster.
 */
model ManagedClusterStorageProfile {
  /**
   * AzureDisk CSI Driver settings for the storage profile.
   */
  diskCSIDriver?: ManagedClusterStorageProfileDiskCSIDriver;

  /**
   * AzureFile CSI Driver settings for the storage profile.
   */
  fileCSIDriver?: ManagedClusterStorageProfileFileCSIDriver;

  /**
   * Snapshot Controller settings for the storage profile.
   */
  snapshotController?: ManagedClusterStorageProfileSnapshotController;

  /**
   * AzureBlob CSI Driver settings for the storage profile.
   */
  blobCSIDriver?: ManagedClusterStorageProfileBlobCSIDriver;
}

/**
 * AzureDisk CSI Driver settings for the storage profile.
 */
model ManagedClusterStorageProfileDiskCSIDriver {
  /**
   * Whether to enable AzureDisk CSI Driver. The default value is true.
   */
  enabled?: boolean;
}

/**
 * AzureFile CSI Driver settings for the storage profile.
 */
model ManagedClusterStorageProfileFileCSIDriver {
  /**
   * Whether to enable AzureFile CSI Driver. The default value is true.
   */
  enabled?: boolean;
}

/**
 * Snapshot Controller settings for the storage profile.
 */
model ManagedClusterStorageProfileSnapshotController {
  /**
   * Whether to enable Snapshot Controller. The default value is true.
   */
  enabled?: boolean;
}

/**
 * AzureBlob CSI Driver settings for the storage profile.
 */
model ManagedClusterStorageProfileBlobCSIDriver {
  /**
   * Whether to enable AzureBlob CSI Driver. The default value is false.
   */
  enabled?: boolean;
}

/**
 * Workload Auto-scaler profile for the managed cluster.
 */
model ManagedClusterWorkloadAutoScalerProfile {
  /**
   * KEDA (Kubernetes Event-driven Autoscaling) settings for the workload auto-scaler profile.
   */
  keda?: ManagedClusterWorkloadAutoScalerProfileKeda;

  /**
   * VPA (Vertical Pod Autoscaler) settings for the workload auto-scaler profile.
   */
  verticalPodAutoscaler?: ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler;
}

/**
 * KEDA (Kubernetes Event-driven Autoscaling) settings for the workload auto-scaler profile.
 */
model ManagedClusterWorkloadAutoScalerProfileKeda {
  /**
   * Whether to enable KEDA.
   */
  enabled: boolean;
}

/**
 * VPA (Vertical Pod Autoscaler) settings for the workload auto-scaler profile.
 */
model ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler {
  /**
   * Whether to enable VPA. Default value is false.
   */
  enabled: boolean;
}

/**
 * Azure Monitor addon profiles for monitoring the managed cluster.
 */
model ManagedClusterAzureMonitorProfile {
  /**
   * Metrics profile for the Azure Monitor managed service for Prometheus addon. Collect out-of-the-box Kubernetes infrastructure metrics to send to an Azure Monitor Workspace and configure additional scraping for custom targets. See aka.ms/AzureManagedPrometheus for an overview.
   */
  metrics?: ManagedClusterAzureMonitorProfileMetrics;
}

/**
 * Metrics profile for the Azure Monitor managed service for Prometheus addon. Collect out-of-the-box Kubernetes infrastructure metrics to send to an Azure Monitor Workspace and configure additional scraping for custom targets. See aka.ms/AzureManagedPrometheus for an overview.
 */
model ManagedClusterAzureMonitorProfileMetrics {
  /**
   * Whether to enable or disable the Azure Managed Prometheus addon for Prometheus monitoring. See aka.ms/AzureManagedPrometheus-aks-enable for details on enabling and disabling.
   */
  enabled: boolean;

  /**
   * Kube State Metrics profile for the Azure Managed Prometheus addon. These optional settings are for the kube-state-metrics pod that is deployed with the addon. See aka.ms/AzureManagedPrometheus-optional-parameters for details.
   */
  kubeStateMetrics?: ManagedClusterAzureMonitorProfileKubeStateMetrics;
}

/**
 * Kube State Metrics profile for the Azure Managed Prometheus addon. These optional settings are for the kube-state-metrics pod that is deployed with the addon. See aka.ms/AzureManagedPrometheus-optional-parameters for details.
 */
model ManagedClusterAzureMonitorProfileKubeStateMetrics {
  /**
   * Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric (Example: 'namespaces=[k8s-label-1,k8s-label-n,...],pods=[app],...'). By default the metric contains only resource name and namespace labels.
   */
  metricLabelsAllowlist?: string;

  /**
   * Comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric (Example: 'namespaces=[kubernetes.io/team,...],pods=[kubernetes.io/team],...'). By default the metric contains only resource name and namespace labels.
   */
  metricAnnotationsAllowList?: string;
}

/**
 * Service mesh profile for a managed cluster.
 */
model ServiceMeshProfile {
  /**
   * Mode of the service mesh.
   */
  mode: ServiceMeshMode;

  /**
   * Istio service mesh configuration.
   */
  istio?: IstioServiceMesh;
}

/**
 * Istio service mesh configuration.
 */
model IstioServiceMesh {
  /**
   * Istio components configuration.
   */
  components?: IstioComponents;

  /**
   * Istio Service Mesh Certificate Authority (CA) configuration. For now, we only support plugin certificates as described here https://aka.ms/asm-plugin-ca
   */
  certificateAuthority?: IstioCertificateAuthority;

  /**
   * The list of revisions of the Istio control plane. When an upgrade is not in progress, this holds one value. When canary upgrade is in progress, this can only hold two consecutive values. For more information, see: https://learn.microsoft.com/en-us/azure/aks/istio-upgrade
   */
  revisions?: string[];
}

/**
 * Istio components configuration.
 */
model IstioComponents {
  /**
   * Istio ingress gateways.
   */
  ingressGateways?: IstioIngressGateway[];

  /**
   * Istio egress gateways.
   */
  egressGateways?: IstioEgressGateway[];
}

/**
 * Istio ingress gateway configuration. For now, we support up to one external ingress gateway named `aks-istio-ingressgateway-external` and one internal ingress gateway named `aks-istio-ingressgateway-internal`.
 */
model IstioIngressGateway {
  /**
   * Mode of an ingress gateway.
   */
  mode: IstioIngressGatewayMode;

  /**
   * Whether to enable the ingress gateway.
   */
  enabled: boolean;
}

/**
 * Istio egress gateway configuration.
 */
model IstioEgressGateway {
  /**
   * Whether to enable the egress gateway.
   */
  enabled: boolean;

  /**
   * NodeSelector for scheduling the egress gateway.
   */
  nodeSelector?: Record<string>;
}

/**
 * Istio Service Mesh Certificate Authority (CA) configuration. For now, we only support plugin certificates as described here https://aka.ms/asm-plugin-ca
 */
model IstioCertificateAuthority {
  /**
   * Plugin certificates information for Service Mesh.
   */
  plugin?: IstioPluginCertificateAuthority;
}

/**
 * Plugin certificates information for Service Mesh.
 */
model IstioPluginCertificateAuthority {
  /**
   * The resource ID of the Key Vault.
   */
  keyVaultId?: ResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Intermediate certificate object name in Azure Key Vault.
   */
  certObjectName?: string;

  /**
   * Intermediate certificate private key object name in Azure Key Vault.
   */
  keyObjectName?: string;

  /**
   * Root certificate object name in Azure Key Vault.
   */
  rootCertObjectName?: string;

  /**
   * Certificate chain object name in Azure Key Vault.
   */
  certChainObjectName?: string;
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
model ManagedClusterUpgradeProfileProperties {
  /**
   * The list of available upgrade versions for the control plane.
   */
  controlPlaneProfile: ManagedClusterPoolUpgradeProfile;

  /**
   * The list of available upgrade versions for agent pools.
   */
  agentPoolProfiles: ManagedClusterPoolUpgradeProfile[];
}

/**
 * The list of available upgrade versions.
 */
model ManagedClusterPoolUpgradeProfile {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion: string;

  /**
   * The Agent Pool name.
   */
  name?: string;

  /**
   * The operating system type. The default is Linux.
   */
  osType: OSType = OSType.Linux;

  /**
   * List of orchestrator types and versions available for upgrade.
   */
  upgrades?: ManagedClusterPoolUpgradeProfileUpgradesItem[];
}

model ManagedClusterPoolUpgradeProfileUpgradesItem {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  isPreview?: boolean;
}

/**
 * Managed cluster Access Profile.
 */
model ManagedClusterAccessProfile extends TrackedResource {
  /**
   * AccessProfile of a managed cluster.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AccessProfile;
}

/**
 * Profile for enabling a user to access a managed cluster.
 */
model AccessProfile {
  /**
   * Base64-encoded Kubernetes configuration file.
   */
  kubeConfig?: bytes;
}

/**
 * The list credential result response.
 */
model CredentialResults {
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

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Properties used to configure planned maintenance for a Managed Cluster.
 */
model MaintenanceConfigurationProperties {
  /**
   * If two array entries specify the same day of the week, the applied configuration is the union of times in both entries.
   */
  @projectedName("json", "timeInWeek")
  timesInWeek?: TimeInWeek[];

  /**
   * Time slots on which upgrade is not allowed.
   */
  @projectedName("json", "notAllowedTime")
  notAllowedTimes?: TimeSpan[];

  /**
   * Maintenance window for the maintenance configuration.
   */
  maintenanceWindow?: MaintenanceWindow;
}

/**
 * Time in a week.
 */
model TimeInWeek {
  /**
   * The day of the week.
   */
  day?: WeekDay;

  /**
   * Each integer hour represents a time range beginning at 0m after the hour ending at the next hour (non-inclusive). 0 corresponds to 00:00 UTC, 23 corresponds to 23:00 UTC. Specifying [0, 1] means the 00:00 - 02:00 UTC time range.
   */
  hourSlots?: int32[];
}

/**
 * For example, between 2021-05-25T13:00:00Z and 2021-05-25T14:00:00Z.
 */
model TimeSpan {
  /**
   * The start of a time span
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start?: utcDateTime;

  /**
   * The end of a time span
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end?: utcDateTime;
}

/**
 * Maintenance window used to configure scheduled auto-upgrade for a Managed Cluster.
 */
model MaintenanceWindow {
  /**
   * Recurrence schedule for the maintenance window.
   */
  schedule: Schedule;

  /**
   * Length of maintenance window range from 4 to 24 hours.
   */
  @maxValue(24)
  @minValue(4)
  durationHours: int32 = 24;

  /**
   * The UTC offset in format +/-HH:mm. For example, '+05:30' for IST and '-07:00' for PST. If not specified, the default is '+00:00'.
   */
  @pattern("^(-|\\+)[0-9]{2}:[0-9]{2}$")
  utcOffset?: string;

  /**
   * The date the maintenance window activates. If the current date is before this date, the maintenance window is inactive and will not be used for upgrades. If not specified, the maintenance window will be active right away.
   */
  startDate?: plainDate;

  /**
   * The start time of the maintenance window. Accepted values are from '00:00' to '23:59'. 'utcOffset' applies to this field. For example: '02:00' with 'utcOffset: +02:00' means UTC time '00:00'.
   */
  @pattern("^\\d{2}:\\d{2}$")
  startTime: string;

  /**
   * Date ranges on which upgrade is not allowed. 'utcOffset' applies to this field. For example, with 'utcOffset: +02:00' and 'dateSpan' being '2022-12-23' to '2023-01-03', maintenance will be blocked from '2022-12-22 22:00' to '2023-01-03 22:00' in UTC time.
   */
  notAllowedDates?: DateSpan[];
}

/**
 * One and only one of the schedule types should be specified. Choose either 'daily', 'weekly', 'absoluteMonthly' or 'relativeMonthly' for your maintenance schedule.
 */
model Schedule {
  /**
   * For schedules like: 'recur every day' or 'recur every 3 days'.
   */
  daily?: DailySchedule;

  /**
   * For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.
   */
  weekly?: WeeklySchedule;

  /**
   * For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.
   */
  absoluteMonthly?: AbsoluteMonthlySchedule;

  /**
   * For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.
   */
  relativeMonthly?: RelativeMonthlySchedule;
}

/**
 * For schedules like: 'recur every day' or 'recur every 3 days'.
 */
model DailySchedule {
  /**
   * Specifies the number of days between each set of occurrences.
   */
  @maxValue(7)
  @minValue(1)
  intervalDays: int32;
}

/**
 * For schedules like: 'recur every Monday' or 'recur every 3 weeks on Wednesday'.
 */
model WeeklySchedule {
  /**
   * Specifies the number of weeks between each set of occurrences.
   */
  @maxValue(4)
  @minValue(1)
  intervalWeeks: int32;

  /**
   * Specifies on which day of the week the maintenance occurs.
   */
  dayOfWeek: WeekDay;
}

/**
 * For schedules like: 'recur every month on the 15th' or 'recur every 3 months on the 20th'.
 */
model AbsoluteMonthlySchedule {
  /**
   * Specifies the number of months between each set of occurrences.
   */
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  /**
   * The date of the month.
   */
  @maxValue(31)
  @minValue(1)
  dayOfMonth: int32;
}

/**
 * For schedules like: 'recur every month on the first Monday' or 'recur every 3 months on last Friday'.
 */
model RelativeMonthlySchedule {
  /**
   * Specifies the number of months between each set of occurrences.
   */
  @maxValue(6)
  @minValue(1)
  intervalMonths: int32;

  /**
   * Specifies on which week of the month the dayOfWeek applies.
   */
  weekIndex: Type;

  /**
   * Specifies on which day of the week the maintenance occurs.
   */
  dayOfWeek: WeekDay;
}

/**
 * For example, between '2022-12-23' and '2023-01-05'.
 */
model DateSpan {
  /**
   * The start date of the date span.
   */
  start: plainDate;

  /**
   * The end date of the date span.
   */
  end: plainDate;
}

/**
 * Reference to another subresource.
 */
model SubResource {
  /**
   * Resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;
}

/**
 * The list of available upgrade versions.
 */
model AgentPoolUpgradeProfileProperties {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion: string;

  /**
   * The operating system type. The default is Linux.
   */
  osType: OSType = OSType.Linux;

  /**
   * List of orchestrator types and versions available for upgrade.
   */
  upgrades?: AgentPoolUpgradeProfilePropertiesUpgradesItem[];

  /**
   * The latest AKS supported node image version.
   */
  latestNodeImageVersion?: string;
}

model AgentPoolUpgradeProfilePropertiesUpgradesItem {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  isPreview?: boolean;
}

/**
 * The list of available versions for an agent pool.
 */
model AgentPoolAvailableVersions {
  /**
   * The ID of the agent pool version list.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the agent pool version list.
   */
  @visibility("read")
  name?: string;

  /**
   * Type of the agent pool version list.
   */
  @visibility("read")
  type?: string;

  /**
   * Properties of agent pool available versions.
   */
  @extension("x-ms-client-flatten", true)
  properties: AgentPoolAvailableVersionsProperties;
}

/**
 * The list of available agent pool versions.
 */
model AgentPoolAvailableVersionsProperties {
  /**
   * List of versions available for agent pool.
   */
  agentPoolVersions?: AgentPoolAvailableVersion[];
}

model AgentPoolAvailableVersion {
  /**
   * Whether this version is the default agent pool version.
   */
  @projectedName("json", "default")
  IsDefault?: boolean;

  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether Kubernetes version is currently in preview.
   */
  isPreview?: boolean;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The current provisioning state.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;
}

/**
 * Private endpoint which a connection belongs to.
 */
model PrivateEndpoint {
  /**
   * The resource ID of the private endpoint
   */
  id?: string;
}

/**
 * The state of a private link service connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: ConnectionStatus;

  /**
   * The private link service connection description.
   */
  description?: string;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourcesListResult {
  /**
   * The collection value.
   */
  value?: PrivateLinkResource[];
}

/**
 * A run command request
 */
model RunCommandRequest {
  /**
   * The command to run.
   */
  command: string;

  /**
   * A base64 encoded zip file containing the files required by the command.
   */
  context?: string;

  /**
   * AuthToken issued for AKS AAD Server App.
   */
  clusterToken?: string;
}

/**
 * run command result.
 */
model RunCommandResult {
  /**
   * The command id.
   */
  @visibility("read")
  id?: string;

  /**
   * Properties of command result.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CommandResultProperties;
}

/**
 * The results of a run command
 */
model CommandResultProperties {
  /**
   * provisioning State
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The exit code of the command
   */
  @visibility("read")
  exitCode?: int32;

  /**
   * The time when the command started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  /**
   * The time when the command finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedAt?: utcDateTime;

  /**
   * The command output.
   */
  @visibility("read")
  logs?: string;

  /**
   * An explanation of why provisioningState is set to failed (if so).
   */
  @visibility("read")
  reason?: string;
}

/**
 * Collection of OutboundEnvironmentEndpoint
 */
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * Egress endpoints which AKS agent nodes connect to for common purpose.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The category of endpoints accessed by the AKS agent node, e.g. azure-resource-management, apiserver, etc.
   */
  category?: string;

  /**
   * The endpoints that AKS agent nodes connect to
   */
  endpoints?: EndpointDependency[];
}

/**
 * A domain name that AKS agent nodes are reaching at.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName?: string;

  /**
   * The Ports and Protocols used when connecting to domainName.
   */
  endpointDetails?: EndpointDetail[];
}

/**
 * connect information from the AKS agent nodes to a single endpoint.
 */
model EndpointDetail {
  /**
   * An IP Address that Domain Name currently resolves to.
   */
  ipAddress?: string;

  /**
   * The port an endpoint is connected to.
   */
  port?: int32;

  /**
   * The protocol used for connection
   */
  protocol?: string;

  /**
   * Description of the detail
   */
  description?: string;
}

/**
 * Properties used to configure a node pool snapshot.
 */
model SnapshotProperties {
  /**
   * CreationData to be used to specify the source agent pool resource ID to create this snapshot.
   */
  creationData?: CreationData;

  /**
   * The type of a snapshot. The default is NodePool.
   */
  snapshotType?: SnapshotType = SnapshotType.NodePool;

  /**
   * The version of Kubernetes.
   */
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * The version of node image.
   */
  @visibility("read")
  nodeImageVersion?: string;

  /**
   * The operating system type. The default is Linux.
   */
  @visibility("read")
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
   */
  @visibility("read")
  osSku?: OSSku;

  /**
   * The size of the VM.
   */
  @visibility("read")
  vmSize?: string;

  /**
   * Whether to use a FIPS-enabled OS.
   */
  @visibility("read")
  @projectedName("json", "enableFIPS")
  enableFips?: boolean;
}

/**
 * Mesh revision profile properties for a mesh
 */
model MeshRevisionProfileProperties {
  meshRevisions?: MeshRevision[];
}

/**
 * Holds information on upgrades and compatibility for given major.minor mesh release.
 */
model MeshRevision {
  /**
   * The revision of the mesh release.
   */
  revision?: string;

  /**
   * List of revisions available for upgrade of a specific mesh revision
   */
  upgrades?: string[];

  /**
   * List of items this revision of service mesh is compatible with, and their associated versions.
   */
  compatibleWith?: CompatibleVersions[];
}

/**
 * Version information about a product/service that is compatible with a service mesh revision.
 */
model CompatibleVersions {
  /**
   * The product/service name.
   */
  name?: string;

  /**
   * Product/service versions compatible with a service mesh add-on revision.
   */
  versions?: string[];
}

/**
 * Mesh upgrade profile properties for a major.minor release.
 */
model MeshUpgradeProfileProperties extends MeshRevision {}

/**
 * Properties for trusted access role binding
 */
model TrustedAccessRoleBindingProperties {
  /**
   * The current provisioning state of trusted access role binding.
   */
  @visibility("read")
  provisioningState?: TrustedAccessRoleBindingProvisioningState;

  /**
   * The ARM resource ID of source resource that trusted access is configured for.
   */
  sourceResourceId: ResourceIdentifier;

  /**
   * A list of roles to bind, each item is a resource type qualified role name. For example: 'Microsoft.MachineLearningServices/workspaces/reader'.
   */
  roles: string[];
}

/**
 * List of trusted access roles
 */
model TrustedAccessRoleListResult is Azure.Core.Page<TrustedAccessRole>;

/**
 * Trusted access role definition.
 */
model TrustedAccessRole {
  /**
   * Resource type of Azure resource
   */
  @visibility("read")
  sourceResourceType?: string;

  /**
   * Name of role, name is unique under a source resource type
   */
  @visibility("read")
  name?: string;

  /**
   * List of rules for the role. This maps to 'rules' property of [Kubernetes Cluster Role](https://kubernetes.io/docs/reference/kubernetes-api/authorization-resources/cluster-role-v1/#ClusterRole).
   */
  @visibility("read")
  rules?: TrustedAccessRoleRule[];
}

/**
 * Rule for trusted access role
 */
model TrustedAccessRoleRule {
  /**
   * List of allowed verbs
   */
  @visibility("read")
  verbs?: string[];

  /**
   * List of allowed apiGroups
   */
  @visibility("read")
  apiGroups?: string[];

  /**
   * List of allowed resources
   */
  @visibility("read")
  resources?: string[];

  /**
   * List of allowed names
   */
  @visibility("read")
  resourceNames?: string[];

  /**
   * List of allowed nonResourceURLs
   */
  @visibility("read")
  nonResourceURLs?: string[];
}
