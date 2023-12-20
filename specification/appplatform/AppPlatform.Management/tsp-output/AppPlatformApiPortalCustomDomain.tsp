import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformApiPortal.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Custom domain of the API portal")
@parentResource(AppPlatformApiPortal)
model AppPlatformApiPortalCustomDomain
  is ProxyResource<ApiPortalCustomDomainProperties> {
  @doc("The name of the API portal custom domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface AppPlatformApiPortalCustomDomains {
  @doc("Get the API portal custom domain.")
  get is ArmResourceRead<AppPlatformApiPortalCustomDomain>;
  @doc("Create or update the API portal custom domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformApiPortalCustomDomain>;
  @doc("Delete the API portal custom domain.")
  delete is ArmResourceDeleteAsync<AppPlatformApiPortalCustomDomain>;
  @doc("Handle requests to list all API portal custom domains.")
  list is ArmResourceListByParent<AppPlatformApiPortalCustomDomain>;
}
