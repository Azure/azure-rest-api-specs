import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HealthcareApisService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
// FIXME: HealthcareApisServicePrivateLinkResource has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(HealthcareApisService)
model HealthcareApisServicePrivateLinkResource is ProxyResource<{}> {
  @doc("The name of the private link resource group.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface HealthcareApisServicePrivateLinkResources {
  @doc("Gets a private link resource that need to be created for a service.")
  get is ArmResourceRead<HealthcareApisServicePrivateLinkResource>;
  @doc("Gets the private link resources that need to be created for a service.")
  listByService is ArmResourceListByParent<HealthcareApisServicePrivateLinkResource>;
}
