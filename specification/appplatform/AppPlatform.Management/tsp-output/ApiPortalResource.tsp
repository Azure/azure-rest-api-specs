import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("API portal resource")
@parentResource(ServiceResource)
model ApiPortalResource is ProxyResource<ApiPortalProperties> {
  @doc("The name of API portal.")
  @key("apiPortalName")
  @segment("apiPortals")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ApiPortals {
  @doc("Get the API portal and its properties.")
  get is ArmResourceRead<ApiPortalResource>;
  @doc("Create the default API portal or update the existing API portal.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApiPortalResource>;
  @doc("Delete the default API portal.")
  delete is ArmResourceDeleteAsync<ApiPortalResource>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<ApiPortalResource>;
  @doc("Check the domains are valid as well as not in use.")
  validateDomain is ArmResourceActionSync<
    ApiPortalResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}
