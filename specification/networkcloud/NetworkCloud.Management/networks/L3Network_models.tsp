import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./shared_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
 */
union HybridAksIpamEnabled {
  string,

  /**
   * Hybrid AKS IPAM allocation is enabled.
   */
  True: "True",

  /**
   * Hybrid AKS IPAM allocation is disabled.
   */
  False: "False",
}

/**
 * The type of the IP address allocation, defaulted to "DualStack".
 */
union IpAllocationType {
  string,

  /**
   * The IPV4 address allocation type.
   */
  IPV4: "IPV4",

  /**
   * The IPV6 address allocation type.
   */
  IPV6: "IPV6",

  /**
   * The DualStack address allocation type.
   */
  DualStack: "DualStack",
}

/**
 * The more detailed status of the L3 network.
 */
union L3NetworkDetailedStatus {
  string,

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the L3 network.
 */
union L3NetworkProvisioningState {
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
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",
}

/**
 * L3NetworkList represents a list of L3 networks.
 */
model L3NetworkList is Azure.Core.Page<L3Network>;

/**
 * L3NetworkPatchParameters represents the body of the request to patch the cloud services network.
 */
model L3NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * L3NetworkProperties represents properties of the L3 network.
 */
model L3NetworkProperties {
  ...L3NetworkSpec;
  ...L3NetworkStatus;

  /**
   * The provisioning state of the L3 network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: L3NetworkProvisioningState;
}

/**
 * L3NetworkSpec represents the properties that are used as an input to the operator.
 */
model L3NetworkSpec {
  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksIpamEnabled?: HybridAksIpamEnabled = HybridAksIpamEnabled.True;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

  /**
   * The default interface name for this L3 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The type of the IP address allocation, defaulted to "DualStack".
   */
  ipAllocationType?: IpAllocationType = IpAllocationType.DualStack;

  /**
   * The IPV4 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type is IPV4 or DualStack.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4ConnectedPrefix?: string;

  /**
   * The IPV6 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type is IPV6 or DualStack.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6ConnectedPrefix?: string;

  /**
   * The resource ID of the Network Fabric l3IsolationDomain.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l3IsolationDomainId: Azure.Core.armResourceIdentifier;

  /**
   * The VLAN from the l3IsolationDomain that is used for this network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vlan: int64;
}

/**
 * L3NetworkStatus represents the properties produced by the API implementing logic in the operator.
 */
model L3NetworkStatus {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L3 network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L3 network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: L3NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this L3 network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this L3 network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}
