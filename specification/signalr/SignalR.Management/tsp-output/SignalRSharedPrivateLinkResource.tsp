import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalR.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("Describes a Shared Private Link Resource")
@parentResource(SignalR)
model SignalRSharedPrivateLinkResource
  is ProxyResource<SharedPrivateLinkResourceProperties> {
  @doc("The name of the shared private link resource")
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  name: string;
}

@armResourceOperations
interface SignalRSharedPrivateLinkResources {
  @doc("Get the specified shared private link resource")
  get is ArmResourceRead<SignalRSharedPrivateLinkResource>;
  @doc("Create or update a shared private link resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SignalRSharedPrivateLinkResource>;
  @doc("Delete the specified shared private link resource")
  delete is ArmResourceDeleteAsync<SignalRSharedPrivateLinkResource>;
  @doc("List shared private link resources")
  list is ArmResourceListByParent<SignalRSharedPrivateLinkResource>;
}
