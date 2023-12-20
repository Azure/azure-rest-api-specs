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
@doc("A private link resource")
@parentResource(MonitorPrivateLinkScope)
model MonitorPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface MonitorPrivateLinkResources {
  @doc("Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.")
  get is ArmResourceRead<MonitorPrivateLinkResource>;
  @doc("Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.")
  listByPrivateLinkScope is ArmResourceListByParent<MonitorPrivateLinkResource>;
}
