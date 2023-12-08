import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CosmosDBForPostgreSqlCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("Represents a cluster role.")
@parentResource(CosmosDBForPostgreSqlCluster)
model CosmosDBForPostgreSqlRole is ProxyResource<RoleProperties> {
  @doc("The name of the cluster role.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("roleName")
  @segment("roles")
  name: string;
}

@armResourceOperations
interface CosmosDBForPostgreSqlRoles {
  @doc("Gets information about a cluster role.")
  get is ArmResourceRead<CosmosDBForPostgreSqlRole>;
  @doc("Creates a new role or updates an existing role.")
  create is ArmResourceCreateOrUpdateAsync<CosmosDBForPostgreSqlRole>;
  @doc("Deletes a cluster role.")
  delete is ArmResourceDeleteWithoutOkAsync<CosmosDBForPostgreSqlRole>;
  @doc("List all the roles in a given cluster.")
  listByCluster is ArmResourceListByParent<CosmosDBForPostgreSqlRole>;
}
