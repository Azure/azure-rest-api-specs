import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SignalRService;
@doc("A custom domain")
@parentResource(SignalRResource)
model CustomDomain is ProxyResource<CustomDomainProperties> {
  @doc("Custom domain name.")
  @path
  @key("name")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface CustomDomains {
  @doc("Get a custom domain.")
  get is ArmResourceRead<CustomDomain>;
  @doc("Create or update a custom domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomDomain>;
  @doc("Delete a custom domain.")
  delete is ArmResourceDeleteAsync<CustomDomain>;
  @doc("List all custom domains.")
  list is ArmResourceListByParent<CustomDomain>;
}
