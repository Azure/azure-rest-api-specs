import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Purview;
@doc("A privately linkable resource.")
@parentResource(Account)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The group identifier.")
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets a privately linkable resources for an account with given group identifier")
  getByGroupId is ArmResourceRead<PrivateLinkResource>;
  @doc("Gets a list of privately linkable resources for an account")
  listByAccount is ArmResourceListByParent<PrivateLinkResource>;
}
