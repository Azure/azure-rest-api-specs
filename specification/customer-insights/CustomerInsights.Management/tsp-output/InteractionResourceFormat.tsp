import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The interaction resource format.")
@parentResource(Hub)
model InteractionResourceFormat is ProxyResource<InteractionTypeDefinition> {
  @doc("The name of the interaction.")
  @key("interactionName")
  @segment("interactions")
  name: string;
}

@armResourceOperations
@projectedName("client", "Interactions")
interface InteractionResourceFormats_Interactions {
  @doc("Gets information about the specified interaction.")
  get is ArmResourceRead<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  @doc("Creates an interaction or updates an existing interaction within a hub.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InteractionResourceFormat>;

  @doc("Gets all interactions in the hub.")
  listByHub is ArmResourceListByParent<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  @doc("Suggests relationships to create relationship links.")
  suggestRelationshipLinks is ArmResourceActionSync<
    InteractionResourceFormat,
    void,
    SuggestRelationshipLinksResponse
  >;
}
