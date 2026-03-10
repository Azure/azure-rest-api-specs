import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./CommonModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

namespace Microsoft.ContainerService;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance pattern matches existing API structure and cannot be changed without breaking changes."
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  vnetSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The ID of the subnet which pods will join when launched. If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  podSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Pod IP Allocation Mode. The IP allocation mode for pods in the agent pool. Must be used with podSubnetId. The default is 'DynamicIndividual'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "The 'type' property represents AgentPoolType (System/User/Gateway), a business concept distinct from ARM resource type. Renaming would break existing clients."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AKS uses custom provisioning states beyond standard ARM states. Using string type for forward compatibility."
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  enableNodePublicIP?: boolean;

  /**
   * The public IP prefix ID which VM nodes should use IPs from. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined (e.g., tags, addon names, version numbers)."
  tags?: Record<string>;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined (e.g., tags, addon names, version numbers)."
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  linuxOSConfig?: LinuxOSConfig;

  /**
   * Whether to enable host based OS and data drive encryption. This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption
   */
  enableEncryptionAtHost?: boolean;

  /**
   * Whether to enable UltraSSD
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  enableUltraSSD?: boolean;

  /**
   * Whether to use a FIPS-enabled OS. See [Add a FIPS-enabled node pool](https://docs.microsoft.com/azure/aks/use-multiple-node-pools#add-a-fips-enabled-node-pool-preview) for more details.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  capacityReservationGroupID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/CapacityReservationGroups";
    }
  ]>;

  /**
   * The fully qualified resource ID of the Dedicated Host Group to provision virtual machines from, used only in creation scenario and not allowed to changed once set. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}. For more information see [Azure dedicated hosts](https://docs.microsoft.com/azure/virtual-machines/dedicated-hosts).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  @maxValue(31)
  @minValue(28)
  publicIPPrefixSize?: int32 = 31;
}

/** Artifact streaming profile for the agent pool. */
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined (e.g., tags, addon names, version numbers)."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  vnetDNSOverrides?: Record<LocalDNSOverride>;

  /**
   * KubeDNS overrides apply to DNS traffic from pods with dnsPolicy:ClusterFirst (referred to as KubeDNS traffic).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined (e.g., tags, addon names, version numbers)."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  kubeDNSOverrides?: Record<LocalDNSOverride>;
}

/**
 * Overrides for localDNS profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
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
 * Specifies a list of machine names from the agent pool to be deleted.
 */
model AgentPoolDeleteMachinesParameter {
  /**
   * The agent pool machine names.
   */
  machineNames: string[];
}
