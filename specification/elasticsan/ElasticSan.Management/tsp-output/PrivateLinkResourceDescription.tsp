import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateLinkResourceDescription has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(ServicesDescription)
model PrivateLinkResourceDescription is ProxyResource<{}> {
  @doc("The name of the private link resource group.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResourceDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a private link resource that need to be created for a service.")
  @operationId("PrivateLinkResources_Get")
  get is ArmResourceRead<PrivateLinkResourceDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the private link resources that need to be created for a service.")
  @operationId("PrivateLinkResources_ListByService")
  listByService is ArmResourceListByParent<PrivateLinkResourceDescription>;
}
