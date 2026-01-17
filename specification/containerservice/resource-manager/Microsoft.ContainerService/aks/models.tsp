import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

namespace Microsoft.ContainerService;

/**
 * Different support tiers for AKS managed clusters
 */
union KubernetesSupportPlan {
  string,

  /**
   * Support for the version is the same as for the open source Kubernetes offering. Official Kubernetes open source community support versions for 1 year after release.
   */
  KubernetesOfficial: "KubernetesOfficial",

  /**
   * Support for the version extended past the KubernetesOfficial support of 1 year. AKS continues to patch CVEs for another 1 year, for a total of 2 years of support.
   */
  AKSLongTermSupport: "AKSLongTermSupport",
}

/**
 * The name of a managed cluster SKU.
 */
union ManagedClusterSKUName {
  string,

  /**
   * Base option for the AKS control plane.
   */
  Base: "Base",

  /**
   * Automatic clusters are optimized to run most production workloads with configuration that follows AKS best practices and recommendations for cluster and workload setup, scalability, and security. For more details about Automatic clusters see aka.ms/aks/automatic.
   */
  Automatic: "Automatic",
}

/**
 * The tier of a managed cluster SKU. If not specified, the default is 'Free'. See [AKS Pricing Tier](https://learn.microsoft.com/azure/aks/free-standard-pricing-tiers) for more details.
 */
union ManagedClusterSKUTier {
  string,

  /**
   * Cluster has premium capabilities in addition to all of the capabilities included in 'Standard'. Premium enables selection of LongTermSupport (aka.ms/aks/lts) for certain Kubernetes versions.
   */
  Premium: "Premium",

  /**
   * Recommended for mission-critical and production workloads. Includes Kubernetes control plane autoscaling, workload-intensive testing, and up to 5,000 nodes per cluster. Guarantees 99.95% availability of the Kubernetes API server endpoint for clusters that use Availability Zones and 99.9% of availability for clusters that don't use Availability Zones.
   */
  Standard: "Standard",

  /**
   * The cluster management is free, but charged for VM, storage, and networking usage. Best for experimenting, learning, simple testing, or workloads with fewer than 10 nodes. Not recommended for production use cases.
   */
  Free: "Free",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EdgeZone: "EdgeZone",
}

/**
 * Tells whether the cluster is Running or Stopped
 */
union Code {
  string,

  /**
   * The cluster is running.
   */
  Running: "Running",

  /**
   * The cluster is stopped.
   */
  Stopped: "Stopped",
}

/**
 * The OS disk type to be used for machines in the agent pool. The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
 */
union OSDiskType {
  string,

  /**
   * Azure replicates the operating system disk for a virtual machine to Azure storage to avoid data loss should the VM need to be relocated to another host. Since containers aren't designed to have local state persisted, this behavior offers limited value while providing some drawbacks, including slower node provisioning and higher read/write latency.
   */
  Managed: "Managed",

  /**
   * Ephemeral OS disks are stored only on the host machine, just like a temporary disk. This provides lower read/write latency, along with faster node scaling and cluster upgrades.
   */
  Ephemeral: "Ephemeral",
}

/**
 * Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.
 */
union KubeletDiskType {
  string,

  /**
   * Kubelet will use the OS disk for its data.
   */
  OS: "OS",

  /**
   * Kubelet will use the temporary disk for its data.
   */
  Temporary: "Temporary",
}

/**
 * Determines the type of workload a node can run.
 */
union WorkloadRuntime {
  string,

  /**
   * Nodes will use Kubelet to run standard OCI container workloads.
   */
  OCIContainer: "OCIContainer",

  /**
   * Nodes will use Krustlet to run WASM workloads using the WASI provider (Preview).
   */
  WasmWasi: "WasmWasi",

  /**
   * Nodes can use (Kata + Cloud Hypervisor + Hyper-V) to enable Nested VM-based pods (Preview). Due to the use Hyper-V, AKS node OS itself is a nested VM (the root OS) of Hyper-V. Thus it can only be used with VM series that support Nested Virtualization such as Dv3 series. This naming convention will be deprecated in future releases in favor of KataVmIsolation.
   */
  @added(Versions.v2025_10_02_preview)
  KataMshvVmIsolation: "KataMshvVmIsolation",

  /**
   * Nodes can use (Kata + Cloud Hypervisor + Hyper-V) to enable Nested VM-based pods. Due to the use Hyper-V, AKS node OS itself is a nested VM (the root OS) of Hyper-V. Thus it can only be used with VM series that support Nested Virtualization such as Dv3 series.
   */
  KataVmIsolation: "KataVmIsolation",
}

/**
 * Pod IP Allocation Mode. The IP allocation mode for pods in the agent pool. Must be used with podSubnetId. The default is 'DynamicIndividual'.
 */
union PodIPAllocationMode {
  string,

  /**
   * Each node gets allocated with a non-contiguous list of IP addresses assignable to pods. This is better for maximizing a small to medium subnet of size /16 or smaller. The Azure CNI cluster with dynamic IP allocation defaults to this mode if the customer does not explicitly specify a podIPAllocationMode
   */
  DynamicIndividual: "DynamicIndividual",

  /**
   * Each node is statically allocated CIDR block(s) of size /28 = 16 IPs per block to satisfy the maxPods per node. Number of CIDR blocks >= (maxPods / 16). The block, rather than a single IP, counts against the Azure Vnet Private IP limit of 65K. Therefore block mode is suitable for running larger workloads with more than the current limit of 65K pods in a cluster. This mode is better suited to scale with larger subnets of /15 or bigger
   */
  StaticBlock: "StaticBlock",
}

/**
 * The operating system type. The default is Linux.
 */
union OSType {
  string,

  /**
   * Use Linux.
   */
  Linux: "Linux",

  /**
   * Use Windows.
   */
  Windows: "Windows",
}

/**
 * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
 */
union OSSKU {
  string,

  /**
   * Use Ubuntu as the OS for node images.
   */
  Ubuntu: "Ubuntu",

  /**
   * Use AzureLinux as the OS for node images. Azure Linux is a container-optimized Linux distro built by Microsoft, visit https://aka.ms/azurelinux for more information.
   */
  AzureLinux: "AzureLinux",

  /**
   * Use AzureLinux3 as the OS for node images. Azure Linux is a container-optimized Linux distro built by Microsoft, visit https://aka.ms/azurelinux for more information. For limitations, visit https://aka.ms/aks/node-images. For OS migration guidance, see https://aka.ms/aks/upgrade-os-version.
   */
  AzureLinux3: "AzureLinux3",

  /**
   * Deprecated OSSKU. Microsoft recommends that new deployments choose 'AzureLinux' instead.
   */
  @added(Versions.v2025_10_02_preview)
  Mariner: "Mariner",

  /**
   * Use Flatcar Container Linux as the OS for node images. Flatcar is a container-optimized, security-focused Linux OS, with an immutable filesystem and part of the Cloud Native Computing Foundation (CNCF). For more information about Flatcar Container Linux for AKS, see aka.ms/aks/flatcar-container-linux-for-aks
   */
  @added(Versions.v2025_10_02_preview)
  Flatcar: "Flatcar",

  /**
   * Deprecated OSSKU. Microsoft recommends that new deployments choose 'AzureLinux' instead.
   */
  CBLMariner: "CBLMariner",

  /**
   * Use Windows2019 as the OS for node images. Unsupported for system node pools. Windows2019 only supports Windows2019 containers; it cannot run Windows2022 containers and vice versa.
   */
  Windows2019: "Windows2019",

  /**
   * Use Windows2022 as the OS for node images. Unsupported for system node pools. Windows2022 only supports Windows2022 containers; it cannot run Windows2019 containers and vice versa.
   */
  Windows2022: "Windows2022",

  /**
   * Use Ubuntu2204 as the OS for node images, however, Ubuntu 22.04 may not be supported for all nodepools. For limitations and supported kubernetes versions, see https://aka.ms/aks/supported-ubuntu-versions
   */
  Ubuntu2204: "Ubuntu2204",

  /**
   * Use Windows2025 as the OS for node images. Unsupported for system node pools. Windows2025 supports Windows2022 and Windows 2025 containers; it cannot run Windows2019 containers and vice versa.
   */
  @added(Versions.v2025_10_02_preview)
  Windows2025: "Windows2025",

  /**
   * Use Windows Annual Channel version as the OS for node images. Unsupported for system node pools. Details about supported container images and kubernetes versions under different AKS Annual Channel versions could be seen in https://aka.ms/aks/windows-annual-channel-details.
   */
  @added(Versions.v2025_10_02_preview)
  WindowsAnnual: "WindowsAnnual",

  /**
   * Use Ubuntu2404 as the OS for node images, however, Ubuntu 24.04 may not be supported for all nodepools. For limitations and supported kubernetes versions, see see https://aka.ms/aks/supported-ubuntu-versions
   */
  Ubuntu2404: "Ubuntu2404",
}

/**
 * Describes how VMs are added to or removed from Agent Pools. See [billing states](https://docs.microsoft.com/azure/virtual-machines/states-billing).
 */
union ScaleDownMode {
  string,

  /**
   * Create new instances during scale up and remove instances during scale down.
   */
  Delete: "Delete",

  /**
   * Attempt to start deallocated instances (if they exist) during scale up and deallocate instances during scale down.
   */
  Deallocate: "Deallocate",
}

/**
 * The type of Agent Pool.
 */
union AgentPoolType {
  string,

  /**
   * Create an Agent Pool backed by a Virtual Machine Scale Set.
   */
  VirtualMachineScaleSets: "VirtualMachineScaleSets",

  /**
   * Use of this is strongly discouraged.
   */
  AvailabilitySet: "AvailabilitySet",

  /**
   * Create an Agent Pool backed by a Single Instance VM orchestration mode.
   */
  VirtualMachines: "VirtualMachines",
}

/**
 * The mode of an agent pool. A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools
 */
union AgentPoolMode {
  string,

  /**
   * System agent pools are primarily for hosting critical system pods such as CoreDNS and metrics-server. System agent pools osType must be Linux. System agent pools VM SKU must have at least 2vCPUs and 4GB of memory.
   */
  System: "System",

  /**
   * User agent pools are primarily for hosting your application pods.
   */
  User: "User",

  /**
   * Gateway agent pools are dedicated to providing static egress IPs to pods. For more details, see https://aka.ms/aks/static-egress-gateway.
   */
  Gateway: "Gateway",

  /**
   * ManagedSystem is a system pool managed by AKS. The pool scales dynamically according to cluster usage, and has additional automated monitoring and healing capabilities. There can only be one ManagedSystem pool, and it is recommended to delete all other system pools for the best experience.
   */
  @added(Versions.v2025_10_02_preview)
  ManagedSystem: "ManagedSystem",

  /**
   * Machines agent pools are dedicated to hosting machines. Only limited operations, such as creation and deletion, are allowed at the pool level. Please use the machine APIs to manage the full machine lifecycle.
   */
  @added(Versions.v2025_10_02_preview)
  Machines: "Machines",
}

/**
 * Defines the upgrade strategy for the agent pool. The default is Rolling.
 */
@added(Versions.v2025_10_02_preview)
union UpgradeStrategy {
  string,

  /**
   * Specifies that the agent pool will conduct rolling upgrade. This is the default upgrade strategy.
   */
  Rolling: "Rolling",

  /**
   * Specifies that the agent pool will conduct blue-green upgrade.
   */
  BlueGreen: "BlueGreen",
}

/**
 * Defines the behavior for undrainable nodes during upgrade. The most common cause of undrainable nodes is Pod Disruption Budgets (PDBs), but other issues, such as pod termination grace period is exceeding the remaining per-node drain timeout or pod is still being in a running state, can also cause undrainable nodes.
 */
union UndrainableNodeBehavior {
  string,

  /**
   * AKS will cordon the blocked nodes and replace them with surge nodes during upgrade. The blocked nodes will be cordoned and replaced by surge nodes. The blocked nodes will have label 'kubernetes.azure.com/upgrade-status:Quarantined'. A surge node will be retained for each blocked node. A best-effort attempt will be made to delete all other surge nodes. If there are enough surge nodes to replace blocked nodes, then the upgrade operation and the managed cluster will be in failed state. Otherwise, the upgrade operation and the managed cluster will be in canceled state.
   */
  Cordon: "Cordon",

  /**
   * AKS will mark the blocked nodes schedulable, but the blocked nodes are not upgraded. A best-effort attempt will be made to delete all surge nodes. The upgrade operation and the managed cluster will be in failed state if there are any blocked nodes.
   */
  Schedule: "Schedule",
}

/**
 * The Virtual Machine Scale Set priority.
 */
union ScaleSetPriority {
  string,

  /**
   * Spot priority VMs will be used. There is no SLA for spot nodes. See [spot on AKS](https://docs.microsoft.com/azure/aks/spot-node-pool) for more information.
   */
  Spot: "Spot",

  /**
   * Regular VMs will be used.
   */
  Regular: "Regular",
}

/**
 * The Virtual Machine Scale Set eviction policy. The eviction policy specifies what to do with the VM when it is evicted. The default is Delete. For more information about eviction see [spot VMs](https://docs.microsoft.com/azure/virtual-machines/spot-vms)
 */
union ScaleSetEvictionPolicy {
  string,

  /**
   * Nodes in the underlying Scale Set of the node pool are deleted when they're evicted.
   */
  Delete: "Delete",

  /**
   * Nodes in the underlying Scale Set of the node pool are set to the stopped-deallocated state upon eviction. Nodes in the stopped-deallocated state count against your compute quota and can cause issues with cluster scaling or upgrading.
   */
  Deallocate: "Deallocate",
}

/**
 * Specifies the default seccomp profile applied to all workloads. If not specified, 'Unconfined' will be used by default.
 */
@added(Versions.v2025_10_02_preview)
union SeccompDefault {
  string,

  /**
   * No seccomp profile is applied, allowing all system calls.
   */
  Unconfined: "Unconfined",

  /**
   * The default seccomp profile for container runtime is applied, which restricts certain system calls for enhanced security.
   */
  RuntimeDefault: "RuntimeDefault",
}

/**
 * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
 */
union GPUInstanceProfile {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MIG1g: "MIG1g",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MIG2g: "MIG2g",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MIG3g: "MIG3g",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MIG4g: "MIG4g",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MIG7g: "MIG7g",
}

/**
 * The network protocol of the port.
 */
union Protocol {
  string,

  /**
   * TCP protocol.
   */
  TCP: "TCP",

  /**
   * UDP protocol.
   */
  UDP: "UDP",
}

/**
 * SSH access method of an agent pool.
 */
union AgentPoolSSHAccess {
  string,

  /**
   * Can SSH onto the node as a local user using private key.
   */
  LocalUser: "LocalUser",

  /**
   * SSH service will be turned off on the node.
   */
  Disabled: "Disabled",

  /**
   * SSH to node with EntraId integration. More information can be found under https://aka.ms/aks/ssh/aad
   */
  @added(Versions.v2025_10_02_preview)
  EntraId: "EntraId",
}

/**
 * Whether to install GPU drivers. When it's not specified, default is Install.
 */
union GPUDriver {
  string,

  /**
   * Install driver.
   */
  Install: "Install",

  /**
   * Skip driver install.
   */
  None: "None",
}

/**
 * Specify the type of GPU driver to install when creating Windows agent pools. If not provided, AKS selects the driver based on system compatibility. This cannot be changed once the AgentPool has been created. This cannot be set on Linux AgentPools. For Linux AgentPools, the driver is selected based on system compatibility.
 */
@added(Versions.v2025_10_02_preview)
union DriverType {
  string,

  /**
   * Install the GRID driver for the GPU, suitable for applications requiring virtualization support.
   */
  GRID: "GRID",

  /**
   * Install the CUDA driver for the GPU, optimized for computational tasks in scientific computing and data-intensive applications.
   */
  CUDA: "CUDA",
}

/**
 * Mode of enablement for localDNS.
 */
union LocalDNSMode {
  string,

  /**
   * If the current orchestrator version supports this feature, prefer enabling localDNS.
   */
  Preferred: "Preferred",

  /**
   * Enable localDNS.
   */
  Required: "Required",

  /**
   * Disable localDNS.
   */
  Disabled: "Disabled",
}

/**
 * System-generated state of localDNS.
 */
union LocalDNSState {
  string,

  /**
   * localDNS is enabled.
   */
  Enabled: "Enabled",

  /**
   * localDNS is disabled.
   */
  Disabled: "Disabled",
}

/**
 * Log level for DNS queries in localDNS.
 */
union LocalDNSQueryLogging {
  string,

  /**
   * Enables error logging in localDNS. See [errors plugin](https://coredns.io/plugins/errors) for more information.
   */
  Error: "Error",

  /**
   * Enables query logging in localDNS. See [log plugin](https://coredns.io/plugins/log) for more information.
   */
  Log: "Log",
}

/**
 * Enforce TCP or prefer UDP protocol for connections from localDNS to upstream DNS server.
 */
union LocalDNSProtocol {
  string,

  /**
   * Prefer UDP protocol for connections from localDNS to upstream DNS server.
   */
  PreferUDP: "PreferUDP",

  /**
   * Enforce TCP protocol for connections from localDNS to upstream DNS server.
   */
  ForceTCP: "ForceTCP",
}

/**
 * Destination server for DNS queries to be forwarded from localDNS.
 */
union LocalDNSForwardDestination {
  string,

  /**
   * Forward DNS queries from localDNS to cluster CoreDNS.
   */
  ClusterCoreDNS: "ClusterCoreDNS",

  /**
   * Forward DNS queries from localDNS to DNS server configured in the VNET. A VNET can have multiple DNS servers configured.
   */
  VnetDNS: "VnetDNS",
}

/**
 * Forward policy for selecting upstream DNS server. See [forward plugin](https://coredns.io/plugins/forward) for more information.
 */
union LocalDNSForwardPolicy {
  string,

  /**
   * Implements sequential upstream DNS server selection. See [forward plugin](https://coredns.io/plugins/forward) for more information.
   */
  Sequential: "Sequential",

