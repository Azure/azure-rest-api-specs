import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Network;

@doc("The provisioning state of the top-level resource")
union provisioningStateProperties {
  string,

  @doc("Indicating the resource has been successfully provisioned")
  Succeeded: "Succeeded",

  @doc("Indicating that the resource provisioning has failed")
  Failed: "Failed",

  @doc("Indicating that the resource provisioning has been cancelled")
  Canceled: "Canceled",
}

@doc("Class representing the Topology Map properties.")
model TopologyMapProperties {
  @doc("The list of Sites in the Topology Map.")
  sites?: Site[];

  @doc("The Name of the CatchAll site. There is only one CatchAll site in a TopologyMap")
  catchAllSiteName?: string;

  @doc("The provisioning state of the TopologyMap resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningStateProperties;
}
