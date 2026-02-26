import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/EndpointModels.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.Network;
@@doc(Endpoint.name, "The name of the Private Traffic Manager endpoint.");
@@doc(Endpoint.properties,
  "The properties of the Private Traffic Manager endpoint."
);
@doc("Class representing a Private Traffic Manager endpoint.")
@parentResource(PrivateTrafficManagerProfile)
model Endpoint is ProxyResource<EndpointProperties> {
  ...ResourceNameParameter<Endpoint>;
}

@armResourceOperations
interface Endpoints {
  @doc("Gets a Private Traffic Manager endpoint.")
  get is ArmResourceRead<Endpoint>;

  @doc("Create or update a Private Traffic Manager endpoint.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Endpoint>;

  @doc("Updates a Private Traffic Manager endpoint.")
  update is ArmResourcePatchAsync<Endpoint, EndpointProperties>;

  @doc("Deletes a Private Traffic Manager endpoint.")
  delete is ArmResourceDeleteWithoutOkAsync<Endpoint>;

  @doc("Get Private Traffic Manager Endpoints by profile")
  listByParent is ArmResourceListByParent<Endpoint>;
}
