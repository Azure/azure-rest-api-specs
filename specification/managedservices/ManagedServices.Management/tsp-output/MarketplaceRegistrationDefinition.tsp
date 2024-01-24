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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  MarketplaceRegistrationDefinitionProperties
)
@includeInapplicableMetadataInPayload(false)
model MarketplaceRegistrationDefinition extends ExtensionResourceBase {
  /**
   * The Azure Marketplace identifier. Expected formats: {publisher}.{product[-preview]}.{planName}.{version} or {publisher}.{product[-preview]}.{planName} or {publisher}.{product[-preview]} or {publisher}).
   */
  @path
  @key("marketplaceIdentifier")
  @segment("marketplaceRegistrationDefinitions")
  name: string;

  /**
   * The properties of the marketplace registration definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MarketplaceRegistrationDefinitionProperties;

  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface MarketplaceRegistrationDefinitions {
  /**
   * Get the marketplace registration definition for the marketplace identifier.
   */
  get is ArmResourceRead<MarketplaceRegistrationDefinition>;

  /**
   * Gets a list of the marketplace registration definitions for the marketplace identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MarketplaceRegistrationDefinitions_List")
  list is ArmResourceListByParent<
    MarketplaceRegistrationDefinition,
    {
      ...BaseParameters<MarketplaceRegistrationDefinition>;

      /**
       * The filter query parameter to filter managed services resources by.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
