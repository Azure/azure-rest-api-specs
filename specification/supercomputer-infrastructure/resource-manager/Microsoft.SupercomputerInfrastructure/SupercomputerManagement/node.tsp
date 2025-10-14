import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./rack.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A node (baremetal compute resource) within a rack. */
@parentResource(Rack)
model Node is ProxyResource<NodeProperties> {
  ...ResourceNameParameter<Node>;
}

/** The properties of a node. */
model NodeProperties {
  /** The asset ID of the node. */
  @visibility(Lifecycle.Read)
  assetId?: string;

  /** The SKU of the physical node hardware. */
  @visibility(Lifecycle.Read)
  hardwareSku?: string;

  /** The hostname of the node in the logical network. */
  @visibility(Lifecycle.Read)
  hostname?: string;

  /** The unique identifier of the logical node. */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /** The status of the last operation on this node. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;
}

@armResourceOperations
interface Nodes {
  get is ArmResourceRead<Node>;
  listByRack is ArmResourceListByParent<Node>;
}
