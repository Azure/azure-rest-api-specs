import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("A private link resource")
@parentResource(KustoCluster)
model KustoPrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @pattern("^.*$")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface KustoPrivateLinkResources {
  @doc("Gets a private link resource.")
  get is ArmResourceRead<KustoPrivateLinkResource>;
  @doc("Returns the list of private link resources.")
  list is ArmResourceListByParent<KustoPrivateLinkResource>;
}
