import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Role has no properties property
@doc("Compute role.")
@parentResource(DataBoxEdgeDevice)
model Role is ProxyResource<{}> {
  @doc("The role name.")
  @path
  @key("name")
  @segment("roles")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Roles {
  @doc("Gets a specific role by name.")
  get is ArmResourceRead<Role>;

  @doc("Create or update a role.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Role>;

  @doc("Deletes the role on the device.")
  delete is ArmResourceDeleteAsync<Role>;

  @doc("Lists all the roles configured in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Role>;
}

@@projectedName(Roles.createOrUpdate::parameters.resource, "json", "role");
@@extension(Roles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "role"
);
@@doc(Roles.createOrUpdate::parameters.resource, "The role properties.");
