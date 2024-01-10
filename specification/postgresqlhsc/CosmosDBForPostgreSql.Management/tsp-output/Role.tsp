import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DBforPostgreSQL;
@doc("Represents a cluster role.")
@parentResource(Cluster)
model Role is ProxyResource<RoleProperties> {
  @doc("The name of the cluster role.")
  @pattern("^[-\\w\\._]+$")
  @key("roleName")
  @segment("roles")
  name: string;
}

@armResourceOperations
interface Roles {
  @doc("Gets information about a cluster role.")
  get is ArmResourceRead<Role>;

  @doc("Creates a new role or updates an existing role.")
  create is ArmResourceCreateOrUpdateAsync<Role>;

  @doc("Deletes a cluster role.")
  delete is ArmResourceDeleteWithoutOkAsync<Role>;

  @doc("List all the roles in a given cluster.")
  listByCluster is ArmResourceListByParent<Role>;
}
