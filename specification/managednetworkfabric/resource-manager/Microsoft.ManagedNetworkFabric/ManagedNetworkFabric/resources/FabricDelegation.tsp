import "../models/common.tsp";
import "../models/FabricDelegation.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

@doc("Defines the FabricDelegation resource. A FabricDelegation is a provider-side authorization that projects Fabric routing-domain policy into one customer resource group.")
@parentResource(Fabric)
@added(Versions.v2026_07_15_preview)
model FabricDelegation is Azure.ResourceManager.TrackedResource<
  FabricDelegationProperties,
  false
> {
  @doc("Name of the FabricDelegation.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("delegationName")
  @segment("delegations")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(FabricDelegation.properties, "The FabricDelegation properties.");

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface FabricDelegations {
  @doc("Gets the specified FabricDelegation.")
  get is ArmResourceRead<FabricDelegation>;

  @doc("Creates or updates a FabricDelegation.")
  create is ArmResourceCreateOrReplaceAsync<FabricDelegation>;

  @doc("Updates a FabricDelegation.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<FabricDelegation, FabricDelegationPatch>;

  @doc("Deletes the specified FabricDelegation.")
  delete is ArmResourceDeleteWithoutOkAsync<FabricDelegation>;

  @doc("Lists FabricDelegations by Fabric.")
  listByFabric is ArmResourceListByParent<FabricDelegation>;
}

@@doc(FabricDelegations.create::parameters.resource, "Request payload.");
@@doc(
  FabricDelegations.update::parameters.properties,
  "FabricDelegation properties to update."
);
