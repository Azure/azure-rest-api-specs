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

namespace Microsoft.Kusto;
@doc("A private link resource")
@parentResource(Cluster)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^.*$")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Returns the list of private link resources.")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
