import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: EntityQueryTemplate has no properties property
@doc("Specific entity query template.")
model EntityQueryTemplate is ProxyResource<{}> {
  @doc("entity query template ID")
  @path
  @key("entityQueryTemplateId")
  @segment("entityQueryTemplates")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface EntityQueryTemplates {
  @doc("Gets an entity query.")
  get is ArmResourceRead<EntityQueryTemplate>;
  @doc("Gets all entity query templates.")
  list is ArmResourceListByParent<
    EntityQueryTemplate,
    {
      ...BaseParameters<EntityQueryTemplate>;

      @doc("The entity template query kind we want to fetch")
      @query("kind")
      kind?: Components9D9QekParametersEntityquerytemplatekindSchema;
    }
  >;
}
