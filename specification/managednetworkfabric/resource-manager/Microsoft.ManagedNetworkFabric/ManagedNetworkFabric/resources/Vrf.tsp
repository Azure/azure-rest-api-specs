import "../models/common.tsp";
import "../models/Vrf.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

@doc("Defines the Vrf resource. A Vrf is an isolated L3 routing domain rooted in a Fabric.")
@parentResource(Fabric)
@added(Versions.v2026_07_15_preview)
model Vrf is Azure.ResourceManager.TrackedResource<VrfProperties, false> {
  @doc("Name of the Vrf.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("vrfName")
  @segment("vrfs")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(Vrf.properties, "The Vrf properties.");

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Vrfs {
  @doc("Gets the specified Vrf.")
  get is ArmResourceRead<Vrf>;

  @doc("Creates or updates a Vrf.")
  create is ArmResourceCreateOrReplaceAsync<Vrf>;

  @doc("Updates a Vrf.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Vrf, VrfPatch>;

  @doc("Deletes the specified Vrf.")
  delete is ArmResourceDeleteWithoutOkAsync<Vrf>;

  @doc("Lists Vrfs by Fabric.")
  listByFabric is ArmResourceListByParent<Vrf>;
}

@@doc(Vrfs.create::parameters.resource, "Request payload.");
@@doc(Vrfs.update::parameters.properties, "Vrf properties to update.");
