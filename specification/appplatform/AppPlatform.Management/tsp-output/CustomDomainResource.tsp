import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Custom domain resource payload.")
@parentResource(AppResource)
model CustomDomainResource is ProxyResource<CustomDomainProperties> {
  @doc("The name of the custom domain resource.")
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface CustomDomains {
  @doc("Get the custom domain of one lifecycle application.")
  get is ArmResourceRead<CustomDomainResource>;
  @doc("Create or update custom domain of one lifecycle application.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomDomainResource>;
  @doc("Update custom domain of one lifecycle application.")
  update is ArmCustomPatchAsync<CustomDomainResource, CustomDomainResource>;
  @doc("Delete the custom domain of one lifecycle application.")
  delete is ArmResourceDeleteAsync<CustomDomainResource>;
  @doc("List the custom domains of one lifecycle application.")
  list is ArmResourceListByParent<CustomDomainResource>;
}
