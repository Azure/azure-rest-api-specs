import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: Entity has no properties property
@doc("Specific entity.")
model Entity is ProxyResource<{}> {
  @doc("entity ID")
  @path
  @key("entityId")
  @segment("entities")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Entities {
  @doc("Gets an entity.")
  get is ArmResourceRead<Entity>;
  @doc("Gets all entities.")
  list is ArmResourceListByParent<Entity>;
  @doc("Expands an entity.")
  expand is ArmResourceActionSync<
    Entity,
    EntityExpandParameters,
    EntityExpandResponse
  >;
  @doc("Execute Insights for an entity.")
  getInsights is ArmResourceActionSync<
    Entity,
    EntityGetInsightsParameters,
    EntityGetInsightsResponse
  >;
  @doc("Timeline for an entity.")
  list is ArmResourceActionSync<
    Entity,
    EntityTimelineParameters,
    EntityTimelineResponse
  >;
  @doc("Get Insights and Activities for an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/queries")
  @get
  Queries is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("The Kind parameter for queries")
      @query("kind")
      kind: EntityItemQueryKind;
    },
    GetQueriesResponse
  >;
}
