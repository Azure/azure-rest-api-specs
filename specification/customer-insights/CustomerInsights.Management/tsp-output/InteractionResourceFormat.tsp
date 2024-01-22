import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The interaction resource format.
 */
@parentResource(Hub)
model InteractionResourceFormat is ProxyResource<InteractionTypeDefinition> {
  /**
   * The name of the interaction.
   */
  @path
  @key("interactionName")
  @segment("interactions")
  name: string;
}

@armResourceOperations
interface InteractionResourceFormats {
  /**
   * Gets information about the specified interaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Interactions_Get")
  get is ArmResourceRead<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      /**
       * Locale of interaction to retrieve, default is en-us.
       */
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  /**
   * Creates an interaction or updates an existing interaction within a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Interactions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InteractionResourceFormat>;

  /**
   * Gets all interactions in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Interactions_ListByHub")
  listByHub is ArmResourceListByParent<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      /**
       * Locale of interaction to retrieve, default is en-us.
       */
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  /**
   * Suggests relationships to create relationship links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Interactions_SuggestRelationshipLinks")
  suggestRelationshipLinks is ArmResourceActionSync<
    InteractionResourceFormat,
    void,
    SuggestRelationshipLinksResponse
  >;
}

@@projectedName(InteractionResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(InteractionResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(InteractionResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Interaction operation."
);
