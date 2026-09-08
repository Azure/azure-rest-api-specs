import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_09_01)
@doc("A service-managed node allocated to a HorizonDB pool.")
@parentResource(HorizonDbPool)
model Node is Azure.ResourceManager.ProxyResource<NodeProperties> {
  ...ResourceNameParameter<
    Resource = Node,
    KeyName = "nodeName",
    SegmentName = "nodes",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Nodes are read-only service-managed resources whose allocation lifecycle is represented by the parent pool; they do not have an independent provisioning lifecycle."
@added(Versions.v2026_09_01)
@doc("Properties of a service-managed HorizonDB node.")
model NodeProperties {
  @doc("The current role performed by the node within its pool.")
  @visibility(Lifecycle.Read)
  role: NodeRole;

  @doc("The availability zone in which the node is deployed.")
  @visibility(Lifecycle.Read)
  availabilityZone: string;
}

@added(Versions.v2026_09_01)
@doc("The role performed by a node within its HorizonDB pool.")
union NodeRole {
  string,

  @doc("The node accepts read and write traffic for its cluster.")
  ReadWrite: "ReadWrite",

  @doc("The node accepts read-only traffic.")
  ReadOnly: "ReadOnly",
}

@added(Versions.v2026_09_01)
@doc("Operations for service-managed HorizonDB nodes.")
@armResourceOperations
interface Nodes {
  @doc("Gets a node allocated to a HorizonDB pool.")
  get is ArmResourceRead<Node>;

  @doc("Lists the nodes allocated to a HorizonDB pool.")
  list is ArmResourceListByParent<Node>;
}
