import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
@doc("A private link resource.")
@parentResource(Cluster)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource for cluster.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Gets the private link resources for cluster.")
  listByCluster is ArmResourceListByParent<PrivateLinkResource>;
}