  /**
   * Implements round robin upstream DNS server selection. See [forward plugin](https://coredns.io/plugins/forward) for more information.
   */
  RoundRobin: "RoundRobin",

  /**
   * Implements random upstream DNS server selection. See [forward plugin](https://coredns.io/plugins/forward) for more information.
   */
  Random: "Random",
}

/**
 * Policy for serving stale data. See [cache plugin](https://coredns.io/plugins/cache) for more information.
 */
union LocalDNSServeStale {
  string,

  /**
   * Serve stale data with verification. First verify that an entry is still unavailable from the source before sending the expired entry to the client. See [cache plugin](https://coredns.io/plugins/cache) for more information.
   */
  Verify: "Verify",

  /**
   * Serve stale data immediately. Send the expired entry to the client before checking to see if the entry is available from the source. See [cache plugin](https://coredns.io/plugins/cache) for more information.
   */
  Immediate: "Immediate",

  /**
   * Disable serving stale data.
   */
  Disable: "Disable",
}

/**
 * The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.
 */
union LicenseType {
  string,

  /**
   * No additional licensing is applied.
   */
  None: "None",

  /**
   * Enables Azure Hybrid User Benefits for Windows VMs.
   */
  Windows_Server: "Windows_Server",
}

/**
 * The current provisioning state of the pod identity.
 */
union ManagedClusterPodIdentityProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Assigned: "Assigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * The restriction level applied to the cluster's node resource group. If not specified, the default is 'Unrestricted'
 */
union RestrictionLevel {
  string,

  /**
   * All RBAC permissions are allowed on the managed node resource group
   */
  Unrestricted: "Unrestricted",

  @doc("Only \\*\\/read RBAC permissions allowed on the managed node resource group")
  ReadOnly: "ReadOnly",
}

/**
 * Network plugin used for building the Kubernetes network.
 */
union NetworkPlugin {
  string,

  /**
   * Use the Azure CNI network plugin. See [Azure CNI (advanced) networking](https://docs.microsoft.com/azure/aks/concepts-network#azure-cni-advanced-networking) for more information.
   */
  azure: "azure",

  /**
   * Use the Kubenet network plugin. See [Kubenet (basic) networking](https://docs.microsoft.com/azure/aks/concepts-network#kubenet-basic-networking) for more information.
   */
  kubenet: "kubenet",

  /**
   * No CNI plugin is pre-installed. See [BYO CNI](https://docs.microsoft.com/en-us/azure/aks/use-byo-cni) for more information.
   */
  none: "none",
}

/**
 * The mode the network plugin should use.
 */
union NetworkPluginMode {
  string,

  /**
   * Used with networkPlugin=azure, pods are given IPs from the PodCIDR address space but use Azure Routing Domains rather than Kubenet's method of route tables. For more information visit https://aka.ms/aks/azure-cni-overlay.
   */
  overlay: "overlay",
}

/**
 * Network policy used for building the Kubernetes network.
 */
union NetworkPolicy {
  string,

  /**
   * Network policies will not be enforced. This is the default value when NetworkPolicy is not specified.
   */
  none: "none",

  /**
   * Use Calico network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.
   */
  calico: "calico",

  /**
   * Use Azure network policies. See [differences between Azure and Calico policies](https://docs.microsoft.com/azure/aks/use-network-policies#differences-between-azure-and-calico-policies-and-their-capabilities) for more information.
   */
  azure: "azure",

  /**
   * Use Cilium to enforce network policies. This requires networkDataplane to be 'cilium'.
   */
  cilium: "cilium",
}

/**
 * The network mode Azure CNI is configured with. This cannot be specified if networkPlugin is anything other than 'azure'.
 */
union NetworkMode {
  string,

  /**
   * No bridge is created. Intra-VM Pod to Pod communication is through IP routes created by Azure CNI. See [Transparent Mode](https://docs.microsoft.com/azure/aks/faq#transparent-mode) for more information.
   */
  transparent: "transparent",

  /**
   * This is no longer supported
   */
  bridge: "bridge",
}

/**
 * Network dataplane used in the Kubernetes cluster.
 */
union NetworkDataplane {
  string,

  /**
   * Use Azure network dataplane.
   */
  azure: "azure",

  /**
   * Use Cilium network dataplane. See [Azure CNI Powered by Cilium](https://learn.microsoft.com/azure/aks/azure-cni-powered-by-cilium) for more information.
   */
  cilium: "cilium",
}

/**
 * Enable advanced network policies. This allows users to configure Layer 7 network policies (FQDN, HTTP, Kafka). Policies themselves must be configured via the Cilium Network Policy resources, see https://docs.cilium.io/en/latest/security/policy/index.html. This can be enabled only on cilium-based clusters. If not specified, the default value is FQDN if security.enabled is set to true.
 */
union AdvancedNetworkPolicies {
  string,

  /**
   * Enable Layer7 network policies (FQDN, HTTP/S, Kafka). This option is a superset of the FQDN option.
   */
  L7: "L7",

  /**
   * Enable FQDN based network policies
   */
  FQDN: "FQDN",

  /**
   * Disable Layer 7 network policies (FQDN, HTTP/S, Kafka)
   */
  None: "None",
}

/**
 * The outbound (egress) routing method. This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).
 */
union OutboundType {
  string,

  /**
   * The load balancer is used for egress through an AKS assigned public IP. This supports Kubernetes services of type 'loadBalancer'. For more information see [outbound type loadbalancer](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-loadbalancer).
   */
  loadBalancer: "loadBalancer",

  /**
   * Egress paths must be defined by the user. This is an advanced scenario and requires proper network configuration. For more information see [outbound type userDefinedRouting](https://docs.microsoft.com/azure/aks/egress-outboundtype#outbound-type-of-userdefinedrouting).
   */
  userDefinedRouting: "userDefinedRouting",

  /**
   * The AKS-managed NAT gateway is used for egress.
   */
  managedNATGateway: "managedNATGateway",

  /**
   * The user-assigned NAT gateway associated to the cluster subnet is used for egress. This is an advanced scenario and requires proper network configuration.
   */
  userAssignedNATGateway: "userAssignedNATGateway",

  /**
   * The AKS cluster is not set with any outbound-type. All AKS nodes follows Azure VM default outbound behavior. Please refer to https://azure.microsoft.com/en-us/updates/default-outbound-access-for-vms-in-azure-will-be-retired-transition-to-a-new-method-of-internet-access/
   */
  none: "none",
}

/**
 * The load balancer sku for the managed cluster. The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.
 */
union LoadBalancerSku {
  string,

  /**
   * Use a a standard Load Balancer. This is the recommended Load Balancer SKU. For more information about on working with the load balancer in the managed cluster, see the [standard Load Balancer](https://docs.microsoft.com/azure/aks/load-balancer-standard) article.
   */
  standard: "standard",

  /**
   * Use a basic Load Balancer with limited functionality.
   */
  basic: "basic",
}

/**
 * The type of the managed inbound Load Balancer BackendPool.
 */
union BackendPoolType {
  string,

  /**
   * The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.
   */
  NodeIPConfiguration: "NodeIPConfiguration",

  /**
   * The type of the managed inbound Load Balancer BackendPool. https://cloud-provider-azure.sigs.k8s.io/topics/loadbalancer/#configure-load-balancer-backend.
   */
  NodeIP: "NodeIP",
}

/**
 * To determine if address belongs IPv4 or IPv6 family
 */
union IPFamily {
  string,

  /**
   * IPv4 family
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPv4: "IPv4",

  /**
   * IPv6 family
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPv6: "IPv6",
}

/**
 * The health probing behavior for External Traffic Policy Cluster services.
 */
@added(Versions.v2025_10_02_preview)
union ClusterServiceLoadBalancerHealthProbeMode {
  string,

  /**
   * Each External Traffic Policy Cluster service will have its own health probe targeting service nodePort.
   */
  ServiceNodePort: "ServiceNodePort",

  /**
   * All External Traffic Policy Cluster services in a Standard Load Balancer will have a dedicated health probe targeting the backend nodes' kube-proxy health check port 10256.
   */
  Shared: "Shared",
}

/**
 * Defines access to special link local addresses (Azure Instance Metadata Service, aka IMDS) for pods with hostNetwork=false. If not specified, the default is 'IMDS'.
 */
@added(Versions.v2025_10_02_preview)
union PodLinkLocalAccess {
  string,

  /**
   * Pods with hostNetwork=false can access Azure Instance Metadata Service (IMDS) without restriction.
   */
  IMDS: "IMDS",

  /**
   * Pods with hostNetwork=false cannot access Azure Instance Metadata Service (IMDS).
   */
  None: "None",
}

/**
 * Specify which proxy mode to use ('IPTABLES', 'IPVS' or 'NFTABLES')
 */
@added(Versions.v2025_10_02_preview)
union Mode {
  string,

  /**
   * IPTables proxy mode
   */
  IPTABLES: "IPTABLES",

  /**
   * IPVS proxy mode. Must be using Kubernetes version >= 1.22.
   */
  IPVS: "IPVS",

  /**
   * NFTables proxy mode. Must be using Kubernetes version >= 1.33.
   */
  NFTABLES: "NFTABLES",
}

/**
 * IPVS scheduler, for more information please see http://www.linuxvirtualserver.org/docs/scheduling.html.
 */
@added(Versions.v2025_10_02_preview)
union IpvsScheduler {
  string,

  /**
   * Round Robin
   */
  RoundRobin: "RoundRobin",

  /**
   * Least Connection
   */
  LeastConnection: "LeastConnection",
}

/**
 * Configures pod-to-pod encryption. This can be enabled only on Cilium-based clusters. If not specified, the default value is None.
 */
@added(Versions.v2025_10_02_preview)
union TransitEncryptionType {
  string,

  /**
   * Enable WireGuard encryption. Refer to https://docs.cilium.io/en/latest/security/network/encryption-wireguard/ on use cases and implementation details
   */
  WireGuard: "WireGuard",

  /**
   * Disable Transit encryption
   */
  None: "None",
}

/**
 * Enable advanced network acceleration options. This allows users to configure acceleration using BPF host routing. This can be enabled only with Cilium dataplane. If not specified, the default value is None (no acceleration). The acceleration mode can be changed on a pre-existing cluster. See https://aka.ms/acnsperformance for a detailed explanation
 */
@added(Versions.v2025_10_02_preview)
union AccelerationMode {
  string,

  /**
   * Enable eBPF host routing with veth device mode.
   */
  BpfVeth: "BpfVeth",

  /**
   * Disable acceleration options.
   */
  None: "None",
}

/**
 * The upgrade channel for auto upgrade. The default is 'none'. For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).
 */
union UpgradeChannel {
  string,

  /**
   * Automatically upgrade the cluster to the latest supported patch release on the latest supported minor version. In cases where the cluster is at a version of Kubernetes that is at an N-2 minor version where N is the latest supported minor version, the cluster first upgrades to the latest supported patch version on N-1 minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster first is upgraded to 1.18.6, then is upgraded to 1.19.1.
   */
  rapid: "rapid",

  /**
   * Automatically upgrade the cluster to the latest supported patch release on minor version N-1, where N is the latest supported minor version. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.18.6.
   */
  stable: "stable",

  /**
   * Automatically upgrade the cluster to the latest supported patch version when it becomes available while keeping the minor version the same. For example, if a cluster is running version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, your cluster is upgraded to 1.17.9.
   */
  patch: "patch",

  /**
   * Automatically upgrade the node image to the latest version available. Consider using nodeOSUpgradeChannel instead as that allows you to configure node OS patching separate from Kubernetes version patching
   */
  `node-image`: "node-image",

  /**
   * Disables auto-upgrades and keeps the cluster at its current version of Kubernetes.
   */
  none: "none",
}

/**
 * Node OS Upgrade Channel. Manner in which the OS on your nodes is updated. The default is NodeImage.
 */
union NodeOSUpgradeChannel {
  string,

  /**
   * No attempt to update your machines OS will be made either by OS or by rolling VHDs. This means you are responsible for your security updates
   */
  None: "None",

  /**
   * OS updates will be applied automatically through the OS built-in patching infrastructure. Newly scaled in machines will be unpatched initially and will be patched at some point by the OS's infrastructure. Behavior of this option depends on the OS in question. Ubuntu and Mariner apply security patches through unattended upgrade roughly once a day around 06:00 UTC. Windows does not apply security patches automatically and so for them this option is equivalent to None till further notice
   */
  Unmanaged: "Unmanaged",

  /**
   * AKS will update the nodes with a newly patched VHD containing security fixes and bugfixes on a weekly cadence. With the VHD update machines will be rolling reimaged to that VHD following maintenance windows and surge settings. No extra VHD cost is incurred when choosing this option as AKS hosts the images.
   */
  NodeImage: "NodeImage",

  /**
   * AKS downloads and updates the nodes with tested security updates. These updates honor the maintenance window settings and produce a new VHD that is used on new nodes. On some occasions it's not possible to apply the updates in place, in such cases the existing nodes will also be re-imaged to the newly produced VHD in order to apply the changes. This option incurs an extra cost of hosting the new Security Patch VHDs in your resource group for just in time consumption.
   */
  SecurityPatch: "SecurityPatch",
}

/**
 * The expander to use when scaling up. If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
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
 * Network access of the key vault. Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.
 */
union KeyVaultNetworkAccessTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Public: "Public",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Private: "Private",
}

/**
 * Whether to enable encryption at rest of Kubernetes resource objects using service-managed keys. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption.
 */
@added(Versions.v2025_10_02_preview)
union InfrastructureEncryption {
  string,

  /**
   * Encryption at rest of Kubernetes resource objects using service-managed keys is enabled. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption.
   */
  Enabled: "Enabled",

  /**
   * Encryption at rest of Kubernetes resource objects using service-managed keys is disabled. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption.
   */
  Disabled: "Disabled",
}

/**
 * Configuration for the managed Gateway API installation. If not specified, the default is 'Disabled'. See https://aka.ms/k8s-gateway-api for more details.
 */
union ManagedGatewayType {
  string,

  /**
   * Gateway API CRDs will not be reconciled on your cluster.
   */
  Disabled: "Disabled",

  /**
   * The latest Gateway CRD bundle from the standard channel that is compatible with your Kubernetes version will be reconciled onto your cluster. See https://gateway-api.sigs.k8s.io/concepts/versioning/ for more details.
   */
  Standard: "Standard",
}

/**
 * Ingress type for the default NginxIngressController custom resource
 */
union NginxIngressControllerType {
  string,

  /**
   * The default NginxIngressController will be created. Users can edit the default NginxIngressController Custom Resource to configure load balancer annotations.
   */
  AnnotationControlled: "AnnotationControlled",

  /**
   * The default NginxIngressController will be created and the operator will provision an external loadbalancer with it. Any annotation to make the default loadbalancer internal will be overwritten.
   */
  External: "External",

  /**
   * The default NginxIngressController will be created and the operator will provision an internal loadbalancer with it. Any annotation to make the default loadbalancer external will be overwritten.
   */
  Internal: "Internal",

  /**
   * The default Ingress Controller will not be created. It will not be deleted by the system if it exists. Users should delete the default NginxIngressController Custom Resource manually if desired.
   */
  None: "None",
}

/**
 * PublicNetworkAccess of the managedCluster. Allow or deny public network access for AKS
 */
union PublicNetworkAccess {
  string,

  /**
   * Inbound/Outbound to the managedCluster is allowed.
   */
  Enabled: "Enabled",

  /**
   * Inbound traffic to managedCluster is disabled, traffic from managedCluster is allowed.
   */
  Disabled: "Disabled",

  /**
   * Inbound/Outbound traffic is managed by Microsoft.Network/NetworkSecurityPerimeters.
   */
  @added(Versions.v2025_10_02_preview)
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Whether VPA add-on is enabled and configured to scale AKS-managed add-ons.
 */
@added(Versions.v2025_10_02_preview)
union AddonAutoscaling {
  string,

  /**
   * Feature to autoscale AKS-managed add-ons is enabled. The default VPA update mode is Initial mode.
   */
  Enabled: "Enabled",

  /**
   * Feature to autoscale AKS-managed add-ons is disabled.
   */
  Disabled: "Disabled",
}

/**
 * Mode of the service mesh.
 */
union ServiceMeshMode {
  string,

  /**
   * Istio deployed as an AKS addon.
   */
  Istio: "Istio",

  /**
   * Mesh is disabled.
   */
  Disabled: "Disabled",
}

/**
 * Mode of an ingress gateway.
 */
union IstioIngressGatewayMode {
  string,

  /**
   * The ingress gateway is assigned a public IP address and is publicly accessible.
   */
  External: "External",

  /**
   * The ingress gateway is assigned an internal IP address and cannot is accessed publicly.
   */
  Internal: "Internal",
}

/**
 * Mode of traffic redirection.
 */
@added(Versions.v2025_10_02_preview)
union ProxyRedirectionMechanism {
  string,

  /**
   * Istio will inject an init container into each pod to redirect traffic (requires NET_ADMIN and NET_RAW).
   */
  InitContainers: "InitContainers",

  /**
   * Istio will install a chained CNI plugin to redirect traffic (recommended).
   */
  CNIChaining: "CNIChaining",
}

/**
 * The node provisioning mode. If not specified, the default is Manual.
 */
union NodeProvisioningMode {
  string,

  /**
   * Nodes are provisioned manually by the user
   */
  Manual: "Manual",

  /**
   * Nodes are provisioned automatically by AKS using Karpenter (See aka.ms/aks/nap for more details). Fixed size Node Pools can still be created, but autoscaling Node Pools cannot be. (See aka.ms/aks/nap for more details).
   */
  Auto: "Auto",
}

/**
 * The set of default Karpenter NodePools (CRDs) configured for node provisioning. This field has no effect unless mode is 'Auto'. Warning: Changing this from Auto to None on an existing cluster will cause the default Karpenter NodePools to be deleted, which will drain and delete the nodes associated with those pools. It is strongly recommended to not do this unless there are idle nodes ready to take the pods evicted by that action. If not specified, the default is Auto. For more information see aka.ms/aks/nap#node-pools.
 */
union NodeProvisioningDefaultNodePools {
  string,

