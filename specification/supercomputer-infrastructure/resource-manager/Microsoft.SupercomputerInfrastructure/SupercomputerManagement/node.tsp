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
  /** The status of the last operation on this node. */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;
}

@armResourceOperations
interface Nodes {
  get is ArmResourceRead<Node>;
  listByRack is ArmResourceListByParent<Node>;
}
