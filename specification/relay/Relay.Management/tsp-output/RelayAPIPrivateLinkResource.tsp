import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Relay;
@doc("Information of the private link resource.")
@parentResource(RelayNamespace)
model RelayAPIPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The PrivateLinkResource name")
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface RelayAPIPrivateLinkResources {
  @doc("Gets a description for the specified Private Endpoint Connection name.")
  get is ArmResourceRead<RelayAPIPrivateLinkResource>;
  @doc("Gets lists of resources that supports Privatelinks.")
  list is ArmResourceListByParent<RelayAPIPrivateLinkResource>;
}
