import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Bing;
/**
 * Bing Custom Search Configuration is an Azure resource representing Bing Custom Search configuration type, allowed domains, blocked domains and pinned domains.
 */
@parentResource(BingAccount)
model CustomSearchConfiguration
  is Azure.ResourceManager.ProxyResource<CustomConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = CustomSearchConfiguration,
    KeyName = "customSearchConfigurationName",
    SegmentName = "customSearchConfigurations",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]+$"
  >;
}

@armResourceOperations
interface CustomSearchConfigurations {
  /**
   * Returns a Bing Custom Search configuration specified by the parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<CustomSearchConfiguration>;

  /**
   * Creates or Updates a Bing Custom Search configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomSearchConfiguration>;

  /**
   * Deletes a Bing Custom Search configuration from the Bing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<CustomSearchConfiguration>;

  /**
   * Returns all the Bing Custom Search configurations for the specified Bing account.
   */
  listByAccount is ArmResourceListByParent<CustomSearchConfiguration>;
}

@@maxLength(CustomSearchConfiguration.name, 50);
@@minLength(CustomSearchConfiguration.name, 2);
@@doc(CustomSearchConfiguration.name,
  "The name of the Bing custom search configuration."
);
@@doc(CustomSearchConfiguration.properties,
  "Properties of Bing Custom Search configuration."
);
@@doc(CustomSearchConfigurations.createOrUpdate::parameters.resource,
  "The parameters of the configuration to create or update."
);
