import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: EntityQuery has no properties property
@doc("Specific entity query.")
model EntityQuery is ProxyResource<{}> {
  @doc("entity query ID")
  @path
  @key("entityQueryId")
  @segment("entityQueries")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface EntityQueries {
  @doc("Gets an entity query.")
  get is ArmResourceRead<EntityQuery>;
  @doc("Creates or updates the entity query.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EntityQuery>;
  @doc("Delete the entity query.")
  delete is ArmResourceDeleteSync<EntityQuery>;
  @doc("Gets all entity queries.")
  list is ArmResourceListByParent<
    EntityQuery,
    {
      ...BaseParameters<EntityQuery>;

      @doc("The entity query kind we want to fetch")
      @query("kind")
      kind?: ComponentsL8W718ParametersEntityquerykindSchema;
    }
  >;
}
