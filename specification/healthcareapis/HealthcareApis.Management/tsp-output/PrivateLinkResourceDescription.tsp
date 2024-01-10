import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateLinkResourceDescription has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(ServicesDescription)
model PrivateLinkResourceDescription is ProxyResource<{}> {
  @doc("The name of the private link resource group.")
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface PrivateLinkResourceDescriptions_PrivateLinkResources {
  @doc("Gets a private link resource that need to be created for a service.")
  get is ArmResourceRead<PrivateLinkResourceDescription>;

  @doc("Gets the private link resources that need to be created for a service.")
  listByService is ArmResourceListByParent<PrivateLinkResourceDescription>;
}
