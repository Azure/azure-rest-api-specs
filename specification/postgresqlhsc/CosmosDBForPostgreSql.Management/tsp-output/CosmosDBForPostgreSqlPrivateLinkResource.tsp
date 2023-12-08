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
@doc("A private link resource.")
@parentResource(CosmosDBForPostgreSqlCluster)
model CosmosDBForPostgreSqlPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface CosmosDBForPostgreSqlPrivateLinkResources {
  @doc("Gets a private link resource for cluster.")
  get is ArmResourceRead<CosmosDBForPostgreSqlPrivateLinkResource>;
  @doc("Gets the private link resources for cluster.")
  listByCluster is ArmResourceListByParent<CosmosDBForPostgreSqlPrivateLinkResource>;
}
