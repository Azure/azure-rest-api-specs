import "../models/common.tsp";
import "../models/Peering.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

@doc("Defines the Peering resource. A Peering is an upstream BGP session bound to a Vrf.")
@parentResource(Vrf)
@added(Versions.v2026_07_15_preview)
model Peering is Azure.ResourceManager.TrackedResource<
  PeeringProperties,
  false
> {
  @doc("Name of the Peering.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("peeringName")
  @segment("peerings")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(Peering.properties, "The Peering properties.");

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Peerings {
  @doc("Gets the specified Peering.")
  get is ArmResourceRead<Peering>;

  @doc("Creates or updates a Peering.")
  create is ArmResourceCreateOrReplaceAsync<Peering>;

  @doc("Updates a Peering.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Peering, PeeringPatch>;

  @doc("Deletes the specified Peering.")
  delete is ArmResourceDeleteWithoutOkAsync<Peering>;

  @doc("Lists Peerings by Vrf.")
  listByVrf is ArmResourceListByParent<Peering>;
}

@@doc(Peerings.create::parameters.resource, "Request payload.");
@@doc(Peerings.update::parameters.properties, "Peering properties to update.");
