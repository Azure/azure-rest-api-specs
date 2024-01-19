import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
@doc("A private link resource")
@parentResource(AzureMonitorPrivateLinkScope)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.")
  listByPrivateLinkScope is ArmResourceListByParent<PrivateLinkResource>;
}
