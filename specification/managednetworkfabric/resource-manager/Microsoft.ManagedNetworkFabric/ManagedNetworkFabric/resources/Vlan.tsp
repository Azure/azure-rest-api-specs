import "../models/common.tsp";
import "../models/Vlan.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

@doc("Defines the Vlan resource. Vlans declare an L2 segment within a Fabric.")
@parentResource(Fabric)
@added(Versions.v2026_07_15_preview)
model Vlan is Azure.ResourceManager.TrackedResource<VlanProperties, false> {
  @doc("Name of the Vlan.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("vlanName")
  @segment("vlans")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(Vlan.properties, "The Vlan properties.");

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Vlans {
  @doc("Gets the specified Vlan.")
  get is ArmResourceRead<Vlan>;

  @doc("Creates or updates a Vlan.")
  create is ArmResourceCreateOrReplaceAsync<Vlan>;

  @doc("Updates a Vlan.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Vlan, VlanPatch>;

  @doc("Deletes the specified Vlan.")
  delete is ArmResourceDeleteWithoutOkAsync<Vlan>;

  @doc("Lists Vlans by Fabric.")
  listByFabric is ArmResourceListByParent<Vlan>;
}

@@doc(Vlans.create::parameters.resource, "Request payload.");
@@doc(Vlans.update::parameters.properties, "Vlan properties to update.");
