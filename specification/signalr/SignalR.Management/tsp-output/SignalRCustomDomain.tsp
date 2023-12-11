import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalR.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A custom domain")
@parentResource(SignalR)
model SignalRCustomDomain is ProxyResource<CustomDomainProperties> {
  @doc("Custom domain name.")
  @path
  @key("name")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface SignalRCustomDomains {
  @doc("Get a custom domain.")
  get is ArmResourceRead<SignalRCustomDomain>;
  @doc("Create or update a custom domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SignalRCustomDomain>;
  @doc("Delete a custom domain.")
  delete is ArmResourceDeleteAsync<SignalRCustomDomain>;
  @doc("List all custom domains.")
  list is ArmResourceListByParent<SignalRCustomDomain>;
}