  /**
   * No Karpenter NodePools are provisioned automatically. Automatic scaling will not happen unless the user creates one or more NodePool CRD instances.
   */
  None: "None",

  /**
   * A standard set of Karpenter NodePools are provisioned
   */
  Auto: "Auto",
}

/**
 * The artifact source. The source where the artifacts are downloaded from.
 */
union ArtifactSource {
  string,

  /**
   * pull images from Azure Container Registry with cache
   */
  Cache: "Cache",

  /**
   * pull images from Microsoft Artifact Registry
   */
  Direct: "Direct",
}

/**
 * The config customization mode for this scheduler instance.
 */
@added(Versions.v2025_10_02_preview)
union SchedulerConfigMode {
  string,

  /**
   * No config customization. Use default configuration.
   */
  Default: "Default",

  /**
   * Enable config customization. Customer can specify scheduler configuration via a CRD. See aka.ms/aks/scheduler-crd for details.
   */
  ManagedByCRD: "ManagedByCRD",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Format {
  string,

  /**
   * Return azure auth-provider kubeconfig. This format is deprecated in v1.22 and will be fully removed in v1.26. See: https://aka.ms/k8s/changes-1-26.
   */
  azure: "azure",

  /**
   * Return exec format kubeconfig. This format requires kubelogin binary in the path.
   */
  exec: "exec",
}

/**
 * The weekday enum.
 */
union WeekDay {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sunday: "Sunday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Saturday: "Saturday",
}

/**
 * The week index. Specifies on which week of the month the dayOfWeek applies.
 */
union Type {
  string,

  /**
   * First week of the month.
   */
  First: "First",

  /**
   * Second week of the month.
   */
  Second: "Second",

  /**
   * Third week of the month.
   */
  Third: "Third",

  /**
   * Fourth week of the month.
   */
  Fourth: "Fourth",

  /**
   * Last week of the month.
   */
  Last: "Last",
}

/**
 * The current provisioning state of the namespace.
 */
union NamespaceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * Enum representing different network policy rules.
 */
union PolicyRule {
  string,

  /**
   * Deny all network traffic.
   */
  DenyAll: "DenyAll",

  /**
   * Allow all network traffic.
   */
  AllowAll: "AllowAll",

  /**
   * Allow traffic within the same namespace.
   */
  AllowSameNamespace: "AllowSameNamespace",
}

/**
 * Action if Kubernetes namespace with same name already exists.
 */
union AdoptionPolicy {
  string,

  /**
   * If the namespace already exists in Kubernetes, attempts to create that same namespace in ARM will fail.
   */
  Never: "Never",

  /**
   * Take over the existing namespace to be managed by ARM, if there is no difference.
   */
  IfIdentical: "IfIdentical",

  /**
   * Always take over the existing namespace to be managed by ARM, some fields might be overwritten.
   */
  Always: "Always",
}

/**
 * Delete options of a namespace.
 */
union DeletePolicy {
  string,

  /**
   * Only delete the ARM resource, keep the Kubernetes namespace. Also delete the ManagedByARM label.
   */
  Keep: "Keep",

  /**
   * Delete both the ARM resource and the Kubernetes namespace together.
   */
  Delete: "Delete",
}

/**
 * The drift action of the machine. Indicates whether a machine has deviated from its expected state due to changes in managed cluster properties, requiring corrective action.
 */
@added(Versions.v2025_10_02_preview)
union DriftAction {
  string,

  /**
   * The machine is up to date.
   */
  Synced: "Synced",

  /**
   * The machine has drifted and needs to be deleted and recreated.
   */
  Recreate: "Recreate",
}

/**
 * Virtual machine state. Indicates the current state of the underlying virtual machine.
 */
union VmState {
  string,

  /**
   * The virtual machine is currently running.
   */
  Running: "Running",

  /**
   * The virtual machine has been deleted by the user or due to spot eviction.
   */
  Deleted: "Deleted",
}

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
}

/**
 * The private link service connection status.
 */
union ConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * The type of a snapshot. The default is NodePool.
 */
union SnapshotType {
  string,

  /**
   * The snapshot is a snapshot of a node pool.
   */
  NodePool: "NodePool",

  /**
   * The snapshot is a snapshot of a managed cluster.
   */
  @added(Versions.v2025_10_02_preview)
  ManagedCluster: "ManagedCluster",
}

/**
 * The current provisioning state of trusted access role binding.
 */
union TrustedAccessRoleBindingProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * Whether the version is preview or stable.
 */
@added(Versions.v2025_10_02_preview)
union GuardrailsSupport {
  string,

  /**
   * The version is preview. It is not recommended to use preview versions on critical production clusters. The preview version may not support all use-cases.
   */
  Preview: "Preview",

  /**
   * The version is stable and can be used on critical production clusters.
   */
  Stable: "Stable",
}

/**
 * Whether the version is preview or stable.
 */
@added(Versions.v2025_10_02_preview)
union SafeguardsSupport {
  string,

  /**
   * The version is preview. It is not recommended to use preview versions on critical production clusters. The preview version may not support all use-cases.
   */
  Preview: "Preview",

  /**
   * The version is stable and can be used on critical production clusters.
   */
  Stable: "Stable",
}

/**
 * operator represents a key's relationship to a set of values. Valid operators are In and NotIn
 */
@added(Versions.v2025_10_02_preview)
union Operator {
  string,

  /**
   * The value of the key should be in the given list.
   */
  In: "In",

  /**
   * The value of the key should not be in the given list.
   */
  NotIn: "NotIn",

  /**
   * The value of the key should exist.
   */
  Exists: "Exists",

  /**
   * The value of the key should not exist.
   */
  DoesNotExist: "DoesNotExist",
}

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union IdentityBindingProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The identity binding is being created.
   */
  Creating: "Creating",

  /**
   * The identity binding is being updated.
   */
  Updating: "Updating",

  /**
   * The identity binding is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union JWTAuthenticatorProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The JWT authenticator is being created.
   */
  Creating: "Creating",

  /**
   * The JWT authenticator is being updated.
   */
  Updating: "Updating",

  /**
   * The JWT authenticator is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * The provisioning state of the last accepted operation.
 */
@added(Versions.v2025_10_02_preview)
union MeshMembershipProvisioningState {
  string,

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The Mesh Membership is being created.
   */
  Creating: "Creating",

  /**
   * The Mesh Membership is being deleted.
   */
  Deleting: "Deleting",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * The Mesh Membership is being updated.
   */
  Updating: "Updating",
}

/**
 * The type of identity used for the managed cluster. For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * The name of the operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Describes the properties of a Operation Value Display.
   */
  display?: OperationValueDisplay;
}

/**
 * Describes the properties of a Operation Value Display.
 */
