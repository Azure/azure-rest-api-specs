import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./shared_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the trunked network.
 */
union TrunkedNetworkDetailedStatus {
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
 * The provisioning state of the trunked network.
 */
union TrunkedNetworkProvisioningState {
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
 * TrunkedNetworkList represents a list of trunked networks.
 */
model TrunkedNetworkList is Azure.Core.Page<TrunkedNetwork>;

/**
 * TrunkedNetworkPatchParameters represents the body of the request to patch the Trunked network.
 */
model TrunkedNetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * TrunkedNetworkProperties represents properties of the trunked network.
 */
model TrunkedNetworkProperties {
  ...TrunkedNetworkSpec;
  ...TrunkedNetworkStatus;

  /**
   * The provisioning state of the trunked network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TrunkedNetworkProvisioningState;
}

/**
 * TrunkedNetworkSpec represents the properties that are used as an input to the operator.
 */
model TrunkedNetworkSpec {
  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

  /**
   * The default interface name for this trunked network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The list of resource IDs representing the Network Fabric isolation domains. It can be any combination of l2IsolationDomain and l3IsolationDomain resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  isolationDomainIds: string[];

  /**
   * The list of vlans that are selected from the isolation domains for trunking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  vlans: int64[];
}

/**
 * TrunkedNetworkStatus represents the properties produced by the API implementing logic in the operator.
 */
model TrunkedNetworkStatus {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this trunked network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the trunked network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: TrunkedNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this trunked network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this trunked network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}
