import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./AgentPool_models.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetworkCloud;

/**
 * The version lifecycle indicator.
 */
union AvailabilityLifecycle {
  string,

  /**
   * Preview availability
   */
  Preview: "Preview",

  /**
   * Generally available
   */
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The current status of the Kubernetes cluster.
 */
union KubernetesClusterDetailedStatus {
  string,

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The status representing the state of this feature.
 */
union FeatureDetailedStatus {
  string,

  /**
   * The Running status.
   */
  Running: "Running",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Unknown status.
   */
  Unknown: "Unknown",
}

/**
 * The size of the hugepages to allocate.
 */
union HugepagesSize {
  string,

  /**
   * 2M hugepages
   */
  `2M`: "2M",

  /**
   * 1G hugepages
   */
  `1G`: "1G",
}

/**
 * The indicator of how this network will be utilized by the Kubernetes cluster.
 */
union KubernetesPluginType {
  string,

  /**
   * DPDK plugin type
   */
  DPDK: "DPDK",

  /**
   * SRIOV plugin type
   */
  SRIOV: "SRIOV",

  /**
   * OSDevice plugin type
   */
  OSDevice: "OSDevice",

  /**
   * MACVLAN plugin type
   */
  MACVLAN: "MACVLAN",

  /**
   * IPVLAN plugin type
   */
  IPVLAN: "IPVLAN",
}

/**
 * The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
 */
union AdvertiseToFabric {
  string,

  /**
   * Advertise to fabric
   */
  True: "True",

  /**
   * Do not advertise to fabric
   */
  False: "False",
}

/**
 * The indicator to determine if automatic allocation from the pool should occur.
 */
union BfdEnabled {
  string,

  /**
   * BFD is enabled for this BGP peer.
   */
  True: "True",

  /**
   * BFD is disabled for this BGP peer.
   */
  False: "False",
}

/**
 * The indicator to enable multi-hop peering support.
 */
union BgpMultiHop {
  string,

  /**
   * Enable multi-hop peering support.
   */
  True: "True",

  /**
   * Disable multi-hop peering support.
   */
  False: "False",
}

/**
 * The indicator to specify if the load balancer peers with the network fabric.
 */
union FabricPeeringEnabled {
  string,

  /**
   * Enable fabric peering.
   */
  True: "True",

  /**
   * Disable fabric peering.
   */
  False: "False",
}

/**
 * The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
 */
union L3NetworkConfigurationIpamEnabled {
  string,

  /**
   * IP address management enabled.
   */
  True: "True",

  /**
   * IP address management disabled.
   */
  False: "False",
}

/**
 * The detailed state of this node.
 */
union KubernetesClusterNodeDetailedStatus {
  string,

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Running status.
   */
  Running: "Running",

  /**
   * The Scheduling status.
   */
  Scheduling: "Scheduling",

  /**
   * The Stopped status.
   */
  Stopped: "Stopped",

  /**
   * The Terminating status.
   */
  Terminating: "Terminating",

  /**
   * The Unknown status.
   */
  Unknown: "Unknown",
}

/**
 * The power state of this node.
 */
union KubernetesNodePowerState {
  string,

  /**
   * The node is powered on.
   */
  On: "On",

  /**
   * The node is powered off.
   */
  Off: "Off",

  /**
   * The node is in an unknown power state.
   */
  Unknown: "Unknown",
}

/**
 * The role of this node in the cluster.
 */
union KubernetesNodeRole {
  string,

  /**
   * Control plane role
   */
  ControlPlane: "ControlPlane",

  /**
   * Worker role
   */
  Worker: "Worker",
}

/**
 * The provisioning state of the Kubernetes cluster resource.
 */
union KubernetesClusterProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The InProgress status.
   */
  InProgress: "InProgress",

  /**
   * The Created status.
   */
  Created: "Created",

  /**
   * The Updating status.
   */
  Updating: "Updating",

