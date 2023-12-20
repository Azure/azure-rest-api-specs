import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("A private link scoped resource")
@parentResource(MonitorPrivateLinkScope)
model MonitorPrivateLinkScopedResource
  is ProxyResource<ScopedResourceProperties> {
  @doc("The name of the scoped resource object.")
  @path
  @key("name")
  @segment("scopedResources")
  name: string;
}

@armResourceOperations
interface MonitorPrivateLinkScopedResources {
  @doc("Gets a scoped resource in a private link scope.")
  get is ArmResourceRead<MonitorPrivateLinkScopedResource>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MonitorPrivateLinkScopedResource>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<MonitorPrivateLinkScopedResource>;
  @doc("Gets all private endpoint connections on a private link scope.")
  listByPrivateLinkScope is ArmResourceListByParent<MonitorPrivateLinkScopedResource>;
}
