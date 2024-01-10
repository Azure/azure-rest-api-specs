import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApiPortalResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Custom domain of the API portal")
@parentResource(ApiPortalResource)
model ApiPortalCustomDomainResource
  is ProxyResource<ApiPortalCustomDomainProperties> {
  @doc("The name of the API portal custom domain.")
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
@projectedName("client", "ApiPortalCustomDomains")
interface ApiPortalCustomDomainResources_ApiPortalCustomDomains {
  @doc("Get the API portal custom domain.")
  get is ArmResourceRead<ApiPortalCustomDomainResource>;

  @doc("Create or update the API portal custom domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApiPortalCustomDomainResource>;

  @doc("Delete the API portal custom domain.")
  delete is ArmResourceDeleteAsync<ApiPortalCustomDomainResource>;

  @doc("Handle requests to list all API portal custom domains.")
  list is ArmResourceListByParent<ApiPortalCustomDomainResource>;
}
