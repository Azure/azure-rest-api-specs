import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("API portal resource")
@parentResource(AppPlatformService)
model AppPlatformApiPortal is ProxyResource<ApiPortalProperties> {
  @doc("The name of API portal.")
  @path
  @key("apiPortalName")
  @segment("apiPortals")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AppPlatformApiPortals {
  @doc("Get the API portal and its properties.")
  get is ArmResourceRead<AppPlatformApiPortal>;
  @doc("Create the default API portal or update the existing API portal.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformApiPortal>;
  @doc("Delete the default API portal.")
  delete is ArmResourceDeleteAsync<AppPlatformApiPortal>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<AppPlatformApiPortal>;
  @doc("Check the domains are valid as well as not in use.")
  validateDomain is ArmResourceActionSync<
    AppPlatformApiPortal,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}
