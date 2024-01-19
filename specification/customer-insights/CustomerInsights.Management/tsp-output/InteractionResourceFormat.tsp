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
@doc("The interaction resource format.")
@parentResource(Hub)
model InteractionResourceFormat is ProxyResource<InteractionTypeDefinition> {
  @doc("The name of the interaction.")
  @path
  @key("interactionName")
  @segment("interactions")
  name: string;
}

@armResourceOperations
interface InteractionResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified interaction.")
  @operationId("Interactions_Get")
  get is ArmResourceRead<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an interaction or updates an existing interaction within a hub.")
  @operationId("Interactions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InteractionResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all interactions in the hub.")
  @operationId("Interactions_ListByHub")
  listByHub is ArmResourceListByParent<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Suggests relationships to create relationship links.")
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