model OperationValueDisplay {
  /**
   * The display name of the operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility(Lifecycle.Read)
  provider?: string;
}

/**
 * Hold values properties, which is array of KubernetesVersion
 */
model KubernetesVersionListResult {
  /**
   * Array of AKS supported Kubernetes versions.
   */
  @identifiers(#[])
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
   * Whether this version is default.
   */
  isDefault?: boolean;

  /**
   * Whether this version is in preview mode.
   */
  isPreview?: boolean;

  /**
   * Patch versions of Kubernetes release
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  patchVersions?: Record<KubernetesPatchVersion>;
}

/**
 * Capabilities on this Kubernetes version.
 */
model KubernetesVersionCapabilities {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Holds an array NodeImageVersions
 */
@added(Versions.v2025_10_02_preview)
model NodeImageVersionsListResult is Azure.Core.Page<NodeImageVersion>;

/**
 * node image version profile for given major.minor.patch release.
 */
@added(Versions.v2025_10_02_preview)
model NodeImageVersion {
  /**
   * The operating system of the node image. Example: AKSUbuntu
   */
  os?: string;

  /**
   * The SKU or flavor of the node image. Example: 2004gen2containerd
   */
  sku?: string;

  /**
   * major.minor.patch version of the node image version release. Example: 2024.02.02
   */
  version?: string;

  /**
   * The OS + SKU + version of the node image. Example: AKSUbuntu-1804gen2containerd-2024.02.02
   */
  fullName?: string;
}

/**
 * The SKU of a Managed Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterSKU {
  /**
   * The name of a managed cluster SKU.
   */
  name?: ManagedClusterSKUName;

  /**
   * The tier of a managed cluster SKU. If not specified, the default is 'Free'. See [AKS Pricing Tier](https://learn.microsoft.com/azure/aks/free-standard-pricing-tiers) for more details.
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the system assigned identity which is used by master components.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the managed cluster. For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).
   */
  type?: ResourceIdentityType;

  /**
   * The delegated identity resources assigned to this managed cluster. This can only be set by another Azure Resource Provider, and managed cluster only accept one delegated identity resource. Internal use only.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delegatedResources?: Record<CommonTypes.DelegatedResource>;

  /**
   * The user identity associated with the managed cluster. This identity will be used in control plane. Only one user assigned identity is allowed. The keys must be ARM resource IDs in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<ManagedServiceIdentityUserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedServiceIdentityUserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Properties of the managed cluster.
 */
model ManagedClusterProperties {
  /**
   * The current provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The Power State of the cluster.
   */
  @visibility(Lifecycle.Read)
  powerState?: PowerState;

  /**
   * CreationData to be used to specify the source Snapshot ID if the cluster will be created/upgraded using a snapshot.
   */
  @added(Versions.v2025_10_02_preview)
  creationData?: CreationData;

  /**
   * The max number of agent pools for the managed cluster.
   */
  @visibility(Lifecycle.Read)
  maxAgentPools?: int32;

  /**
   * The version of Kubernetes specified by the user. Both patch version <major.minor.patch> (e.g. 1.20.13) and <major.minor> (e.g. 1.20) are supported. When <major.minor> is specified, the latest supported GA patch version is chosen automatically. Updating the cluster with the same <major.minor> once it has been created (e.g. 1.14.x -> 1.14) will not trigger an upgrade, even if a newer patch version is available. When you upgrade a supported AKS cluster, Kubernetes minor versions cannot be skipped. All upgrades must be performed sequentially by major version number. For example, upgrades between 1.14.x -> 1.15.x or 1.15.x -> 1.16.x are allowed, however 1.14.x -> 1.16.x is not allowed. See [upgrading an AKS cluster](https://docs.microsoft.com/azure/aks/upgrade-cluster) for more details.
   */
  kubernetesVersion?: string;

  /**
   * The version of Kubernetes the Managed Cluster is running. If kubernetesVersion was a fully specified version <major.minor.patch>, this field will be exactly equal to it. If kubernetesVersion was <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility(Lifecycle.Read)
  currentKubernetesVersion?: string;

  /**
   * The DNS prefix of the Managed Cluster. This cannot be updated once the Managed Cluster has been created.
   */
  dnsPrefix?: string;

  /**
   * The FQDN subdomain of the private cluster with custom private dns zone. This cannot be updated once the Managed Cluster has been created.
   */
  fqdnSubdomain?: string;

  /**
   * The FQDN of the master pool.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The FQDN of private cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateFQDN?: string;

  /**
   * The special FQDN used by the Azure Portal to access the Managed Cluster. This FQDN is for use only by the Azure Portal and should not be used by other clients. The Azure Portal requires certain Cross-Origin Resource Sharing (CORS) headers to be sent in some responses, which Kubernetes APIServer doesn't handle by default. This special FQDN supports CORS, allowing the Azure Portal to function properly.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azurePortalFQDN?: string;

  /**
   * The agent pool properties.
   */
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  addonProfiles?: Record<ManagedClusterAddonProfile>;

  /**
   * The pod identity profile of the Managed Cluster. See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on AAD pod identity integration.
   */
  podIdentityProfile?: ManagedClusterPodIdentityProfile;

  /**
   * The OIDC issuer profile of the Managed Cluster.
   */
  oidcIssuerProfile?: ManagedClusterOIDCIssuerProfile;

  /**
   * The name of the resource group containing agent pool nodes.
   */
  nodeResourceGroup?: string;

  /**
   * Profile of the node resource group configuration.
   */
  nodeResourceGroupProfile?: ManagedClusterNodeResourceGroupProfile;

  /**
   * Whether to enable Kubernetes Role-Based Access Control.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableRBAC?: boolean;

  /**
   * The support plan for the Managed Cluster. If unspecified, the default is 'KubernetesOfficial'.
   */
  supportPlan?: KubernetesSupportPlan;

  /**
   * Enable namespace as Azure resource. The default value is false. It can be enabled/disabled on creation and updating of the managed cluster. See [https://aka.ms/NamespaceARMResource](https://aka.ms/NamespaceARMResource) for more details on Namespace as a ARM Resource.
   */
  @added(Versions.v2025_10_02_preview)
  enableNamespaceResources?: boolean;

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
   * The Resource ID of the disk encryption set to use for enabling encryption at rest. This is of the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/diskEncryptionSets/{encryptionSetName}'
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskEncryptionSetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/diskEncryptionSets";
    }
  ]>;

  /**
   * The user identity associated with the managed cluster. This identity will be used by the kubelet. Only one user assigned identity is allowed. The only accepted key is "kubeletidentity", with value of "resourceId": "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identityProfile?: Record<UserAssignedIdentity>;

  /**
   * Private link resources associated with the cluster.
   */
  privateLinkResources?: PrivateLinkResource[];

  /**
   * If local accounts should be disabled on the Managed Cluster. If set to true, getting static credentials will be disabled for this cluster. This must only be used on Managed Clusters that are AAD enabled. For more details see [disable local accounts](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts-preview).
   */
  disableLocalAccounts?: boolean;

  /**
   * Configurations for provisioning the cluster with HTTP proxy servers.
   */
  httpProxyConfig?: ManagedClusterHTTPProxyConfig;

  /**
   * Security profile for the managed cluster.
   */
  securityProfile?: ManagedClusterSecurityProfile;

  /**
   * Storage profile for the managed cluster.
   */
  storageProfile?: ManagedClusterStorageProfile;

  /**
   * Ingress profile for the managed cluster.
   */
  ingressProfile?: ManagedClusterIngressProfile;

  /**
   * PublicNetworkAccess of the managedCluster. Allow or deny public network access for AKS
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resourceUID?: string;

  /**
   * Optional cluster metrics configuration.
   */
  metricsProfile?: ManagedClusterMetricsProfile;

  /**
   * Node provisioning settings that apply to the whole cluster.
   */
  nodeProvisioningProfile?: ManagedClusterNodeProvisioningProfile;

  /**
   * Profile of the cluster bootstrap configuration.
   */
  bootstrapProfile?: ManagedClusterBootstrapProfile;

  /**
   * AI toolchain operator settings that apply to the whole cluster.
   */
  aiToolchainOperatorProfile?: ManagedClusterAIToolchainOperatorProfile;

  /**
   * Profile of the pod scheduler configuration.
   */
  @added(Versions.v2025_10_02_preview)
  schedulerProfile?: SchedulerProfile;

  /**
   * Settings for hosted system addons. For more information, see https://aka.ms/aks/automatic/systemcomponents.
   */
  @added(Versions.v2025_10_02_preview)
  hostedSystemProfile?: ManagedClusterHostedSystemProfile;

  /**
   * Contains read-only information about the Managed Cluster.
   */
  status?: ManagedClusterStatus;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAgentPoolProfile
  extends ManagedClusterAgentPoolProfileProperties {
  /**
   * Unique name of the agent pool profile in the context of the subscription and resource group. Windows agent pool names must be 6 characters or less.
   */
  @pattern("^[a-z][a-z0-9]{0,11}$")
  name: string;
}

/**
 * Properties for the container service agent pool profile.
 */
model ManagedClusterAgentPoolProfileProperties {
  /**
   * Unique read-only string used to implement optimistic concurrency. The eTag value will change when the resource is updated. Specify an if-match or if-none-match header with the eTag value for a subsequent request to enable optimistic concurrency per the normal eTag convention.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Number of agents (VMs) to host docker containers. Allowed values must be in the range of 0 to 1000 (inclusive) for user pools and in the range of 1 to 1000 (inclusive) for system pools. The default value is 1.
   */
  count?: int32;

  /**
   * The size of the agent pool VMs. VM size availability varies by region. If a node contains insufficient compute resources (memory, cpu, etc) pods might fail to run correctly. For more details on restricted VM sizes, see: https://docs.microsoft.com/azure/aks/quotas-skus-regions
   */
  vmSize?: string;

  /**
   * OS Disk Size in GB to be used to specify the disk size for every machine in the master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(2048)
  @minValue(0)
  osDiskSizeGB?: int32;

  /**
   * The OS disk type to be used for machines in the agent pool. The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
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
   * Message of the day for Linux nodes, base64-encoded. A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It must not be specified for Windows nodes. It must be a static string (i.e., will be printed raw and not be executed as a script).
   */
  messageOfTheDay?: string;

  /**
   * The ID of the subnet which agent pool nodes and optionally pods will join on startup. If this is not specified, a VNET and subnet will be generated and used. If no podSubnetID is specified, this applies to nodes and pods, otherwise it applies to just nodes. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vnetSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The ID of the subnet which pods will join when launched. If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  podSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Pod IP Allocation Mode. The IP allocation mode for pods in the agent pool. Must be used with podSubnetId. The default is 'DynamicIndividual'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  podIPAllocationMode?: PodIPAllocationMode;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  osSKU?: OSSKU;

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
   * The scale down mode to use when scaling the Agent Pool. This also effects the cluster autoscaler behavior. If not specified, it defaults to Delete.
   */
  scaleDownMode?: ScaleDownMode;

  /**
   * The type of Agent Pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: AgentPoolType;

  /**
   * The mode of an agent pool. A cluster must have at least one 'System' Agent Pool at all times. For additional information on agent pool restrictions and best practices, see: https://docs.microsoft.com/azure/aks/use-system-pools
   */
  mode?: AgentPoolMode;

  /**
   * The version of Kubernetes specified by the user. Both patch version <major.minor.patch> (e.g. 1.20.13) and <major.minor> (e.g. 1.20) are supported. When <major.minor> is specified, the latest supported GA patch version is chosen automatically. Updating the cluster with the same <major.minor> once it has been created (e.g. 1.14.x -> 1.14) will not trigger an upgrade, even if a newer patch version is available. As a best practice, you should upgrade all node pools in an AKS cluster to the same Kubernetes version. The node pool version must have the same major version as the control plane. The node pool minor version must be within two minor versions of the control plane version. The node pool version cannot be greater than the control plane version. For more information see [upgrading a node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#upgrade-a-node-pool).
   */
  orchestratorVersion?: string;

  /**
   * The version of Kubernetes the Agent Pool is running. If orchestratorVersion is a fully specified version <major.minor.patch>, this field will be exactly equal to it. If orchestratorVersion is <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility(Lifecycle.Read)
  currentOrchestratorVersion?: string;

  /**
   * The version of node image
   */
  @visibility(Lifecycle.Read)
  nodeImageVersion?: string;

  /**
   * Defines the upgrade strategy for the agent pool. The default is Rolling.
   */
  @added(Versions.v2025_10_02_preview)
  upgradeStrategy?: UpgradeStrategy;

  /**
   * Settings for upgrading the agentpool
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * Settings for Blue-Green upgrade on the agentpool. Applies when upgrade strategy is set to BlueGreen.
   */
  @added(Versions.v2025_10_02_preview)
  upgradeSettingsBlueGreen?: AgentPoolBlueGreenUpgradeSettings;

  /**
   * The current deployment or provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Whether the Agent Pool is running or stopped. When an Agent Pool is first created it is initially Running. The Agent Pool can be stopped by setting this field to Stopped. A stopped Agent Pool stops all of its VMs and does not accrue billing charges. An Agent Pool can only be stopped if it is Running and provisioning state is Succeeded
   */
  powerState?: PowerState;

  /**
   * The list of Availability zones to use for nodes. This can only be specified if the AgentPoolType property is 'VirtualMachineScaleSets'.
   */
  availabilityZones?: string[];

  /**
   * Whether each node is allocated its own public IP. Some scenarios may require nodes in a node pool to receive their own dedicated public IP addresses. A common scenario is for gaming workloads, where a console needs to make a direct connection to a cloud virtual machine to minimize hops. For more information see [assigning a public IP per node](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#assign-a-public-ip-per-node-for-your-node-pools). The default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableNodePublicIP?: boolean;

  /**
   * The public IP prefix ID which VM nodes should use IPs from. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodePublicIPPrefixID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * The Virtual Machine Scale Set priority.
   */
  scaleSetPriority?: ScaleSetPriority = ScaleSetPriority.Regular;

  /**
   * The Virtual Machine Scale Set eviction policy. The eviction policy specifies what to do with the VM when it is evicted. The default is Delete. For more information about eviction see [spot VMs](https://docs.microsoft.com/azure/virtual-machines/spot-vms)
   */
  scaleSetEvictionPolicy?: ScaleSetEvictionPolicy = ScaleSetEvictionPolicy.Delete;

  /**
   * The max price (in US Dollars) you are willing to pay for spot instances. Possible values are any decimal value greater than zero or -1 which indicates default price to be up-to on-demand. Possible values are any decimal value greater than zero or -1 which indicates the willingness to pay any on-demand price. For more details on spot pricing, see [spot VMs pricing](https://docs.microsoft.com/azure/virtual-machines/spot-vms#pricing)
   */
  spotMaxPrice?: float32 = -1;

  /**
   * The tags to be persisted on the agent pool virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodeLabels?: Record<string>;

  /**
   * The taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * Taints added on the nodes during creation that will not be reconciled by AKS. These taints will not be reconciled by AKS and can be removed with a kubectl call. This field can be modified after node pool is created, but nodes will not be recreated with new taints until another operation that requires recreation (e.g. node image upgrade) happens. These taints allow for required configuration to run before the node is ready to accept workloads, for example 'key1=value1:NoSchedule' that then can be removed with `kubectl taint nodes node1 key1=value1:NoSchedule-`
   */
  @added(Versions.v2025_10_02_preview)
  nodeInitializationTaints?: string[];

  /**
   * The ID for Proximity Placement Group.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  proximityPlacementGroupID?: Azure.Core.armResourceIdentifier<[
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  linuxOSConfig?: LinuxOSConfig;

  /**
   * Whether to enable host based OS and data drive encryption. This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption
   */
  enableEncryptionAtHost?: boolean;

  /**
   * Whether to enable UltraSSD
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableUltraSSD?: boolean;

  /**
   * Whether to use a FIPS-enabled OS. See [Add a FIPS-enabled node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview) for more details.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableFIPS?: boolean;

  /**
   * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
   */
  gpuInstanceProfile?: GPUInstanceProfile;

  /**
   * CreationData to be used to specify the source Snapshot ID if the node pool will be created/upgraded using a snapshot.
   */
  creationData?: CreationData;

  /**
   * The fully qualified resource ID of the Capacity Reservation Group to provide virtual machines from a reserved group of Virtual Machines. This is of the form: '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Compute/capacityreservationgroups/{capacityReservationGroupName}' Customers use it to create an agentpool with a specified CRG. For more information see [Capacity Reservation](https://learn.microsoft.com/en-us/azure/virtual-machines/capacity-reservation-overview)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  capacityReservationGroupID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/CapacityReservationGroups";
    }
  ]>;

  /**
   * The fully qualified resource ID of the Dedicated Host Group to provision virtual machines from, used only in creation scenario and not allowed to changed once set. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}. For more information see [Azure dedicated hosts](https://docs.microsoft.com/azure/virtual-machines/dedicated-hosts).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostGroupID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/hostGroups";
    }
  ]>;

  /**
   * Network-related settings of an agent pool.
   */
  networkProfile?: AgentPoolNetworkProfile;

  /**
   * The Windows agent pool's specific profile.
   */
  windowsProfile?: AgentPoolWindowsProfile;

  /**
   * The security settings of an agent pool.
   */
  securityProfile?: AgentPoolSecurityProfile;

  /**
   * GPU settings for the Agent Pool.
   */
  gpuProfile?: GPUProfile;

  /**
   * Profile specific to a managed agent pool in Gateway mode. This field cannot be set if agent pool mode is not Gateway.
   */
  gatewayProfile?: AgentPoolGatewayProfile;

  /**
   * Configuration for using artifact streaming on AKS.
   */
  @added(Versions.v2025_10_02_preview)
  artifactStreamingProfile?: AgentPoolArtifactStreamingProfile;

  /**
   * Specifications on VirtualMachines agent pool.
   */
  virtualMachinesProfile?: VirtualMachinesProfile;

  /**
   * The status of nodes in a VirtualMachines agent pool.
   */
  @identifiers(#[])
  virtualMachineNodesStatus?: VirtualMachineNodes[];

  /**
   * Contains read-only information about the Agent Pool.
   */
  status?: AgentPoolStatus;

  /**
   * Configures the per-node local DNS, with VnetDNS and KubeDNS overrides. LocalDNS helps improve performance and reliability of DNS resolution in an AKS cluster. For more details see aka.ms/aks/localdns.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localDNSProfile?: LocalDNSProfile;

  /**
   * Settings to determine the node customization used to provision nodes in a pool.
   */
  @added(Versions.v2025_10_02_preview)
  nodeCustomizationProfile?: NodeCustomizationProfile;
}

/**
 * Settings for upgrading an agentpool
 */
model AgentPoolUpgradeSettings {
  /**
   * The maximum number or percentage of nodes that are surged during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 10%. For more information, including best practices, see: https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster
   */
  maxSurge?: string;

  /**
   * The maximum number or percentage of nodes that can be simultaneously unavailable during upgrade. This can either be set to an integer (e.g. '1') or a percentage (e.g. '5%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is 0. For more information, including best practices, see: https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster
   */
  maxUnavailable?: string;

  /**
   * The maximum number or percentage of extra nodes that are allowed to be blocked in the agent pool during an upgrade when undrainable node behavior is Cordon. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified, the default is maxSurge. This must always be greater than or equal to maxSurge. For more information, including best practices, see: https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster
   */
  @added(Versions.v2025_10_02_preview)
  maxBlockedNodes?: string;

  /**
   * The drain timeout for a node. The amount of time (in minutes) to wait on eviction of pods and graceful termination per node. This eviction wait time honors waiting on pod disruption budgets. If this time is exceeded, the upgrade fails. If not specified, the default is 30 minutes.
   */
  @maxValue(1440)
  @minValue(1)
  drainTimeoutInMinutes?: int32;

  /**
   * The soak duration for a node. The amount of time (in minutes) to wait after draining a node and before reimaging it and moving on to next node. If not specified, the default is 0 minutes.
   */
  @maxValue(30)
  @minValue(0)
  nodeSoakDurationInMinutes?: int32;

  /**
   * Defines the behavior for undrainable nodes during upgrade. The most common cause of undrainable nodes is Pod Disruption Budgets (PDBs), but other issues, such as pod termination grace period is exceeding the remaining per-node drain timeout or pod is still being in a running state, can also cause undrainable nodes.
   */
  undrainableNodeBehavior?: UndrainableNodeBehavior;
}

/**
 * Settings for blue-green upgrade on an agentpool
 */
@added(Versions.v2025_10_02_preview)
model AgentPoolBlueGreenUpgradeSettings {
  /**
   * The number or percentage of nodes to drain in batch during blue-green upgrade. Must be a non-zero number. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total number of blue nodes of the initial upgrade operation. For percentages, fractional nodes are rounded up. If not specified, the default is 10%. For more information, including best practices, see: https://learn.microsoft.com/en-us/azure/aks/upgrade-cluster
   */
  drainBatchSize?: string;

  /**
   * The drain timeout for a node, i.e., the amount of time (in minutes) to wait on eviction of pods and graceful termination per node. This eviction wait time honors waiting on pod disruption budgets. If this time is exceeded, the upgrade fails. If not specified, the default is 30 minutes.
   */
  @maxValue(1440)
  @minValue(1)
  drainTimeoutInMinutes?: int32;

  /**
   * The soak duration after draining a batch of nodes, i.e., the amount of time (in minutes) to wait after draining a batch of nodes before moving on the next batch. If not specified, the default is 15 minutes.
   */
  @maxValue(1440)
  @minValue(0)
  batchSoakDurationInMinutes?: int32;

  /**
   * The soak duration for a node pool, i.e., the amount of time (in minutes) to wait after all old nodes are drained before we remove the old nodes. If not specified, the default is 60 minutes. Only applicable for blue-green upgrade strategy.
   */
  @maxValue(10080)
  @minValue(0)
  finalSoakDurationInMinutes?: int32;
}

/**
 * Kubelet configurations of agent nodes. See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.
 */
model KubeletConfig {
  /**
   * The CPU Manager policy to use. The default is 'none'. See [Kubernetes CPU management policies](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#cpu-management-policies) for more information. Allowed values are 'none' and 'static'.
   */
  cpuManagerPolicy?: string;

  /**
   * If CPU CFS quota enforcement is enabled for containers that specify CPU limits. The default is true.
   */
  cpuCfsQuota?: boolean;

  /**
   * The CPU CFS quota period value. The default is '100ms.' Valid values are a sequence of decimal numbers with an optional fraction and a unit suffix. For example: '300ms', '2h45m'. Supported units are 'ns', 'us', 'ms', 's', 'm', and 'h'.
   */
  cpuCfsQuotaPeriod?: string;

  /**
   * The percent of disk usage after which image garbage collection is always run. To disable image garbage collection, set to 100. The default is 85%
   */
  imageGcHighThreshold?: int32;

  /**
   * The percent of disk usage before which image garbage collection is never run. This cannot be set higher than imageGcHighThreshold. The default is 80%
   */
  imageGcLowThreshold?: int32;

  /**
   * The Topology Manager policy to use. For more information see [Kubernetes Topology Manager](https://kubernetes.io/docs/tasks/administer-cluster/topology-manager). The default is 'none'. Allowed values are 'none', 'best-effort', 'restricted', and 'single-numa-node'.
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  /**
   * Specifies the default seccomp profile applied to all workloads. If not specified, 'Unconfined' will be used by default.
   */
  @added(Versions.v2025_10_02_preview)
  seccompDefault?: SeccompDefault;
}

/**
 * OS configurations of Linux agent nodes. See [AKS custom node configuration](https://docs.microsoft.com/azure/aks/custom-node-configuration) for more details.
 */
model LinuxOSConfig {
  /**
   * Sysctl settings for Linux agent nodes.
   */
  sysctls?: SysctlConfig;

  /**
   * Whether transparent hugepages are enabled. Valid values are 'always', 'madvise', and 'never'. The default is 'always'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).
   */
  transparentHugePageEnabled?: string;

  /**
   * Whether the kernel should make aggressive use of memory compaction to make more hugepages available. Valid values are 'always', 'defer', 'defer+madvise', 'madvise' and 'never'. The default is 'madvise'. For more information see [Transparent Hugepages](https://www.kernel.org/doc/html/latest/admin-guide/mm/transhuge.html#admin-guide-transhuge).
   */
  transparentHugePageDefrag?: string;

  /**
   * The size in MB of a swap file that will be created on each node.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  sourceResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Network settings of an agent pool.
 */
model AgentPoolNetworkProfile {
  /**
   * IPTags of instance-level public IPs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  nodePublicIPTags?: IPTag[];

  /**
   * The port ranges that are allowed to access. The specified ranges are allowed to overlap.
   */
  @identifiers(#[])
  allowedHostPorts?: PortRange[];

  /**
   * The IDs of the application security groups which agent pool will associate when created.
   */
  applicationSecurityGroups?: Azure.Core.armResourceIdentifier<[
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
 * The Windows agent pool's specific profile.
 */
model AgentPoolWindowsProfile {
  /**
   * Whether to disable OutboundNAT in windows nodes. The default value is false. Outbound NAT can only be disabled if the cluster outboundType is NAT Gateway and the Windows agent pool does not have node public IP enabled.
   */
  disableOutboundNat?: boolean;
}

/**
 * The security settings of an agent pool.
 */
model AgentPoolSecurityProfile {
  /**
   * vTPM is a Trusted Launch feature for configuring a dedicated secure vault for keys and measurements held locally on the node. For more details, see aka.ms/aks/trustedlaunch. If not specified, the default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableVTPM?: boolean;

  /**
   * Secure Boot is a feature of Trusted Launch which ensures that only signed operating systems and drivers can boot. For more details, see aka.ms/aks/trustedlaunch.  If not specified, the default is false.
   */
  enableSecureBoot?: boolean;

  /**
   * SSH access method of an agent pool.
   */
  sshAccess?: AgentPoolSSHAccess;
}

/**
 * The security settings of the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineSecurityProfile {
  /**
   * vTPM is a Trusted Launch feature for configuring a dedicated secure vault for keys and measurements held locally on the node. For more details, see aka.ms/aks/trustedlaunch. If not specified, the default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableVTPM?: boolean;

  /**
   * Secure Boot is a feature of Trusted Launch which ensures that only signed operating systems and drivers can boot. For more details, see aka.ms/aks/trustedlaunch.  If not specified, the default is false.
   */
  enableSecureBoot?: boolean;

  /**
   * SSH access method of an agent pool.
   */
  sshAccess?: AgentPoolSSHAccess;

  /**
   * Whether to enable host based OS and data drive encryption. This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption
   */
  enableEncryptionAtHost?: boolean;
}

/**
 * GPU settings for the Agent Pool.
 */
model GPUProfile {
  /**
   * Whether to install GPU drivers. When it's not specified, default is Install.
   */
  driver?: GPUDriver;

  /**
   * Specify the type of GPU driver to install when creating Windows agent pools. If not provided, AKS selects the driver based on system compatibility. This cannot be changed once the AgentPool has been created. This cannot be set on Linux AgentPools. For Linux AgentPools, the driver is selected based on system compatibility.
   */
  @added(Versions.v2025_10_02_preview)
  driverType?: DriverType;
}

/**
 * Profile of the managed cluster gateway agent pool.
 */
model AgentPoolGatewayProfile {
  /**
   * The Gateway agent pool associates one public IPPrefix for each static egress gateway to provide public egress. The size of Public IPPrefix should be selected by the user. Each node in the agent pool is assigned with one IP from the IPPrefix. The IPPrefix size thus serves as a cap on the size of the Gateway agent pool. Due to Azure public IPPrefix size limitation, the valid value range is [28, 31] (/31 = 2 nodes/IPs, /30 = 4 nodes/IPs, /29 = 8 nodes/IPs, /28 = 16 nodes/IPs). The default value is 31.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(31)
  @minValue(28)
  publicIPPrefixSize?: int32 = 31;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model AgentPoolArtifactStreamingProfile {
  /**
   * Artifact streaming speeds up the cold-start of containers on a node through on-demand image loading. To use this feature, container images must also enable artifact streaming on ACR. If not specified, the default is false.
   */
  enabled?: boolean;
}

/**
 * Specifications on VirtualMachines agent pool.
 */
model VirtualMachinesProfile {
  /**
   * Specifications on how to scale a VirtualMachines agent pool.
   */
  scale?: ScaleProfile;
}

/**
 * Specifications on how to scale a VirtualMachines agent pool.
 */
model ScaleProfile {
  /**
   * Specifications on how to scale the VirtualMachines agent pool to a fixed size.
   */
  @identifiers(#[])
  manual?: ManualScaleProfile[];

  /**
   * Specifications on how to auto-scale the VirtualMachines agent pool within a predefined size range.
   */
  @added(Versions.v2025_10_02_preview)
  autoscale?: AutoScaleProfile;
}

/**
 * Specifications on number of machines.
 */
model ManualScaleProfile {
  /**
   * VM size that AKS will use when creating and scaling e.g. 'Standard_E4s_v3', 'Standard_E16s_v3' or 'Standard_D16s_v5'.
   */
  size?: string;

  /**
   * Number of nodes.
   */
  count?: int32;
}

/**
 * Specifications on auto-scaling.
 */
@added(Versions.v2025_10_02_preview)
model AutoScaleProfile {
  /**
   * VM size that AKS will use when creating and scaling e.g. 'Standard_E4s_v3', 'Standard_E16s_v3' or 'Standard_D16s_v5'.
   */
  size?: string;

  /**
   * The minimum number of nodes of the specified sizes.
   */
  minCount?: int32;

  /**
   * The maximum number of nodes of the specified sizes.
   */
  maxCount?: int32;
}

/**
 * Current status on a group of nodes of the same vm size.
 */
model VirtualMachineNodes {
  /**
   * The VM size of the agents used to host this group of nodes.
   */
  size?: string;

  /**
   * Number of nodes.
   */
  count?: int32;
}

/**
 * Contains read-only information about the Agent Pool.
 */
model AgentPoolStatus {
  /**
   * The error detail information of the agent pool. Preserves the detailed info of failure. If there was no error, this field is omitted.
   */
  @visibility(Lifecycle.Read)
  provisioningError?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Configures the per-node local DNS, with VnetDNS and KubeDNS overrides. LocalDNS helps improve performance and reliability of DNS resolution in an AKS cluster. For more details see aka.ms/aks/localdns.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalDNSProfile {
  /**
   * Mode of enablement for localDNS.
   */
  mode?: LocalDNSMode = LocalDNSMode.Preferred;

  /**
   * System-generated state of localDNS.
   */
  @visibility(Lifecycle.Read)
  state?: LocalDNSState;

  /**
   * VnetDNS overrides apply to DNS traffic from pods with dnsPolicy:default or kubelet (referred to as VnetDNS traffic).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vnetDNSOverrides?: Record<LocalDNSOverride>;

  /**
   * KubeDNS overrides apply to DNS traffic from pods with dnsPolicy:ClusterFirst (referred to as KubeDNS traffic).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kubeDNSOverrides?: Record<LocalDNSOverride>;
}

/**
 * Overrides for localDNS profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalDNSOverride {
  /**
   * Log level for DNS queries in localDNS.
   */
  queryLogging?: LocalDNSQueryLogging = LocalDNSQueryLogging.Error;

  /**
   * Enforce TCP or prefer UDP protocol for connections from localDNS to upstream DNS server.
   */
  protocol?: LocalDNSProtocol = LocalDNSProtocol.PreferUDP;

  /**
   * Destination server for DNS queries to be forwarded from localDNS.
   */
  forwardDestination?: LocalDNSForwardDestination = LocalDNSForwardDestination.ClusterCoreDNS;

  /**
   * Forward policy for selecting upstream DNS server. See [forward plugin](https://coredns.io/plugins/forward) for more information.
   */
  forwardPolicy?: LocalDNSForwardPolicy = LocalDNSForwardPolicy.Sequential;

  /**
   * Maximum number of concurrent queries. See [forward plugin](https://coredns.io/plugins/forward) for more information.
   */
  maxConcurrent?: int32 = 1000;

  /**
   * Cache max TTL in seconds. See [cache plugin](https://coredns.io/plugins/cache) for more information.
   */
  cacheDurationInSeconds?: int32 = 3600;

  /**
   * Serve stale duration in seconds. See [cache plugin](https://coredns.io/plugins/cache) for more information.
   */
  serveStaleDurationInSeconds?: int32 = 3600;

  /**
   * Policy for serving stale data. See [cache plugin](https://coredns.io/plugins/cache) for more information.
   */
  serveStale?: LocalDNSServeStale = LocalDNSServeStale.Immediate;
}

/**
 * Settings to determine the node customization used to provision nodes in a pool.
 */
@added(Versions.v2025_10_02_preview)
model NodeCustomizationProfile {
  /**
   * The resource ID of the node customization resource to use. This can be a version. Omitting the version will use the latest version of the node customization.
   */
  nodeCustomizationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/nodeCustomizations";
    }
  ]>;
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
  @identifiers(#[])
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

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length:** 8 characters <br><br> **Max-length:** 123 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\"")
  adminPassword?: string;

  /**
   * The license type to use for Windows VMs. See [Azure Hybrid User Benefits](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for more details.
   */
  licenseType?: LicenseType;

  /**
   * Whether to enable CSI proxy. For more details on CSI proxy, see the [CSI proxy GitHub repo](https://github.com/kubernetes-csi/csi-proxy).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableCSIProxy?: boolean;

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
   * Whether to enable Windows gMSA. Specifies whether to enable Windows gMSA in the managed cluster.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  config?: Record<string>;

  /**
   * Information of user assigned identity used by this add-on.
   */
  @visibility(Lifecycle.Read)
  identity?: ManagedClusterAddonProfileIdentity;
}

/**
 * Information of user assigned identity used by this add-on.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAddonProfileIdentity extends UserAssignedIdentity {}

/**
 * Details about a user assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The resource ID of the user assigned identity.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  /**
   * The client ID of the user assigned identity.
   */
  clientId?: string;

  /**
   * The object ID of the user assigned identity.
   */
  objectId?: string;
}

/**
 * The pod identity profile of the Managed Cluster. See [use AAD pod identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity) for more details on pod identity integration.
 */
model ManagedClusterPodIdentityProfile {
  /**
   * Whether the pod identity addon is enabled.
   */
  enabled?: boolean;

  /**
   * Whether pod identity is allowed to run on clusters with Kubenet networking. Running in Kubenet is disabled by default due to the security related nature of AAD Pod Identity and the risks of IP spoofing. See [using Kubenet network plugin with AAD Pod Identity](https://docs.microsoft.com/azure/aks/use-azure-ad-pod-identity#using-kubenet-network-plugin-with-azure-active-directory-pod-managed-identities) for more information.
   */
  allowNetworkPluginKubenet?: boolean;

  /**
   * The pod identities to use in the cluster.
   */
  @identifiers(#[])
  userAssignedIdentities?: ManagedClusterPodIdentity[];

  /**
   * The pod identity exceptions to allow.
   */
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedClusterPodIdentityProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningInfo?: ManagedClusterPodIdentityProvisioningInfo;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
  details?: ManagedClusterPodIdentityProvisioningErrorBody[];
}

/**
 * A pod identity exception, which allows pods with certain labels to access the Azure Instance Metadata Service (IMDS) endpoint without being intercepted by the node-managed identity (NMI) server. See [disable AAD Pod Identity for a specific Pod/Application](https://azure.github.io/aad-pod-identity/docs/configure/application_exception/) for more details.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  podLabels: Record<string>;
}

/**
 * The OIDC issuer profile of the Managed Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterOIDCIssuerProfile {
  /**
   * The OIDC issuer url of the Managed Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  issuerURL?: string;

  /**
   * Whether the OIDC issuer is enabled.
   */
  enabled?: boolean;
}

/**
 * Node resource group lockdown profile for a managed cluster.
 */
model ManagedClusterNodeResourceGroupProfile {
  /**
   * The restriction level applied to the cluster's node resource group. If not specified, the default is 'Unrestricted'
   */
  restrictionLevel?: RestrictionLevel;
}

/**
 * Profile of network configuration.
 */
model ContainerServiceNetworkProfile {
  /**
   * Network plugin used for building the Kubernetes network.
   */
  networkPlugin?: NetworkPlugin;

  /**
   * The mode the network plugin should use.
   */
  networkPluginMode?: NetworkPluginMode;

  /**
   * Network policy used for building the Kubernetes network.
   */
  networkPolicy?: NetworkPolicy;

  /**
   * The network mode Azure CNI is configured with. This cannot be specified if networkPlugin is anything other than 'azure'.
   */
  networkMode?: NetworkMode;

  /**
   * Network dataplane used in the Kubernetes cluster.
   */
  networkDataplane?: NetworkDataplane;

  /**
   * Advanced Networking profile for enabling observability and security feature suite on a cluster. For more information see aka.ms/aksadvancednetworking.
   */
  advancedNetworking?: AdvancedNetworking;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  dnsServiceIP?: string = "10.0.0.10";

  /**
   * The outbound (egress) routing method. This can only be set at cluster creation time and cannot be changed later. For more information see [egress outbound type](https://docs.microsoft.com/azure/aks/egress-outboundtype).
   */
  outboundType?: OutboundType = OutboundType.loadBalancer;

  /**
   * The load balancer sku for the managed cluster. The default is 'standard'. See [Azure Load Balancer SKUs](https://docs.microsoft.com/azure/load-balancer/skus) for more information about the differences between load balancer SKUs.
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
   * The profile for Static Egress Gateway addon. For more details about Static Egress Gateway, see https://aka.ms/aks/static-egress-gateway.
   */
  staticEgressGatewayProfile?: ManagedClusterStaticEgressGatewayProfile;

  /**
   * The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  podCidrs?: string[];

  /**
   * The CIDR notation IP ranges from which to assign service cluster IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking. They must not overlap with any Subnet IP ranges.
   */
  serviceCidrs?: string[];

  /**
   * The IP families used to specify IP versions available to the cluster. IP families are used to determine single-stack or dual-stack clusters. For single-stack, the expected value is IPv4. For dual-stack, the expected values are IPv4 and IPv6.
   */
  ipFamilies?: IPFamily[];

  /**
   * Defines access to special link local addresses (Azure Instance Metadata Service, aka IMDS) for pods with hostNetwork=false. if not specified, the default is 'IMDS'.
   */
  @added(Versions.v2025_10_02_preview)
  podLinkLocalAccess?: PodLinkLocalAccess;

  /**
   * Holds configuration customizations for kube-proxy. Any values not defined will use the kube-proxy defaulting behavior. See https://v<version>.docs.kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/ where <version> is represented by a <major version>-<minor version> string. Kubernetes version 1.23 would be '1-23'.
   */
  @added(Versions.v2025_10_02_preview)
  kubeProxyConfig?: ContainerServiceNetworkProfileKubeProxyConfig;
}

/**
 * Advanced Networking profile for enabling observability and security feature suite on a cluster. For more information see aka.ms/aksadvancednetworking.
 */
model AdvancedNetworking {
  /**
   * Indicates the enablement of Advanced Networking functionalities of observability and security on AKS clusters. When this is set to true, all observability and security features will be set to enabled unless explicitly disabled. If not specified, the default is false.
   */
  enabled?: boolean;

  /**
   * Observability profile to enable advanced network metrics and flow logs with historical contexts.
   */
  observability?: AdvancedNetworkingObservability;

  /**
   * Security profile to enable security features on cilium based cluster.
   */
  security?: AdvancedNetworkingSecurity;

  /**
   * Profile to enable performance-enhancing features on clusters that use Azure CNI powered by Cilium.
   */
  @added(Versions.v2025_10_02_preview)
  performance?: AdvancedNetworkingPerformance;
}

/**
 * Observability profile to enable advanced network metrics and flow logs with historical contexts.
 */
model AdvancedNetworkingObservability {
  /**
   * Indicates the enablement of Advanced Networking observability functionalities on clusters.
   */
  enabled?: boolean;
}

/**
 * Security profile to enable security features on cilium based cluster.
 */
model AdvancedNetworkingSecurity {
  /**
   * This feature allows user to configure network policy based on DNS (FQDN) names. It can be enabled only on cilium based clusters. If not specified, the default is false.
   */
  enabled?: boolean;

  /**
   * Enable advanced network policies. This allows users to configure Layer 7 network policies (FQDN, HTTP, Kafka). Policies themselves must be configured via the Cilium Network Policy resources, see https://docs.cilium.io/en/latest/security/policy/index.html. This can be enabled only on cilium-based clusters. If not specified, the default value is FQDN if security.enabled is set to true.
   */
  advancedNetworkPolicies?: AdvancedNetworkPolicies;

  /**
   * Encryption configuration for Cilium-based clusters. Once enabled all traffic between Cilium managed pods will be encrypted when it leaves the node boundary.
   */
  @added(Versions.v2025_10_02_preview)
  transitEncryption?: AdvancedNetworkingSecurityTransitEncryption;
}

/**
 * Profile of the managed cluster load balancer.
 */
model ManagedClusterLoadBalancerProfile {
  /**
   * Desired managed outbound IPs for the cluster load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedOutboundIPs?: ManagedClusterLoadBalancerProfileManagedOutboundIPs;

  /**
   * Desired outbound IP Prefix resources for the cluster load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  outboundIPPrefixes?: ManagedClusterLoadBalancerProfileOutboundIPPrefixes;

  /**
   * Desired outbound IP resources for the cluster load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  outboundIPs?: ManagedClusterLoadBalancerProfileOutboundIPs;

  /**
   * The effective outbound IP resources of the cluster load balancer.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  effectiveOutboundIPs?: ResourceReference[];

  /**
   * The desired number of allocated SNAT ports per VM. Allowed values are in the range of 0 to 64000 (inclusive). The default value is 0 which results in Azure dynamically allocating ports.
   */
  @maxValue(64000)
  @minValue(0)
  allocatedOutboundPorts?: int32 = 0;

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

  /**
   * The health probing behavior for External Traffic Policy Cluster services.
   */
  @added(Versions.v2025_10_02_preview)
  clusterServiceLoadBalancerHealthProbeMode?: ClusterServiceLoadBalancerHealthProbeMode = ClusterServiceLoadBalancerHealthProbeMode.ServiceNodePort;
}

/**
 * Desired managed outbound IPs for the cluster load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(100)
  @minValue(0)
  countIPv6?: int32 = 0;
}

/**
 * Desired outbound IP Prefix resources for the cluster load balancer.
 */
model ManagedClusterLoadBalancerProfileOutboundIPPrefixes {
  /**
   * A list of public IP prefix resources.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPPrefixes?: ResourceReference[];
}

/**
 * A reference to an Azure resource.
 */
model ResourceReference {
  /**
   * The fully qualified Azure resource id.
   */
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * Desired outbound IP resources for the cluster load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterLoadBalancerProfileOutboundIPs {
  /**
   * A list of public IP resources.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publicIPs?: ResourceReference[];
}

/**
 * Profile of the managed cluster NAT gateway.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterNATGatewayProfile {
  /**
   * Profile of the managed outbound IP resources of the cluster NAT gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedOutboundIPProfile?: ManagedClusterManagedOutboundIPProfile;

  /**
   * The effective outbound IP resources of the cluster NAT gateway.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
 * The Static Egress Gateway addon configuration for the cluster.
 */
model ManagedClusterStaticEgressGatewayProfile {
  /**
   * Enable Static Egress Gateway addon. Indicates if Static Egress Gateway addon is enabled or not.
   */
  enabled?: boolean;
}

/**
 * Holds configuration customizations for kube-proxy. Any values not defined will use the kube-proxy defaulting behavior. See https://v<version>.docs.kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/ where <version> is represented by a <major version>-<minor version> string. Kubernetes version 1.23 would be '1-23'.
 */
@added(Versions.v2025_10_02_preview)
model ContainerServiceNetworkProfileKubeProxyConfig {
  /**
   * Whether to enable on kube-proxy on the cluster (if no 'kubeProxyConfig' exists, kube-proxy is enabled in AKS by default without these customizations).
   */
  enabled?: boolean;

  /**
   * Specify which proxy mode to use ('IPTABLES', 'IPVS' or 'NFTABLES')
   */
  mode?: Mode;

  /**
   * Holds configuration customizations for IPVS. May only be specified if 'mode' is set to 'IPVS'.
   */
  ipvsConfig?: ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig;
}

/**
 * Holds configuration customizations for IPVS. May only be specified if 'mode' is set to 'IPVS'.
 */
@added(Versions.v2025_10_02_preview)
model ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig {
  /**
   * IPVS scheduler, for more information please see http://www.linuxvirtualserver.org/docs/scheduling.html.
   */
  scheduler?: IpvsScheduler;

  /**
   * The timeout value used for idle IPVS TCP sessions in seconds. Must be a positive integer value.
   */
  tcpTimeoutSeconds?: int32;

  /**
   * The timeout value used for IPVS TCP sessions after receiving a FIN in seconds. Must be a positive integer value.
   */
  tcpFinTimeoutSeconds?: int32;

  /**
   * The timeout value used for IPVS UDP packets in seconds. Must be a positive integer value.
   */
  udpTimeoutSeconds?: int32;
}

/**
 * Encryption configuration for Cilium-based clusters. Once enabled all traffic between Cilium managed pods will be encrypted when it leaves the node boundary.
 */
@added(Versions.v2025_10_02_preview)
model AdvancedNetworkingSecurityTransitEncryption {
  /**
   * Configures pod-to-pod encryption. This can be enabled only on Cilium-based clusters. If not specified, the default value is None.
   */
  type?: TransitEncryptionType;
}

/**
 * Profile to enable performance-enhancing features on clusters that use Azure CNI powered by Cilium.
 */
@added(Versions.v2025_10_02_preview)
model AdvancedNetworkingPerformance {
  /**
   * Enable advanced network acceleration options. This allows users to configure acceleration using BPF host routing. This can be enabled only with Cilium dataplane. If not specified, the default value is None (no acceleration). The acceleration mode can be changed on a pre-existing cluster. See https://aka.ms/acnsperformance for a detailed explanation
   */
  accelerationMode?: AccelerationMode = AccelerationMode.None;
}

/**
 * AADProfile specifies attributes for Azure Active Directory integration. For more details see [managed AAD on AKS](https://docs.microsoft.com/azure/aks/managed-aad).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAADProfile {
  /**
   * Whether to enable managed AAD.
   */
  managed?: boolean;

  /**
   * Whether to enable Azure RBAC for Kubernetes authorization.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableAzureRBAC?: boolean;

  /**
   * The list of AAD group object IDs that will have admin role of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  adminGroupObjectIDs?: string[];

  /**
   * (DEPRECATED) The client AAD application ID. Learn more at https://aka.ms/aks/aad-legacy.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientAppID?: string;

  /**
   * (DEPRECATED) The server AAD application ID. Learn more at https://aka.ms/aks/aad-legacy.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serverAppID?: string;

  /**
   * (DEPRECATED) The server AAD application secret. Learn more at https://aka.ms/aks/aad-legacy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serverAppSecret?: string;

  /**
   * The AAD tenant ID to use for authentication. If not specified, will use the tenant of the deployment subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantID?: string;
}

/**
 * Auto upgrade profile for a managed cluster.
 */
model ManagedClusterAutoUpgradeProfile {
  /**
   * The upgrade channel for auto upgrade. The default is 'none'. For more information see [setting the AKS cluster auto-upgrade channel](https://docs.microsoft.com/azure/aks/upgrade-cluster#set-auto-upgrade-channel).
   */
  upgradeChannel?: UpgradeChannel;

  /**
   * Node OS Upgrade Channel. Manner in which the OS on your nodes is updated. The default is NodeImage.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Detects similar node pools and balances the number of nodes between them. Valid values are 'true' and 'false'
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `balance-similar-node-groups`?: string;

  /**
   * DaemonSet pods will be gracefully terminated from empty nodes. If set to true, all daemonset pods on empty nodes will be evicted before deletion of the node. If the daemonset pod cannot be evicted another node will be chosen for scaling. If set to false, the node will be deleted without ensuring that daemonset pods are deleted or evicted.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `daemonset-eviction-for-empty-nodes`?: boolean;

  /**
   * DaemonSet pods will be gracefully terminated from non-empty nodes. If set to true, all daemonset pods on occupied nodes will be evicted before deletion of the node. If the daemonset pod cannot be evicted another node will be chosen for scaling. If set to false, the node will be deleted without ensuring that daemonset pods are deleted or evicted.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `daemonset-eviction-for-occupied-nodes`?: boolean;

  /**
   * Should CA ignore DaemonSet pods when calculating resource utilization for scaling down. If set to true, the resources used by daemonset will be taken into account when making scaling down decisions.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `ignore-daemonsets-utilization`?: boolean;

  /**
   * The expander to use when scaling up. If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
   */
  expander?: Expander;

  /**
   * The maximum number of empty nodes that can be deleted at the same time. This must be a positive integer. The default is 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `max-empty-bulk-delete`?: string;

  /**
   * The maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. The default is 600.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `max-graceful-termination-sec`?: string;

  /**
   * The maximum time the autoscaler waits for a node to be provisioned. The default is '15m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `max-node-provision-time`?: string;

  /**
   * The maximum percentage of unready nodes in the cluster. After this percentage is exceeded, cluster autoscaler halts operations. The default is 45. The maximum is 100 and the minimum is 0.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `max-total-unready-percentage`?: string;

  /**
   * Ignore unscheduled pods before they're a certain age. For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. The default is '0s'. Values must be an integer followed by a unit ('s' for seconds, 'm' for minutes, 'h' for hours, etc).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `new-pod-scale-up-delay`?: string;

  /**
   * The number of allowed unready nodes, irrespective of max-total-unready-percentage. This must be an integer. The default is 3.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `ok-total-unready-count`?: string;

  /**
   * How often cluster is reevaluated for scale up or down. The default is '10'. Values must be an integer number of seconds.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scan-interval`?: string;

  /**
   * How long after scale up that scale down evaluation resumes. The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-delay-after-add`?: string;

  /**
   * How long after node deletion that scale down evaluation resumes. The default is the scan-interval. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-delay-after-delete`?: string;

  /**
   * How long after scale down failure that scale down evaluation resumes. The default is '3m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-delay-after-failure`?: string;

  /**
   * How long a node should be unneeded before it is eligible for scale down. The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-unneeded-time`?: string;

  /**
   * How long an unready node should be unneeded before it is eligible for scale down. The default is '20m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-unready-time`?: string;

  /**
   * Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. The default is '0.5'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `scale-down-utilization-threshold`?: string;

  /**
   * If cluster autoscaler will skip deleting nodes with pods with local storage, for example, EmptyDir or HostPath. The default is true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `skip-nodes-with-local-storage`?: string;

  /**
   * If cluster autoscaler will skip deleting nodes with pods from kube-system (except for DaemonSet or mirror pods). The default is true.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `skip-nodes-with-system-pods`?: string;
}

/**
 * Access profile for managed cluster API server.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAPIServerAccessProfile {
  /**
   * The IP ranges authorized to access the Kubernetes API server. IP ranges are specified in CIDR format, e.g. 137.117.106.88/29. This feature is not compatible with clusters that use Public IP Per Node, or clusters that are using a Basic Load Balancer. For more information see [API server authorized IP ranges](https://docs.microsoft.com/azure/aks/api-server-authorized-ip-ranges).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authorizedIPRanges?: string[];

  /**
   * Whether to create the cluster as a private cluster or not. For more details, see [Creating a private AKS cluster](https://docs.microsoft.com/azure/aks/private-clusters).
   */
  enablePrivateCluster?: boolean;

  /**
   * The private DNS zone mode for the cluster. The default is System. For more details see [configure private DNS zone](https://docs.microsoft.com/azure/aks/private-clusters#configure-private-dns-zone). Allowed values are 'system' and 'none'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  privateDNSZone?: string;

  /**
   * Whether to create additional public FQDN for private cluster or not.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enablePrivateClusterPublicFQDN?: boolean;

  /**
   * Whether to disable run command for the cluster or not.
   */
  disableRunCommand?: boolean;

  /**
   * Whether to enable apiserver vnet integration for the cluster or not. See aka.ms/AksVnetIntegration for more details.
   */
  enableVnetIntegration?: boolean;

  /**
   * The subnet to be used when apiserver vnet integration is enabled. It is required when creating a new cluster with BYO Vnet, or when updating an existing cluster to enable apiserver vnet integration.
   */
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("https://aka.ms/search-naming-rules")
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateLinkServiceID?: Azure.Core.armResourceIdentifier;
}

/**
 * Cluster HTTP proxy configuration.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterHTTPProxyConfig {
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
   * A read-only list of all endpoints for which traffic should not be sent to the proxy. This list is a superset of noProxy and values injected by AKS.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  effectiveNoProxy?: string[];

  /**
   * Alternative CA cert to use for connecting to proxy servers.
   */
  trustedCa?: string;

  /**
   * Whether to enable HTTP proxy. When disabled, the specified proxy configuration will be not be set on pods and nodes.
   */
  @added(Versions.v2025_10_02_preview)
  enabled?: boolean;
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
   * Encryption at rest of Kubernetes resource objects. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption
   */
  @added(Versions.v2025_10_02_preview)
  kubernetesResourceObjectEncryptionProfile?: KubernetesResourceObjectEncryptionProfile;

  /**
   * Workload identity settings for the security profile. Workload identity enables Kubernetes applications to access Azure cloud resources securely with Azure AD. See https://aka.ms/aks/wi for more details.
   */
  workloadIdentity?: ManagedClusterSecurityProfileWorkloadIdentity;

  /**
   * Image Cleaner settings for the security profile.
   */
  imageCleaner?: ManagedClusterSecurityProfileImageCleaner;

  /**
   * Image integrity is a feature that works with Azure Policy to verify image integrity by signature. This will not have any effect unless Azure Policy is applied to enforce image signatures. See https://aka.ms/aks/image-integrity for how to use this feature via policy.
   */
  @added(Versions.v2025_10_02_preview)
  imageIntegrity?: ManagedClusterSecurityProfileImageIntegrity;

  /**
   * [Node Restriction](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction) settings for the security profile.
   */
  @added(Versions.v2025_10_02_preview)
  nodeRestriction?: ManagedClusterSecurityProfileNodeRestriction;

  /**
   * A list of up to 10 base64 encoded CAs that will be added to the trust store on all nodes in the cluster. For more information see [Custom CA Trust Certificates](https://learn.microsoft.com/en-us/azure/aks/custom-certificate-authority).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxItems(10)
  @minItems(0)
  customCATrustCertificates?: bytes[];
}

/**
 * Microsoft Defender settings for the security profile.
 */
model ManagedClusterSecurityProfileDefender {
  /**
   * Resource ID of the Log Analytics workspace to be associated with Microsoft Defender. When Microsoft Defender is enabled, this field is required and must be a valid workspace resource ID. When Microsoft Defender is disabled, leave the field empty.
   */
  logAnalyticsWorkspaceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * Microsoft Defender threat detection for Cloud settings for the security profile.
   */
  securityMonitoring?: ManagedClusterSecurityProfileDefenderSecurityMonitoring;

  /**
   * Microsoft Defender settings for security gating, validates container images eligibility for deployment based on Defender for Containers security findings. Using Admission Controller, it either audits or prevents the deployment of images that do not meet security standards.
   */
  @added(Versions.v2025_10_02_preview)
  securityGating?: ManagedClusterSecurityProfileDefenderSecurityGating;
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
 * Microsoft Defender settings for security gating, validates container images eligibility for deployment based on Defender for Containers security findings. Using Admission Controller, it either audits or prevents the deployment of images that do not meet security standards.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterSecurityProfileDefenderSecurityGating {
  /**
   * Whether to enable Defender security gating. When enabled, the gating feature will scan container images and audit or block the deployment of images that do not meet security standards according to the configured security rules.
   */
  enabled?: boolean;

  /**
   * List of identities that the admission controller will make use of in order to pull security artifacts from the registry. These are the same identities used by the cluster to pull container images. Each identity provided should have federated identity credential attached to it.
   */
  @identifiers(#[])
  identities?: ManagedClusterSecurityProfileDefenderSecurityGatingIdentitiesItem[];

  /**
   * In use only while registry access granted by secret rather than managed identity. Set whether to grant the Defender gating agent access to the cluster's secrets for pulling images from registries. If secret access is denied and the registry requires pull secrets, the add-on will not perform any image validation. Default value is false.
   */
  allowSecretAccess?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model ManagedClusterSecurityProfileDefenderSecurityGatingIdentitiesItem {
  /**
   * The container registry for which the identity will be used; the identity specified here should have a federated identity credential attached to it.
   */
  azureContainerRegistry?: string;

  /**
   * The identity object used to access the registry
   */
  identity?: UserAssignedIdentity;
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
   * Network access of the key vault. Network access of key vault. The possible values are `Public` and `Private`. `Public` means the key vault allows public access from all networks. `Private` means the key vault disables public access and enables private link. The default value is `Public`.
   */
  keyVaultNetworkAccess?: KeyVaultNetworkAccessTypes = KeyVaultNetworkAccessTypes.Public;

  /**
   * Resource ID of key vault. When keyVaultNetworkAccess is `Private`, this field is required and must be a valid resource ID. When keyVaultNetworkAccess is `Public`, leave the field empty.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;
}

/**
 * Encryption at rest of Kubernetes resource objects using service-managed keys. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption.
 */
@added(Versions.v2025_10_02_preview)
model KubernetesResourceObjectEncryptionProfile {
  /**
   * Whether to enable encryption at rest of Kubernetes resource objects using service-managed keys. More information on this can be found under https://aka.ms/aks/kubernetesResourceObjectEncryption.
   */
  infrastructureEncryption?: InfrastructureEncryption = InfrastructureEncryption.Disabled;
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
 * Image integrity related settings for the security profile.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterSecurityProfileImageIntegrity {
  /**
   * Whether to enable image integrity. The default value is false.
   */
  enabled?: boolean;
}

/**
 * Node Restriction settings for the security profile.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterSecurityProfileNodeRestriction {
  /**
   * Whether to enable Node Restriction
   */
  enabled?: boolean;
}

/**
 * Storage profile for the container service cluster.
 */
model ManagedClusterStorageProfile {
  /**
   * AzureDisk CSI Driver settings for the storage profile.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  diskCSIDriver?: ManagedClusterStorageProfileDiskCSIDriver;

  /**
   * AzureFile CSI Driver settings for the storage profile.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fileCSIDriver?: ManagedClusterStorageProfileFileCSIDriver;

  /**
   * Snapshot Controller settings for the storage profile.
   */
  snapshotController?: ManagedClusterStorageProfileSnapshotController;

  /**
   * AzureBlob CSI Driver settings for the storage profile.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blobCSIDriver?: ManagedClusterStorageProfileBlobCSIDriver;
}

/**
 * AzureDisk CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterStorageProfileDiskCSIDriver {
  /**
   * Whether to enable AzureDisk CSI Driver. The default value is true.
   */
  enabled?: boolean;

  /**
   * The version of AzureDisk CSI Driver. The default value is v1.
   */
  @added(Versions.v2025_10_02_preview)
  version?: string;
}

/**
 * AzureFile CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterStorageProfileBlobCSIDriver {
  /**
   * Whether to enable AzureBlob CSI Driver. The default value is false.
   */
  enabled?: boolean;
}

/**
 * Ingress profile for the container service cluster.
 */
model ManagedClusterIngressProfile {
  /**
   * App Routing settings for the ingress profile. You can find an overview and onboarding guide for this feature at https://learn.microsoft.com/en-us/azure/aks/app-routing?tabs=default%2Cdeploy-app-default.
   */
  webAppRouting?: ManagedClusterIngressProfileWebAppRouting;

  /**
   * Settings for the managed Gateway API installation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  gatewayAPI?: ManagedClusterIngressProfileGatewayConfiguration;

  /**
   * Settings for the managed Application Load Balancer installation
   */
  @added(Versions.v2025_10_02_preview)
  applicationLoadBalancer?: ManagedClusterIngressProfileApplicationLoadBalancer;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model ManagedClusterIngressProfileGatewayConfiguration {
  /**
   * Configuration for the managed Gateway API installation. If not specified, the default is 'Disabled'. See https://aka.ms/k8s-gateway-api for more details.
   */
  installation?: ManagedGatewayType;
}

/**
 * Application Routing add-on settings for the ingress profile.
 */
model ManagedClusterIngressProfileWebAppRouting {
  /**
   * Whether to enable the Application Routing add-on.
   */
  enabled?: boolean;

  /**
   * Resource IDs of the DNS zones to be associated with the Application Routing add-on. Used only when Application Routing add-on is enabled. Public and private DNS zones can be in different resource groups, but all public DNS zones must be in the same resource group and all private DNS zones must be in the same resource group.
   */
  @maxItems(5)
  dnsZoneResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/dnszones";
    },
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>[];

  /**
   * Configuration for the default NginxIngressController. See more at https://learn.microsoft.com/en-us/azure/aks/app-routing-nginx-configuration#the-default-nginx-ingress-controller.
   */
  nginx?: ManagedClusterIngressProfileNginx;

  /**
   * Managed identity of the Application Routing add-on. This is the identity that should be granted permissions, for example, to manage the associated Azure DNS resource and get certificates from Azure Key Vault. See [this overview of the add-on](https://learn.microsoft.com/en-us/azure/aks/web-app-routing?tabs=with-osm) for more instructions.
   */
  @visibility(Lifecycle.Read)
  identity?: UserAssignedIdentity;

  /**
   * Configuration for the Default Domain. This is a unique, autogenerated domain that comes with a signed TLS Certificate allowing for secure HTTPS. See [the Default Domain documentation](https://aka.ms/aks/defaultdomain) for more instructions.
   */
  @added(Versions.v2025_10_02_preview)
  defaultDomain?: ManagedClusterIngressDefaultDomainProfile;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterIngressProfileNginx {
  /**
   * Ingress type for the default NginxIngressController custom resource
   */
  defaultIngressControllerType?: NginxIngressControllerType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model ManagedClusterIngressDefaultDomainProfile {
  /**
   * Whether to enable Default Domain.
   */
  enabled?: boolean;

  /**
   * The unique fully qualified domain name assigned to the cluster. This will not change even if disabled then reenabled.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;
}

/**
 * Application Load Balancer settings for the ingress profile.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterIngressProfileApplicationLoadBalancer {
  /**
   * Whether to enable Application Load Balancer.
   */
  enabled?: boolean;

  /**
   * Managed identity of the Application Load Balancer add-on. This is the identity that should be granted permissions to manage the associated Application Gateway for Containers resource.
   */
  @visibility(Lifecycle.Read)
  identity?: UserAssignedIdentity;
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
  enabled: boolean = false;

  /**
   * Whether VPA add-on is enabled and configured to scale AKS-managed add-ons.
   */
  @added(Versions.v2025_10_02_preview)
  addonAutoscaling?: AddonAutoscaling = AddonAutoscaling.Disabled;
}

/**
 * Azure Monitor addon profiles for monitoring the managed cluster.
 */
model ManagedClusterAzureMonitorProfile {
  /**
   * Metrics profile for the Azure Monitor managed service for Prometheus addon. Collect out-of-the-box Kubernetes infrastructure metrics to send to an Azure Monitor Workspace and configure additional scraping for custom targets. See aka.ms/AzureManagedPrometheus for an overview.
   */
  metrics?: ManagedClusterAzureMonitorProfileMetrics;

  /**
   * Azure Monitor Container Insights Profile for Kubernetes Events, Inventory and Container stdout & stderr logs etc. See aka.ms/AzureMonitorContainerInsights for an overview.
   */
  @added(Versions.v2025_10_02_preview)
  containerInsights?: ManagedClusterAzureMonitorProfileContainerInsights;

  /**
   * Application Monitoring Profile for Kubernetes Application Container. Collects application logs, metrics and traces through auto-instrumentation of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
   */
  @added(Versions.v2025_10_02_preview)
  appMonitoring?: ManagedClusterAzureMonitorProfileAppMonitoring;
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
 * Azure Monitor Container Insights Profile for Kubernetes Events, Inventory and Container stdout & stderr logs etc. See aka.ms/AzureMonitorContainerInsights for an overview.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterAzureMonitorProfileContainerInsights {
  /**
   * Indicates if Azure Monitor Container Insights Logs Addon is enabled or not.
   */
  enabled?: boolean;

  /**
   * Fully Qualified ARM Resource Id of Azure Log Analytics Workspace for storing Azure Monitor Container Insights Logs.
   */
  logAnalyticsWorkspaceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The syslog host port. If not specified, the default port is 28330.
   */
  syslogPort?: int64;

  /**
   * Indicates whether custom metrics collection has to be disabled or not. If not specified the default is false. No custom metrics will be emitted if this field is false but the container insights enabled field is false
   */
  disableCustomMetrics?: boolean;

  /**
   * Indicates whether prometheus metrics scraping is disabled or not. If not specified the default is false. No prometheus metrics will be emitted if this field is false but the container insights enabled field is false
   */
  disablePrometheusMetricsScraping?: boolean;
}

/**
 * Application Monitoring Profile for Kubernetes Application Container. Collects application logs, metrics and traces through auto-instrumentation of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterAzureMonitorProfileAppMonitoring {
  /**
   * Application Monitoring Auto Instrumentation for Kubernetes Application Container. Deploys web hook to auto-instrument Azure Monitor OpenTelemetry based SDKs to collect OpenTelemetry metrics, logs and traces of the application. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
   */
  autoInstrumentation?: ManagedClusterAzureMonitorProfileAppMonitoringAutoInstrumentation;

  /**
   * Application Monitoring Open Telemetry Metrics Profile for Kubernetes Application Container Metrics. Collects OpenTelemetry metrics of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
   */
  openTelemetryMetrics?: ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryMetrics;

  /**
   * Application Monitoring Open Telemetry Metrics Profile for Kubernetes Application Container Logs and Traces. Collects OpenTelemetry logs and traces of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
   */
  openTelemetryLogs?: ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryLogs;
}

/**
 * Application Monitoring Auto Instrumentation for Kubernetes Application Container. Deploys web hook to auto-instrument Azure Monitor OpenTelemetry based SDKs to collect OpenTelemetry metrics, logs and traces of the application. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterAzureMonitorProfileAppMonitoringAutoInstrumentation {
  /**
   * Indicates if Application Monitoring Auto Instrumentation is enabled or not.
   */
  enabled?: boolean;
}

/**
 * Application Monitoring Open Telemetry Metrics Profile for Kubernetes Application Container Metrics. Collects OpenTelemetry metrics of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryMetrics {
  /**
   * Indicates if Application Monitoring Open Telemetry Metrics is enabled or not.
   */
  enabled?: boolean;

  /**
   * The Open Telemetry host port for Open Telemetry metrics. If not specified, the default port is 28333.
   */
  port?: int64;
}

/**
 * Application Monitoring Open Telemetry Metrics Profile for Kubernetes Application Container Logs and Traces. Collects OpenTelemetry logs and traces of the application using Azure Monitor OpenTelemetry based SDKs. See aka.ms/AzureMonitorApplicationMonitoring for an overview.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryLogs {
  /**
   * Indicates if Application Monitoring Open Telemetry Logs and traces is enabled or not.
   */
  enabled?: boolean;

  /**
   * The Open Telemetry host port for Open Telemetry logs and traces. If not specified, the default port is 28331.
   */
  port?: int64;
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
  @maxItems(2)
  @uniqueItems
  revisions?: string[];
}

/**
 * Istio components configuration.
 */
model IstioComponents {
  /**
   * Istio ingress gateways.
   */
  @identifiers(#[])
  ingressGateways?: IstioIngressGateway[];

  /**
   * Istio egress gateways.
   */
  @identifiers(#[])
  egressGateways?: IstioEgressGateway[];

  /**
   * Mode of traffic redirection.
   */
  @added(Versions.v2025_10_02_preview)
  proxyRedirectionMechanism?: ProxyRedirectionMechanism;
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
   * Name of the Istio add-on egress gateway.
   */
  @pattern("[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*")
  name: string;

  /**
   * Namespace that the Istio add-on egress gateway should be deployed in. If unspecified, the default is aks-istio-egress.
   */
  `namespace`?: string;

  /**
   * Name of the gateway configuration custom resource for the Istio add-on egress gateway. Must be specified when enabling the Istio egress gateway. Must be deployed in the same namespace that the Istio egress gateway will be deployed in.
   */
  gatewayConfigurationName?: string;
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
  keyVaultId?: Azure.Core.armResourceIdentifier<[
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
 * The metrics profile for the ManagedCluster.
 */
model ManagedClusterMetricsProfile {
  /**
   * The configuration for detailed per-Kubernetes resource cost analysis.
   */
  costAnalysis?: ManagedClusterCostAnalysis;
}

/**
 * The cost analysis configuration for the cluster
 */
model ManagedClusterCostAnalysis {
  /**
   * Whether to enable cost analysis. The Managed Cluster sku.tier must be set to 'Standard' or 'Premium' to enable this feature. Enabling this will add Kubernetes Namespace and Deployment details to the Cost Analysis views in the Azure portal. If not specified, the default is false. For more information see aka.ms/aks/docs/cost-analysis.
   */
  enabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterNodeProvisioningProfile {
  /**
   * The node provisioning mode. If not specified, the default is Manual.
   */
  mode?: NodeProvisioningMode;

  /**
   * The set of default Karpenter NodePools (CRDs) configured for node provisioning. This field has no effect unless mode is 'Auto'. Warning: Changing this from Auto to None on an existing cluster will cause the default Karpenter NodePools to be deleted, which will drain and delete the nodes associated with those pools. It is strongly recommended to not do this unless there are idle nodes ready to take the pods evicted by that action. If not specified, the default is Auto. For more information see aka.ms/aks/nap#node-pools.
   */
  defaultNodePools?: NodeProvisioningDefaultNodePools = NodeProvisioningDefaultNodePools.Auto;
}

/**
 * The bootstrap profile.
 */
model ManagedClusterBootstrapProfile {
  /**
   * The artifact source. The source where the artifacts are downloaded from.
   */
  artifactSource?: ArtifactSource = ArtifactSource.Direct;

  /**
   * The resource Id of Azure Container Registry. The registry must have private network access, premium SKU and zone redundancy.
   */
  containerRegistryId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerRegistry/registries";
    }
  ]>;
}

/**
 * When enabling the operator, a set of AKS managed CRDs and controllers will be installed in the cluster. The operator automates the deployment of OSS models for inference and/or training purposes. It provides a set of preset models and enables distributed inference against them.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAIToolchainOperatorProfile {
  /**
   * Whether to enable AI toolchain operator to the cluster. Indicates if AI toolchain operator  enabled or not.
   */
  enabled?: boolean;
}

/**
 * The pod scheduler profile for the cluster.
 */
@added(Versions.v2025_10_02_preview)
model SchedulerProfile {
  /**
   * Mapping of each scheduler instance to its profile.
   */
  schedulerInstanceProfiles?: SchedulerProfileSchedulerInstanceProfiles;
}

/**
 * Mapping of each scheduler instance to its profile.
 */
@added(Versions.v2025_10_02_preview)
model SchedulerProfileSchedulerInstanceProfiles {
  /**
   * The scheduler profile for the upstream scheduler instance.
   */
  upstream?: SchedulerInstanceProfile;
}

/**
 * The scheduler profile for a single scheduler instance.
 */
@added(Versions.v2025_10_02_preview)
model SchedulerInstanceProfile {
  /**
   * The config customization mode for this scheduler instance.
   */
  schedulerConfigMode?: SchedulerConfigMode;
}

/**
 * Settings for hosted system addons.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterHostedSystemProfile {
  /**
   * Whether to enable hosted system addons for the cluster.
   */
  enabled?: boolean;
}

/**
 * Contains read-only information about the Managed Cluster.
 */
model ManagedClusterStatus {
  /**
   * The error details information of the managed cluster. Preserves the detailed info of failure. If there was no error, this field is omitted.
   */
  @visibility(Lifecycle.Read)
  provisioningError?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Control plane and agent pool upgrade profiles.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterUpgradeProfileProperties {
  /**
   * The list of available upgrade versions for the control plane.
   */
  controlPlaneProfile: ManagedClusterPoolUpgradeProfile;

  /**
   * The list of available upgrade versions for agent pools.
   */
  @identifiers(#[])
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
  @identifiers(#[])
  upgrades?: ManagedClusterPoolUpgradeProfileUpgradesItem[];

  /**
   * List of components grouped by kubernetes major.minor version.
   */
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  componentsByReleases?: ComponentsByRelease[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterPoolUpgradeProfileUpgradesItem {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  isPreview?: boolean;

  /**
   * Whether the Kubernetes version is out of support.
   */
  @added(Versions.v2025_10_02_preview)
  isOutOfSupport?: boolean;
}

/**
 * components of given Kubernetes version.
 */
@added(Versions.v2025_10_02_preview)
model ComponentsByRelease {
  /**
   * The Kubernetes version (major.minor).
   */
  kubernetesVersion?: string;

  /**
   * components of current or upgraded Kubernetes version in the cluster.
   */
  @identifiers(#[])
  components?: Component[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model Component {
  /**
   * Component name.
   */
  name?: string;

  /**
   * Component version.
   */
  version?: string;

  /**
   * If upgraded component version contains breaking changes from the current version. To see a detailed description of what the breaking changes are, visit https://learn.microsoft.com/azure/aks/supported-kubernetes-versions?tabs=azure-cli#aks-components-breaking-changes-by-version.
   */
  hasBreakingChanges?: boolean;
}

/**
 * Managed cluster Access Profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedClusterAccessProfile
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * AccessProfile of a managed cluster.
   */
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
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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

/**
 * Tags object for patch operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TagsObject {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties used to configure planned maintenance for a Managed Cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaintenanceConfigurationProperties {
  /**
   * Time slots during the week when planned maintenance is allowed to proceed. If two array entries specify the same day of the week, the applied configuration is the union of times in both entries.
   */
  @identifiers(#[])
  timeInWeek?: TimeInWeek[];

  /**
   * Time slots on which upgrade is not allowed.
   */
  @identifiers(#[])
  notAllowedTime?: TimeSpan[];

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
   * A list of hours in the day used to identify a time range. Each integer hour represents a time range beginning at 0m after the hour ending at the next hour (non-inclusive). 0 corresponds to 00:00 UTC, 23 corresponds to 23:00 UTC. Specifying [0, 1] means the 00:00 - 02:00 UTC time range.
   */
  hourSlots?: HourInDay[];
}

/**
 * Hour in a day.
 */
@minValue(0)
@maxValue(23)
scalar HourInDay extends int32;

/**
 * A time range. For example, between 2021-05-25T13:00:00Z and 2021-05-25T14:00:00Z.
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
  @identifiers(#[])
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
   * The week index. Specifies on which week of the month the dayOfWeek applies.
   */
  weekIndex: Type;

  /**
   * Specifies on which day of the week the maintenance occurs.
   */
  dayOfWeek: WeekDay;
}

/**
 * A date range. For example, between '2022-12-23' and '2023-01-05'.
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of a namespace managed by ARM
 */
model NamespaceProperties {
  /**
   * The current provisioning state of the namespace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NamespaceProvisioningState;

  /**
   * The labels of managed namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labels?: Record<string>;

  /**
   * The annotations of managed namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  annotations?: Record<string>;

  /**
   * The special FQDN used by the Azure Portal to access the Managed Cluster. This FQDN is for use only by the Azure Portal and should not be used by other clients. The Azure Portal requires certain Cross-Origin Resource Sharing (CORS) headers to be sent in some responses, which Kubernetes APIServer doesn't handle by default. This special FQDN supports CORS, allowing the Azure Portal to function properly.
   */
  @visibility(Lifecycle.Read)
  portalFqdn?: string;

  /**
   * The default resource quota enforced upon the namespace. Customers can have other Kubernetes resource quota objects under the namespace. Resource quotas are additive; if multiple resource quotas are applied to a given namespace, then the effective limit will be one such that all quotas on the namespace can be satisfied.
   */
  defaultResourceQuota?: ResourceQuota;

  /**
   * The default network policy enforced upon the namespace. Customers can have other Kubernetes network policy objects under the namespace. Network policies are additive; if a policy or policies apply to a given pod for a given direction, the connections allowed in that direction for the pod is the union of what all applicable policies allow.
   */
  defaultNetworkPolicy?: NetworkPolicies;

  /**
   * Action if Kubernetes namespace with same name already exists.
   */
  adoptionPolicy?: AdoptionPolicy;

  /**
   * Delete options of a namespace.
   */
  deletePolicy?: DeletePolicy;
}

/**
 * Resource quota for the namespace.
 */
model ResourceQuota {
  /**
   * CPU request of the namespace in one-thousandth CPU form. See [CPU resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu) for more details.
   */
  cpuRequest?: string;

  /**
   * CPU limit of the namespace in one-thousandth CPU form. See [CPU resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu) for more details.
   */
  cpuLimit?: string;

  /**
   * Memory request of the namespace in the power-of-two equivalents form: Ei, Pi, Ti, Gi, Mi, Ki. See [Memory resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory) for more details.
   */
  memoryRequest?: string;

  /**
   * Memory limit of the namespace in the power-of-two equivalents form: Ei, Pi, Ti, Gi, Mi, Ki. See [Memory resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory) for more details.
   */
  memoryLimit?: string;
}

/**
 * Default network policy of the namespace, specifying ingress and egress rules.
 */
model NetworkPolicies {
  /**
   * Enum representing different network policy rules.
   */
  ingress?: PolicyRule = PolicyRule.AllowSameNamespace;

  /**
   * Enum representing different network policy rules.
   */
  egress?: PolicyRule = PolicyRule.AllowAll;
}

/**
 * The list of available upgrade versions.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
  upgrades?: AgentPoolUpgradeProfilePropertiesUpgradesItem[];

  /**
   * List of components grouped by kubernetes major.minor version.
   */
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  componentsByReleases?: ComponentsByRelease[];

  /**
   * List of historical good versions for rollback operations.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recentlyUsedVersions?: AgentPoolRecentlyUsedVersion[];

  /**
   * The latest AKS supported node image version.
   */
  latestNodeImageVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentPoolUpgradeProfilePropertiesUpgradesItem {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  isPreview?: boolean;

  /**
   * Whether the Kubernetes version is out of support.
   */
  @added(Versions.v2025_10_02_preview)
  isOutOfSupport?: boolean;
}

/**
 * A historical version that can be used for rollback operations.
 */
@added(Versions.v2025_10_02_preview)
model AgentPoolRecentlyUsedVersion {
  /**
   * The Kubernetes version (major.minor.patch) available for rollback.
   */
  orchestratorVersion?: string;

  /**
   * The node image version available for rollback.
   */
  nodeImageVersion?: string;

  /**
   * The timestamp when this version was last used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * Specifies a list of machine names from the agent pool to be deleted.
 */
model AgentPoolDeleteMachinesParameter {
  /**
   * The agent pool machine names.
   */
  machineNames: string[];
}

/**
 * The hardware and GPU settings of the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineHardwareProfile {
  /**
   * The size of the VM. VM size availability varies by region. If a node contains insufficient compute resources (memory, cpu, etc) pods might fail to run correctly. For more details on restricted VM sizes, see: https://docs.microsoft.com/azure/aks/quotas-skus-regions
   */
  vmSize?: string;

  /**
   * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
   */
  gpuInstanceProfile?: GPUInstanceProfile;

  /**
   * The GPU settings of the machine.
   */
  gpuProfile?: GPUProfile;
}

/**
 * The operating system and disk used by the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineOSProfile {
  /**
   * The operating system type. The default is Linux.
   */
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  osSKU?: OSSKU;

  /**
   * OS Disk Size in GB to be used to specify the disk size for every machine in the master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(2048)
  @minValue(0)
  osDiskSizeGB?: int32;

  /**
   * The OS disk type to be used for machines in the agent pool. The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
   */
  osDiskType?: OSDiskType;

  /**
   * Whether to use a FIPS-enabled OS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableFIPS?: boolean;

  /**
   * The Linux machine's specific profile.
   */
  linuxProfile?: MachineOSProfileLinuxProfile;

  /**
   * The Windows machine's specific profile.
   */
  windowsProfile?: AgentPoolWindowsProfile;
}

/**
 * The Linux machine's specific profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model MachineOSProfileLinuxProfile {
  /**
   * The OS configuration of Linux machine.
   */
  linuxOSConfig?: LinuxOSConfig;

  /**
   * Message of the day for Linux nodes, base64-encoded. A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It must not be specified for Windows nodes. It must be a static string (i.e., will be printed raw and not be executed as a script).
   */
  messageOfTheDay?: string;
}

/**
 * The Kubernetes configurations used by the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineKubernetesProfile {
  /**
   * The node labels on the machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodeLabels?: Record<string>;

  /**
   * The version of Kubernetes specified by the user. Both patch version <major.minor.patch> and <major.minor> are supported. When <major.minor> is specified, the latest supported patch version is chosen automatically.
   */
  orchestratorVersion?: string;

  /**
   * The version of Kubernetes running on the machine. If orchestratorVersion was a fully specified version <major.minor.patch>, this field will be exactly equal to it. If orchestratorVersion was <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility(Lifecycle.Read)
  currentOrchestratorVersion?: string;

  /**
   * Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.
   */
  kubeletDiskType?: KubeletDiskType;

  /**
   * The Kubelet configuration on the machine.
   */
  kubeletConfig?: KubeletConfig;

  /**
   * Taints added on the node during creation that will not be reconciled by AKS. These taints will not be reconciled by AKS and can be removed with a kubectl call. These taints allow for required configuration to run before the node is ready to accept workloads, for example 'key1=value1:NoSchedule' that then can be removed with `kubectl taint nodes node1 key1=value1:NoSchedule-`
   */
  nodeInitializationTaints?: string[];

  /**
   * The taints added to new node during machine create. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * The maximum number of pods that can run on a node.
   */
  maxPods?: int32;

  /**
   * The node name in the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Determines the type of workload a node can run.
   */
  workloadRuntime?: WorkloadRuntime;

  /**
   * Configuration for using artifact streaming on AKS.
   */
  artifactStreamingProfile?: AgentPoolArtifactStreamingProfile;
}

/**
 * Contains read-only information about the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineStatus {
  /**
   * The error details information of the machine. Preserves the detailed info of failure. If there was no error, this field is omitted.
   */
  @visibility(Lifecycle.Read)
  provisioningError?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * Specifies the time at which the machine was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimestamp?: utcDateTime;

  /**
   * The drift action of the machine. Indicates whether a machine has deviated from its expected state due to changes in managed cluster properties, requiring corrective action.
   */
  @visibility(Lifecycle.Read)
  driftAction?: DriftAction;

  /**
   * Reason for machine drift. Provides detailed information on why the machine has drifted. This field is omitted if the machine is up to date.
   */
  @visibility(Lifecycle.Read)
  driftReason?: string;

  /**
   * Virtual machine state. Indicates the current state of the underlying virtual machine.
   */
  @visibility(Lifecycle.Read)
  vmState?: VmState;
}

/**
 * The list of available versions for an agent pool.
 */
model AgentPoolAvailableVersions {
  /**
   * The ID of the agent pool version list.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the agent pool version list.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the agent pool version list.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Properties of agent pool available versions.
   */
  properties: AgentPoolAvailableVersionsProperties;
}

/**
 * The list of available agent pool versions.
 */
model AgentPoolAvailableVersionsProperties {
  /**
   * List of versions available for agent pool.
   */
  @identifiers(#[])
  agentPoolVersions?: AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem {
  /**
   * Whether this version is the default agent pool version.
   */
  default?: boolean;

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
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: PrivateEndpointConnection[];
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The current provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  @pageItems
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Properties of command result.
   */
  properties?: CommandResultProperties;
}

/**
 * The results of a run command
 */
model CommandResultProperties {
  /**
   * provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The exit code of the command
   */
  @visibility(Lifecycle.Read)
  exitCode?: int32;

  /**
   * The time when the command started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  /**
   * The time when the command finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishedAt?: utcDateTime;

  /**
   * The command output.
   */
  @visibility(Lifecycle.Read)
  logs?: string;

  /**
   * An explanation of why provisioningState is set to failed (if so).
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
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
  @identifiers(#[])
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
 * The operations list. It contains an URL link to get the next set of results.
 */
model OperationStatusResultList is Azure.Core.Page<OperationStatusResult>;

/**
 * Properties used to configure a node pool snapshot.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The version of node image.
   */
  @visibility(Lifecycle.Read)
  nodeImageVersion?: string;

  /**
   * The operating system type. The default is Linux.
   */
  @visibility(Lifecycle.Read)
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. The default is Ubuntu if OSType is Linux. The default is Windows2019 when Kubernetes <= 1.24 or Windows2022 when Kubernetes >= 1.25 if OSType is Windows.
   */
  @visibility(Lifecycle.Read)
  osSku?: OSSKU;

  /**
   * The size of the VM.
   */
  @visibility(Lifecycle.Read)
  vmSize?: string;

  /**
   * Whether to use a FIPS-enabled OS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  enableFIPS?: boolean;
}

/**
 * Properties for a managed cluster snapshot.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model ManagedClusterSnapshotProperties {
  /**
   * CreationData to be used to specify the source resource ID to create this snapshot.
   */
  creationData?: CreationData;

  /**
   * The type of a snapshot. The default is NodePool.
   */
  snapshotType?: SnapshotType = SnapshotType.NodePool;

  /**
   * What the properties will be showed when getting managed cluster snapshot. Those properties are read-only.
   */
  @visibility(Lifecycle.Read)
  managedClusterPropertiesReadOnly?: ManagedClusterPropertiesForSnapshot;
}

/**
 * managed cluster properties for snapshot, these properties are read only.
 */
@added(Versions.v2025_10_02_preview)
model ManagedClusterPropertiesForSnapshot {
  /**
   * The current kubernetes version.
   */
  kubernetesVersion?: string;

  /**
   * The current managed cluster sku.
   */
  sku?: ManagedClusterSKU;

  /**
   * Whether the cluster has enabled Kubernetes Role-Based Access Control or not.
   */
  enableRbac?: boolean;

  /**
   * The current network profile.
   */
  @visibility(Lifecycle.Read)
  networkProfile?: NetworkProfileForSnapshot;
}

/**
 * network profile for managed cluster snapshot, these properties are read only.
 */
@added(Versions.v2025_10_02_preview)
model NetworkProfileForSnapshot {
  /**
   * networkPlugin for managed cluster snapshot.
   */
  networkPlugin?: NetworkPlugin;

  /**
   * NetworkPluginMode for managed cluster snapshot.
   */
  networkPluginMode?: NetworkPluginMode;

  /**
   * networkPolicy for managed cluster snapshot.
   */
  networkPolicy?: NetworkPolicy;

  /**
   * networkMode for managed cluster snapshot.
   */
  networkMode?: NetworkMode;

  /**
   * loadBalancerSku for managed cluster snapshot.
   */
  loadBalancerSku?: LoadBalancerSku;
}

/**
 * Whether the version is default or not and support info.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model GuardrailsAvailableVersionsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isDefaultVersion?: boolean;

  /**
   * Whether the version is preview or stable.
   */
  @visibility(Lifecycle.Read)
  support?: GuardrailsSupport;
}

/**
 * Hold values properties, which is array of GuardrailsVersions
 */
@added(Versions.v2025_10_02_preview)
model GuardrailsAvailableVersionsList
  is Azure.Core.Page<GuardrailsAvailableVersion>;

/**
 * Whether the version is default or not and support info.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model SafeguardsAvailableVersionsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  isDefaultVersion?: boolean;

  /**
   * Whether the version is preview or stable.
   */
  @visibility(Lifecycle.Read)
  support?: SafeguardsSupport;
}

/**
 * Hold values properties, which is array of SafeguardsVersions
 */
@added(Versions.v2025_10_02_preview)
model SafeguardsAvailableVersionsList
  is Azure.Core.Page<SafeguardsAvailableVersion>;

/**
 * Holds an array of MeshRevisionsProfiles
 */
model MeshRevisionProfileList is Azure.Core.Page<MeshRevisionProfile>;

/**
 * Mesh revision profile properties for a mesh
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MeshRevisionProfileProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  meshRevisions?: MeshRevision[];
}

/**
 * An upgradeable mesh revision
 */
scalar MeshRevisionUpgradesType extends string;
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
  upgrades?: MeshRevisionUpgradesType[];

  /**
   * List of items this revision of service mesh is compatible with, and their associated versions.
   */
  @identifiers(#[])
  compatibleWith?: CompatibleVersions[];
}

/**
 * A compatible product/service version.
 */
scalar CompatibleVersionsVersionsType extends string;

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
  versions?: CompatibleVersionsVersionsType[];
}

/**
 * Holds an array of MeshUpgradeProfiles
 */
model MeshUpgradeProfileList is Azure.Core.Page<MeshUpgradeProfile>;

/**
 * Mesh upgrade profile properties for a major.minor release.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MeshUpgradeProfileProperties extends MeshRevision {}

/**
 * Properties for trusted access role binding
 */
model TrustedAccessRoleBindingProperties {
  /**
   * The current provisioning state of trusted access role binding.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TrustedAccessRoleBindingProvisioningState;

  /**
   * The ARM resource ID of source resource that trusted access is configured for.
   */
  sourceResourceId: Azure.Core.armResourceIdentifier;

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
  @visibility(Lifecycle.Read)
  sourceResourceType?: string;

  /**
   * Name of role, name is unique under a source resource type
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * List of rules for the role. This maps to 'rules' property of [Kubernetes Cluster Role](https://kubernetes.io/docs/reference/kubernetes-api/authorization-resources/cluster-role-v1/#ClusterRole).
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  rules?: TrustedAccessRoleRule[];
}

/**
 * Rule for trusted access role
 */
model TrustedAccessRoleRule {
  /**
   * List of allowed verbs
   */
  @visibility(Lifecycle.Read)
  verbs?: string[];

  /**
   * List of allowed apiGroups
   */
  @visibility(Lifecycle.Read)
  apiGroups?: string[];

  /**
   * List of allowed resources
   */
  @visibility(Lifecycle.Read)
  resources?: string[];

  /**
   * List of allowed names
   */
  @visibility(Lifecycle.Read)
  resourceNames?: string[];

  /**
   * List of allowed nonResourceURLs
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  nonResourceURLs?: string[];
}

/**
 * The properties of the machine
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MachineProperties {
  /**
   * network properties of the machine
   */
  @visibility(Lifecycle.Read)
  network?: MachineNetworkProperties;

  /**
   * Azure resource id of the machine. It can be used to GET underlying VM Instance
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets/virtualMachines";
    }
  ]>;

  /**
   * The hardware and GPU settings of the machine.
   */
  @added(Versions.v2025_10_02_preview)
  hardware?: MachineHardwareProfile;

  /**
   * The operating system and disk used by the machine.
   */
  @added(Versions.v2025_10_02_preview)
  operatingSystem?: MachineOSProfile;

  /**
   * The Kubernetes configurations used by the machine.
   */
  @added(Versions.v2025_10_02_preview)
  kubernetes?: MachineKubernetesProfile;

  /**
   * Machine only allows 'System' and 'User' mode.
   */
  @added(Versions.v2025_10_02_preview)
  mode?: AgentPoolMode;

  /**
   * The security settings of the machine.
   */
  @added(Versions.v2025_10_02_preview)
  security?: MachineSecurityProfile;

  /**
   * The priority for the machine. If not specified, the default is 'Regular'.
   */
  @added(Versions.v2025_10_02_preview)
  priority?: ScaleSetPriority = ScaleSetPriority.Regular;

  /**
   * The version of node image.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  nodeImageVersion?: string;

  /**
   * The current deployment or provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The tags to be persisted on the machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  tags?: Record<string>;

  /**
   * Unique read-only string used to implement optimistic concurrency. The eTag value will change when the resource is updated. Specify an if-match or if-none-match header with the eTag value for a subsequent request to enable optimistic concurrency per the normal eTag convention.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Contains read-only information about the machine.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  status?: MachineStatus;
}

/**
 * network properties of the machine
 */
model MachineNetworkProperties {
  /**
   * IPv4, IPv6 addresses of the machine
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  ipAddresses?: MachineIpAddress[];

  /**
   * The ID of the subnet which node and optionally pods will join on startup. If this is not specified, a VNET and subnet will be generated and used. If no podSubnetID is specified, this applies to nodes and pods, otherwise it applies to just nodes. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  vnetSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The ID of the subnet which pods will join when launched. If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  podSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Whether the machine is allocated its own public IP. Some scenarios may require the machine to receive their own dedicated public IP addresses. A common scenario is for gaming workloads, where a console needs to make a direct connection to a cloud virtual machine to minimize hops. The default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  enableNodePublicIP?: boolean;

  /**
   * The public IP prefix ID which VM node should use IPs from. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  nodePublicIPPrefixID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * IPTags of instance-level public IPs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  nodePublicIPTags?: IPTag[];
}

/**
 * The machine IP address details.
 */
model MachineIpAddress {
  /**
   * To determine if address belongs IPv4 or IPv6 family
   */
  @visibility(Lifecycle.Read)
  family?: IPFamily;

  /**
   * IPv4 or IPv6 address of the machine
   */
  @visibility(Lifecycle.Read)
  ip?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model LoadBalancerProperties {
  /**
   * Required field. A string value that must specify the ID of an existing agent pool. All nodes in the given pool will always be added to this load balancer. This agent pool must have at least one node and minCount>=1 for autoscaling operations. An agent pool can only be the primary pool for a single load balancer.
   */
  primaryAgentPoolName: string;

  /**
   * Whether to automatically place services on the load balancer. If not supplied, the default value is true. If set to false manually, both of the external and the internal load balancer will not be selected for services unless they explicitly target it.
   */
  allowServicePlacement?: boolean;

  /**
   * Only services that must match this selector can be placed on this load balancer.
   */
  serviceLabelSelector?: LabelSelector;

  /**
   * Services created in namespaces that match the selector can be placed on this load balancer.
   */
  serviceNamespaceSelector?: LabelSelector;

  /**
   * Nodes that match this selector will be possible members of this load balancer.
   */
  nodeSelector?: LabelSelector;

  /**
   * The current provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.
 */
@added(Versions.v2025_10_02_preview)
model LabelSelector {
  /**
   * matchLabels is an array of {key=value} pairs. A single {key=value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is `key`, the operator is `In`, and the values array contains only `value`. The requirements are ANDed.
   */
  matchLabels?: string[];

  /**
   * matchExpressions is a list of label selector requirements. The requirements are ANDed.
   */
  @identifiers(#[])
  matchExpressions?: LabelSelectorRequirement[];
}

/**
 * A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
 */
@added(Versions.v2025_10_02_preview)
model LabelSelectorRequirement {
  /**
   * key is the label key that the selector applies to.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;

  /**
   * operator represents a key's relationship to a set of values. Valid operators are In and NotIn
   */
  operator?: Operator;

  /**
   * values is an array of string values, the values array must be non-empty.
   */
  values?: string[];
}

/**
 * The names of the load balancers to rebalance. If set to empty, all load balancers will be rebalanced.
 */
@added(Versions.v2025_10_02_preview)
model RebalanceLoadBalancersRequestBody {
  /**
   * The load balancer names list.
   */
  loadBalancerNames?: string[];
}

/**
 * IdentityBinding properties.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingProperties {
  /**
   * Managed identity profile for the identity binding.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentity: IdentityBindingManagedIdentityProfile;

  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuer?: IdentityBindingOidcIssuerProfile;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: IdentityBindingProvisioningState;
}

/**
 * Managed identity profile for the identity binding.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingManagedIdentityProfile {
  /**
   * The resource ID of the managed identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^/subscriptions/[a-zA-Z0-9-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/[a-zA-Z0-9-]+$")
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The object ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  objectId?: string;

  /**
   * The client ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  clientId?: string;

  /**
   * The tenant ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  tenantId?: string;
}

/**
 * IdentityBinding OIDC issuer profile.
 */
@added(Versions.v2025_10_02_preview)
model IdentityBindingOidcIssuerProfile {
  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuerUrl?: url;
}

/**
 * The properties of JWTAuthenticator. For details on how to configure the properties of a JWT authenticator, please refer to the Kubernetes documentation: https://kubernetes.io/docs/reference/access-authn-authz/authentication/#using-authentication-configuration. Please note that not all fields available in the Kubernetes documentation are supported by AKS. For troubleshooting, please see https://aka.ms/aks-external-issuers-docs.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorProperties {
  /**
   * The current provisioning state of the JWT authenticator.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JWTAuthenticatorProvisioningState;

  /**
   * The JWT OIDC issuer details.
   */
  issuer: JWTAuthenticatorIssuer;

  /**
   * The rules that are applied to validate token claims to authenticate users. All the expressions must evaluate to true for validation to succeed.
   */
  @identifiers(#[])
  claimValidationRules?: JWTAuthenticatorValidationRule[];

  /**
   * The mappings that define how user attributes are extracted from the token claims.
   */
  claimMappings: JWTAuthenticatorClaimMappings;

  /**
   * The rules that are applied to the mapped user before completing authentication. All the expressions must evaluate to true for validation to succeed.
   */
  @identifiers(#[])
  userValidationRules?: JWTAuthenticatorValidationRule[];
}

/**
 * The OIDC issuer details for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorIssuer {
  /**
   * The issuer URL. The URL must begin with the scheme https and cannot contain a query string or fragment. This must match the "iss" claim in the presented JWT, and the issuer returned from discovery.
   */
  url: string;

  /**
   * The set of acceptable audiences the JWT must be issued to. At least one is required. When multiple is set, AudienceMatchPolicy is used in API Server configuration.
   */
  @minItems(1)
  audiences: string[];
}

/**
 * The validation rule for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorValidationRule {
  /**
   * The CEL expression used to validate the claim or attribute.
   */
  expression: string;

  /**
   * The validation error message.
   */
  message?: string;
}

/**
 * The claim mappings for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorClaimMappings {
  /**
   * The expression to extract username attribute from the token claims.
   */
  username: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract groups attribute from the token claims. When not provided, no groups are extracted from the token claims.
   */
  groups?: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract uid attribute from the token claims. When not provided, no uid is extracted from the token claims.
   */
  uid?: JWTAuthenticatorClaimMappingExpression;

  /**
   * The expression to extract extra attribute from the token claims. When not provided, no extra attributes are extracted from the token claims.
   */
  @identifiers(#[])
  extra?: JWTAuthenticatorExtraClaimMappingExpression[];
}

/**
 * The claim mapping expression for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorClaimMappingExpression {
  /**
   * The CEL expression used to access token claims.
   */
  expression: string;
}

/**
 * The extra claim mapping expression for JWTAuthenticator.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model JWTAuthenticatorExtraClaimMappingExpression {
  /**
   * The key of the extra attribute.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key: string;

  /**
   * The CEL expression used to extract the value of the extra attribute.
   */
  valueExpression: string;
}

/**
 * Mesh membership properties of a managed cluster.
 */
@added(Versions.v2025_10_02_preview)
model MeshMembershipProperties {
  /**
   * The current provisioning state of the Mesh Membership.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MeshMembershipProvisioningState;

  /**
   * The ARM resource id for the managed mesh member. This is of the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppLink/applinks/{appLinkName}/appLinkMembers/{appLinkMemberName}'. Visit https://aka.ms/applink for more information.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  managedMeshID: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppLink/applinks";
    }
  ]>;
}

/**
 * The List Operation response.
 */
model OperationListResult {
  /**
   * The list of operations
   */
  @pageItems
  value: OperationValue[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;
}

/**
 * The result of a request to list mesh memberships in a managed cluster.
 */
@added(Versions.v2025_10_02_preview)
model MeshMembershipsListResult {
  /**
   * The list of mesh memberships.
   */
  @pageItems
  value: MeshMembership[];

  @doc("The URL to get the next set of mesh membership results.")
  @nextLink
  nextLink?: ResourceLocation<MeshMembership>;
}
