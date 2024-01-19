import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedServices;

model MarketplaceRegistrationDefinition
  is ExtensionResource<MarketplaceRegistrationDefinitionProperties> {
  @doc("The Azure Marketplace identifier. Expected formats: {publisher}.{product[-preview]}.{planName}.{version} or {publisher}.{product[-preview]}.{planName} or {publisher}.{product[-preview]} or {publisher}).")
  @path
  @key("marketplaceIdentifier")
  @segment("marketplaceRegistrationDefinitions")
  name: string;

  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface MarketplaceRegistrationDefinitions {
  @doc("Get the marketplace registration definition for the marketplace identifier.")
  get is ArmResourceRead<MarketplaceRegistrationDefinition>;

  @doc("Gets a list of the marketplace registration definitions for the marketplace identifier.")
  list is ArmResourceListByParent<
    MarketplaceRegistrationDefinition,
    {
      ...BaseParameters<MarketplaceRegistrationDefinition>;

      @doc("The filter query parameter to filter managed services resources by.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
