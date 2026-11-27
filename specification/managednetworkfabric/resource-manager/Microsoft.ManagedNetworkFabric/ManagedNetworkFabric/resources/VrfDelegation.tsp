import "../models/common.tsp";
import "../models/VrfDelegation.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

@doc("Defines the VrfDelegation resource. A VrfDelegation is a provider-side allocation of one concrete Vrf under a Fabric delegation authorization.")
@parentResource(Vrf)
@added(Versions.v2026_07_15_preview)
model VrfDelegation is Azure.ResourceManager.TrackedResource<
  VrfDelegationProperties,
  false
> {
  @doc("Name of the VrfDelegation.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("delegationName")
  @segment("delegations")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(VrfDelegation.properties, "The VrfDelegation properties.");

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface VrfDelegations {
  @doc("Gets the specified VrfDelegation.")
  get is ArmResourceRead<VrfDelegation>;

  @doc("Creates or updates a VrfDelegation.")
  create is ArmResourceCreateOrReplaceAsync<VrfDelegation>;

  @doc("Updates a VrfDelegation.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VrfDelegation, VrfDelegationPatch>;

  @doc("Deletes the specified VrfDelegation.")
  delete is ArmResourceDeleteWithoutOkAsync<VrfDelegation>;

  @doc("Lists VrfDelegations by Vrf.")
  listByVrf is ArmResourceListByParent<VrfDelegation>;
}

@@doc(VrfDelegations.create::parameters.resource, "Request payload.");
@@doc(
  VrfDelegations.update::parameters.properties,
  "VrfDelegation properties to update."
);
