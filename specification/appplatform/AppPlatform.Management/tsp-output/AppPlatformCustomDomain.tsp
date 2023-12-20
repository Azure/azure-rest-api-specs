import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Custom domain resource payload.")
@parentResource(AppPlatformApp)
model AppPlatformCustomDomain is ProxyResource<CustomDomainProperties> {
  @doc("The name of the custom domain resource.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface AppPlatformCustomDomains {
  @doc("Get the custom domain of one lifecycle application.")
  get is ArmResourceRead<AppPlatformCustomDomain>;
  @doc("Create or update custom domain of one lifecycle application.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformCustomDomain>;
  @doc("Update custom domain of one lifecycle application.")
  update is ArmResourcePatchAsync<
    AppPlatformCustomDomain,
    CustomDomainProperties
  >;
  @doc("Delete the custom domain of one lifecycle application.")
  delete is ArmResourceDeleteAsync<AppPlatformCustomDomain>;
  @doc("List the custom domains of one lifecycle application.")
  list is ArmResourceListByParent<AppPlatformCustomDomain>;
}
