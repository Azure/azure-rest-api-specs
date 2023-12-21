import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("A private link scoped resource")
@parentResource(AzureMonitorPrivateLinkScope)
model ScopedResource is ProxyResource<ScopedResourceProperties> {
  @doc("The name of the scoped resource object.")
  @path
  @key("name")
  @segment("scopedResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkScopedResources {
  @doc("Gets a scoped resource in a private link scope.")
  get is ArmResourceRead<ScopedResource>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScopedResource>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<ScopedResource>;
  @doc("Gets all private endpoint connections on a private link scope.")
  listByPrivateLinkScope is ArmResourceListByParent<ScopedResource>;
}
