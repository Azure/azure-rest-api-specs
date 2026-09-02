import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./shared_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the L2 network.
 */
union L2NetworkDetailedStatus {
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
 * The provisioning state of the L2 network.
 */
union L2NetworkProvisioningState {
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
 * L2NetworkList represents a list of L2 networks.
 */
model L2NetworkList is Azure.Core.Page<L2Network>;

/**
 * L2NetworkPatchParameters represents the body of the request to patch the L2 network.
 */
model L2NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * L2NetworkProperties represents properties of the L2 network.
 */
model L2NetworkProperties {
  ...L2NetworkSpec;
  ...L2NetworkStatus;

  /**
   * The provisioning state of the L2 network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: L2NetworkProvisioningState;
}

/**
 * L2NetworkSpec represents the properties that are used as an input to the operator.
 */
model L2NetworkSpec {
  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

  /**
   * The default interface name for this L2 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The resource ID of the Network Fabric l2IsolationDomain.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2IsolationDomainId: Azure.Core.armResourceIdentifier;
}

/**
 * L2NetworkStatus represents the properties produced by the API implementing logic in the operator.
 */
model L2NetworkStatus {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L2 network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L2 network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: L2NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource ID(s) that are associated with this L2 network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource ID(s), excluding any Hybrid AKS virtual machines, that are currently using this L2 network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}
