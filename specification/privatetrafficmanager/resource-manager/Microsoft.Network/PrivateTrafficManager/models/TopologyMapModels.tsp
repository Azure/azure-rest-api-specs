import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Network;

/** The provisioning state of the resource. */
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",
}

@doc("Class representing the Topology Map properties.")
model TopologyMapProperties {
  @doc("The list of Sites in the Topology Map.")
  sites?: Site[];

  @doc("The Name of the CatchAll site. There is only one CatchAll site in a TopologyMap")
  catchAllSiteName?: string;

  @doc("The provisioning state of the TopologyMap resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
