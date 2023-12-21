import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Cdn;
@doc("Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.")
@parentResource(Profile)
model AFDDomain is ProxyResource<AFDDomainProperties> {
  @doc("Name of the domain under the profile which is unique globally.")
  @path
  @key("customDomainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface FrontDoorCustomDomains {
  @doc("Gets an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.")
  get is ArmResourceRead<AFDDomain>;
  @doc("Creates a new domain within the specified profile.")
  create is ArmResourceCreateOrUpdateAsync<AFDDomain>;
  @doc("Updates an existing domain within a profile.")
  update is ArmResourcePatchAsync<AFDDomain, AFDDomainProperties>;
  @doc("Deletes an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.")
  delete is ArmResourceDeleteAsync<AFDDomain>;
  @doc("Lists existing AzureFrontDoor domains.")
  listByProfile is ArmResourceListByParent<AFDDomain>;
  @doc("Updates the domain validation token.")
  refreshValidationToken is ArmResourceActionAsync<AFDDomain, void, void>;
}
