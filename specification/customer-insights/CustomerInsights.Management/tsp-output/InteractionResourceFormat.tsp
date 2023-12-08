import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
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
  @doc("Gets information about the specified interaction.")
  get is ArmResourceRead<
    InteractionResourceFormat,
    {
      ...BaseParameters<InteractionResourceFormat>;

      @doc("Locale of interaction to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string;
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
      `locale-code`?: string;
    }
  >;
  @doc("Suggests relationships to create relationship links.")
  suggestRelationshipLinks is ArmResourceActionSync<
    InteractionResourceFormat,
    {},
    SuggestRelationshipLinksResponse
  >;
}