  /**
   * The Deleting status.
   */
  Deleting: "Deleting",
}

/**
 * KubernetesClusterList represents a list of Kubernetes clusters.
 */
model KubernetesClusterList is Azure.Core.Page<KubernetesCluster>;

/**
 * KubernetesClusterProperties represents the properties of Kubernetes cluster resource.
 */
model KubernetesClusterProperties {
  ...KubernetesClusterSpec;
  ...KubernetesClusterStatus;

  /**
   * The provisioning state of the Kubernetes cluster resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubernetesClusterProvisioningState;
}

/**
 * KubernetesClusterSpec represents properties of the Kubernetes cluster resource.
 */
model KubernetesClusterSpec {
  /**
   * The Azure Active Directory Integration properties.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aadConfiguration?: AadConfiguration;

  /**
   * The administrative credentials that will be applied to the control plane and agent pool nodes that do not specify their own values.
   */
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The defining characteristics of the control plane for this Kubernetes Cluster.
   */
  controlPlaneNodeConfiguration: ControlPlaneNodeConfiguration;

  /**
   * The agent pools that are created with this Kubernetes cluster for running critical system services and workloads. This data in this field is only used during creation, and the field will be empty following the creation of the Kubernetes Cluster. After creation, the management of agent pools is done using the agentPools sub-resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["name"])
  @minItems(1)
  initialAgentPoolConfigurations: InitialAgentPoolConfiguration[];

  /**
   * The Kubernetes version for this cluster.
   */
  kubernetesVersion: string;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The configuration of the Kubernetes cluster networking, including the attachment of networks that span the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkConfiguration: NetworkConfiguration;
}

/**
 * KubernetesClusterStatus denotes the status of the Kubernetes cluster resource.
 */
model KubernetesClusterStatus {
  ...KubernetesClusterReadOnlyProperties;
}

/**
 * KubernetesClusterReadOnlyProperties represents the read-only properties of the Kubernetes cluster resource.
 */
model KubernetesClusterReadOnlyProperties {
  /**
   * The full list of network resource IDs that are attached to this cluster, including those attached only to specific agent pools.
   */
  @visibility(Lifecycle.Read)
  attachedNetworkIds?: string[];

  /**
   * The list of versions that this Kubernetes cluster can be upgraded to.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  availableUpgrades?: AvailableUpgrade[];

  /**
   * The resource ID of the Network Cloud cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the connected cluster set up when this Kubernetes cluster is created.
   */
  @visibility(Lifecycle.Read)
  connectedClusterId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;

  /**
   * The current running version of Kubernetes on the control plane.
   */
  @visibility(Lifecycle.Read)
  controlPlaneKubernetesVersion?: string;

  /**
   * The current status of the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The current feature settings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  featureStatuses?: FeatureStatus[];

  /**
   * The details of the nodes in this cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  nodes?: KubernetesClusterNode[];
}

/**
 * AadConfiguration represents the Azure Active Directory Integration properties.
 */
model AadConfiguration {
  /**
   * The list of Azure Active Directory group object IDs that will have an administrative role on the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  adminGroupObjectIds: string[];
}

/**
 * AdministratorConfiguration represents the administrative credentials that will be applied to the control plane and agent pool nodes in Kubernetes clusters.
 */
model AdministratorConfiguration {
  /**
   * The user name for the administrator that will be applied to the operating systems that run Kubernetes nodes. If not supplied, a user name will be chosen by the service.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  adminUsername?: string;

  /**
   * The SSH configuration for the operating systems that run the nodes in the Kubernetes cluster. In some cases, specification of public keys may be required to produce a working environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  sshPublicKeys?: SshPublicKey[];
}

/**
 * AvailableUpgrade represents an upgrade available for a Kubernetes cluster.
 */
model AvailableUpgrade {
  /**
   * The version lifecycle indicator.
   */
  @visibility(Lifecycle.Read)
  availabilityLifecycle?: AvailabilityLifecycle;

  /**
   * The version available for upgrading.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * ControlPlaneNodeConfiguration represents the selection of virtual machines and size of the control plane for a Kubernetes cluster.
 */
model ControlPlaneNodeConfiguration {
  /**
   * The administrator credentials to be used for the nodes in the control plane.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster to be used for the provisioning of nodes in the control plane. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  @minValue(1)
  count: int64;

  /**
   * The name of the VM SKU supplied during creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}

/**
 * FeatureStatus contains information regarding a Kubernetes cluster feature.
 */
model FeatureStatus {
  /**
   * The status representing the state of this feature.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: FeatureDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The name of the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The version of the feature.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * InitialAgentPoolConfiguration specifies the configuration of a pool of virtual machines that are initially defined with a Kubernetes cluster.
 */
model InitialAgentPoolConfiguration {
  ...AgentPoolConfiguration;

  /**
   * The name that will be used for the agent pool resource representing this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  name: string;
}

/**
 * AgentOptions are configurations that will be applied to each agent in an agent pool.
 */
model AgentOptions {
  /**
   * The number of hugepages to allocate.
   */
  hugepagesCount: int64;

  /**
   * The size of the hugepages to allocate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hugepagesSize?: HugepagesSize = HugepagesSize.`2M`;
}

/**
 * AttachedNetworkConfiguration represents the set of workload networks to attach to a resource.
 */
model AttachedNetworkConfiguration {
  /**
   * The list of Layer 2 Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["networkId", "pluginType"])
  l2Networks?: L2NetworkAttachmentConfiguration[];

  /**
   * The list of Layer 3 Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["networkId", "pluginType"])
  l3Networks?: L3NetworkAttachmentConfiguration[];

  /**
   * The list of Trunked Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["networkId", "pluginType"])
  trunkedNetworks?: TrunkedNetworkAttachmentConfiguration[];
}

/**
 * L2NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 2 network.
 */
model L2NetworkAttachmentConfiguration {
  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l2Networks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
}

/**
 * L3NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 3 network.
 */
model L3NetworkAttachmentConfiguration {
  /**
   * The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipamEnabled?: L3NetworkConfigurationIpamEnabled = L3NetworkConfigurationIpamEnabled.False;

  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l3Networks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
}

/**
 * TrunkedNetworkAttachmentConfiguration represents the configuration of the attachment of a trunked network.
 */
model TrunkedNetworkAttachmentConfiguration {
  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/trunkedNetworks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
}

/**
 * KubernetesLabel represents a single entry for a Kubernetes label or taint such as those used on a node or pod.
 */
model KubernetesLabel {
  /**
   * The name of the label or taint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  key: string;

  /**
   * The value of the label or taint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  value: string;
}

/**
 * AgentPoolUpgradeSettings specifies the upgrade settings for an agent pool.
 */
model AgentPoolUpgradeSettings {
  /**
   * The maximum time in seconds that is allowed for a node drain to complete before proceeding with the upgrade of the agent pool. If not specified during creation, a value of 1800 seconds is used.
   */
  @maxValue(86400)
  @minValue(60)
  drainTimeout?: int64;

  /**
   * The maximum number or percentage of nodes that are surged during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified during creation, a value of 1 is used. One of MaxSurge and MaxUnavailable must be greater than 0.
   */
  maxSurge?: string;

  /**
   * The maximum number or percentage of nodes that can be unavailable during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified during creation, a value of 0 is used. One of MaxSurge and MaxUnavailable must be greater than 0.
   */
  maxUnavailable?: string;
}

/**
 * NetworkConfiguration specifies the Kubernetes cluster network related configuration.
 */
model NetworkConfiguration {
  /**
   * The configuration of networks being attached to the cluster for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The configuration of the BGP service load balancer for this Kubernetes cluster. A maximum of one service load balancer may be specified, either Layer 2 or BGP.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bgpServiceLoadBalancerConfiguration?: BgpServiceLoadBalancerConfiguration;

  /**
   * The resource ID of the associated Cloud Services network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cloudServicesNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the Layer 3 network that is used for creation of the Container Networking Interface network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cniNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in service CIDR.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dnsServiceIp?: string;

  /**
   * The configuration of the Layer 2 service load balancer for this Kubernetes cluster. A maximum of one service load balancer may be specified, either Layer 2 or BGP.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2ServiceLoadBalancerConfiguration?: L2ServiceLoadBalancerConfiguration;

  /**
   * The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  podCidrs?: string[];

  /**
   * The CIDR notation IP ranges from which to assign service IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceCidrs?: string[];
}

/**
 * BgpServiceLoadBalancerConfiguration represents the configuration of a BGP service load balancer.
 */
model BgpServiceLoadBalancerConfiguration {
  /**
   * The association of IP address pools to the communities and peers, allowing for announcement of IPs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  bgpAdvertisements?: BgpAdvertisement[];

  /**
   * The list of additional BgpPeer entities that the Kubernetes cluster will peer with. All peering must be explicitly defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  bgpPeers?: ServiceLoadBalancerBgpPeer[];

  /**
   * The indicator to specify if the load balancer peers with the network fabric.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricPeeringEnabled?: FabricPeeringEnabled = FabricPeeringEnabled.True;

  /**
   * The list of pools of IP addresses that can be allocated to load balancer services.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  ipAddressPools?: IpAddressPool[];
}

/**
 * BgpAdvertisement represents the association of IP address pools to the communities and peers.
 */
model BgpAdvertisement {
  /**
   * The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  advertiseToFabric?: AdvertiseToFabric = AdvertiseToFabric.True;

  /**
   * The names of the BGP communities to be associated with the announcement, utilizing a BGP community string in 1234:1234 format.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communities?: string[];

  /**
   * The names of the IP address pools associated with this announcement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipAddressPools: string[];

  /**
   * The names of the BGP peers to limit this advertisement to. If no values are specified, all BGP peers will receive this advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peers?: string[];
}

/**
 * ServiceLoadBalancerBgpPeer represents the configuration of the BGP service load balancer for the Kubernetes cluster.
 */
model ServiceLoadBalancerBgpPeer {
  /**
   * The indicator of BFD enablement for this BgpPeer.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bfdEnabled?: BfdEnabled = BfdEnabled.False;

  /**
   * The indicator to enable multi-hop peering support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bgpMultiHop?: BgpMultiHop = BgpMultiHop.False;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The requested BGP hold time value. This field uses ISO 8601 duration format, for example P1H.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  holdTime?: string;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The requested BGP keepalive time value. This field uses ISO 8601 duration format, for example P1H.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keepAliveTime?: string;

  /**
   * The autonomous system number used for the local end of the BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(0)
  @maxValue(4294967295)
  myAsn?: int64;

  /**
   * The name used to identify this BGP peer for association with a BGP advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  /**
   * The authentication password for routers enforcing TCP MD5 authenticated sessions.
   */
  @visibility(Lifecycle.Create)
  @maxLength(80)
  @pattern("^[a-zA-Z0-9]{0,80}$")
  @secret
  password?: string;

  /**
   * The IPv4 or IPv6 address used to connect this BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peerAddress: string;

  /**
   * The autonomous system number expected from the remote end of the BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(0)
  @maxValue(4294967295)
  peerAsn: int64;

  /**
   * The port used to connect this BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peerPort?: int64 = 179;
}

/**
 * IpAddressPool represents a pool of IP addresses that can be allocated to a service.
 */
model IpAddressPool {
  /**
   * The list of IP address ranges. Each range can be a either a subnet in CIDR format or an explicit start-end range of IP addresses. For a BGP service load balancer configuration, only CIDR format is supported and excludes /32 (IPv4) and /128 (IPv6) prefixes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  addresses: string[];

  /**
   * The indicator to determine if automatic allocation from the pool should occur.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoAssign?: BfdEnabled = BfdEnabled.True;

  /**
   * The name used to identify this IP address pool for association with a BGP advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  /**
   * The indicator to prevent the use of IP addresses ending with .0 and .255 for this pool. Enabling this option will only use IP addresses between .1 and .254 inclusive.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  onlyUseHostIps?: BfdEnabled = BfdEnabled.True;
}

/**
 * L2ServiceLoadBalancerConfiguration represents the configuration of a layer 2 service load balancer.
 */
model L2ServiceLoadBalancerConfiguration {
  /**
   * The list of pools of IP addresses that can be allocated to load balancer services.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  ipAddressPools?: IpAddressPool[];
}

/**
 * KubernetesClusterNode represents the details of a node in a Kubernetes cluster.
 */
model KubernetesClusterNode {
  /**
   * The resource ID of the agent pool that this node belongs to. This value is not represented on control plane nodes.
   */
  @visibility(Lifecycle.Read)
  agentPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/kubernetesClusters/agentPools";
    }
  ]>;

  /**
   * The availability zone this node is running within.
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts this node.
   */
  @visibility(Lifecycle.Read)
  bareMetalMachineId?: Azure.Core.armResourceIdentifier;

  /**
   * The number of CPU cores configured for this node, derived from the VM SKU specified.
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * The detailed state of this node.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterNodeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The size of the disk configured for this node. Allocations are measured in gibibytes.
   */
  @visibility(Lifecycle.Read)
  @clientName("diskSizeGB")
  @encodedName("application/json", "diskSizeGB")
  diskSizeGb?: int64;

  /**
   * The machine image used to deploy this node.
   */
  @visibility(Lifecycle.Read)
  image?: string;

  /**
   * The currently running version of Kubernetes and bundled features running on this node.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The list of labels on this node that have been assigned to the agent pool containing this node.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["key"])
  labels?: KubernetesLabel[];

  /**
   * The amount of memory configured for this node, derived from the vm SKU specified. Allocations are measured in gibibytes.
   */
  @visibility(Lifecycle.Read)
  @clientName("memorySizeGB")
  @encodedName("application/json", "memorySizeGB")
  memorySizeGb?: int64;

  /**
   * The mode of the agent pool containing this node. Not applicable for control plane nodes.
   */
  @visibility(Lifecycle.Read)
  mode?: AgentPoolMode;

  /**
   * The name of this node, as realized in the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The NetworkAttachments made to this node.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["networkAttachmentName"])
  networkAttachments?: NetworkAttachment[];

  /**
   * The power state of this node.
   */
  @visibility(Lifecycle.Read)
  powerState?: KubernetesNodePowerState;

  /**
   * The role of this node in the cluster.
   */
  @visibility(Lifecycle.Read)
  role?: KubernetesNodeRole;

  /**
   * The list of taints that have been assigned to the agent pool containing this node.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["key"])
  taints?: KubernetesLabel[];

  /**
   * The VM SKU name that was used to create this cluster node.
   */
  @visibility(Lifecycle.Read)
  vmSkuName?: string;
}

/**
 * KubernetesClusterPatchParameters represents the body of the request to patch the Hybrid AKS cluster.
 */
model KubernetesClusterPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: KubernetesClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * KubernetesClusterPatchProperties represents the properties of the Kubernetes cluster that can be patched.
 */
model KubernetesClusterPatchProperties {
  /**
   * The configuration of the default administrator credentials.
   */
  administratorConfiguration?: AdministratorConfigurationPatch;

  /**
   * The defining characteristics of the control plane that can be patched for this Kubernetes cluster.
   */
  controlPlaneNodeConfiguration?: ControlPlaneNodePatchConfiguration;

  /**
   * The Kubernetes version for this cluster.
   */
  kubernetesVersion?: string;
}

/**
 * AdministratorConfigurationPatch represents the patching capabilities for the administrator configuration.
 */
model AdministratorConfigurationPatch {
  /**
   * SshPublicKey represents the public key used to authenticate with a resource through SSH.
   */
  @identifiers(#["keyData"])
  sshPublicKeys?: SshPublicKey[];
}

/**
 * ControlPlaneNodePatchConfiguration represents the properties of the control plane that can be patched for this Kubernetes cluster.
 */
model ControlPlaneNodePatchConfiguration {
  /**
   * The configuration of administrator credentials for the control plane nodes.
   */
  administratorConfiguration?: AdministratorConfigurationPatch;

  /**
   * The number of virtual machines that use this configuration.
   */
  @minValue(1)
  count?: int64;
}

/**
 * KubernetesClusterRestartNodeParameters represents the body of the request to restart the node of a Kubernetes cluster.
 */
model KubernetesClusterRestartNodeParameters {
  /**
   * The name of the node to restart.
   */
  nodeName: string;
}

/**
 * AgentPoolConfiguration specifies the configuration of a pool of nodes.
 */
model AgentPoolConfiguration {
  /**
   * The administrator credentials to be used for the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The configurations that will be applied to each agent in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentOptions?: AgentOptions;

  /**
   * The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  count: int64;

  /**
   * The labels applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["key"])
  labels?: KubernetesLabel[];

  /**
   * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: AgentPoolMode;

  /**
   * The taints applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["key"])
  taints?: KubernetesLabel[];

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * The name of the VM SKU that determines the size of resources allocated for node VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}
