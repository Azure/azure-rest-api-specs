import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
// FIXME: Entity has no properties property
/**
 * Specific entity.
 */
model Entity is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Entity,
    KeyName = "entityId",
    SegmentName = "entities",
    NamePattern = ""
  >;

  /**
   * The kind of the entity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: EntityKindEnum;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Entities {
  /**
   * Gets an entity.
   */
  get is ArmResourceRead<Entity>;

  /**
   * Gets all entities.
   */
  list is ArmResourceListByParent<Entity, Response = ArmResponse<EntityList>>;

  /**
   * Triggers playbook on a specific entity.
   */
  runPlaybook is ArmResourceActionSync<
    Entity,
    EntityManualTriggerRequestBody,
    NoContentResponse,
    Parameters = {
      /**
       * Entity identifier.
       */
      @path
      entityIdentifier: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Expands an entity.
   */
  expand is ArmResourceActionSync<
    Entity,
    EntityExpandParameters,
    ArmResponse<EntityExpandResponse>
  >;

  /**
   * Get Insights and Activities for an entity.
   */
  @list
  @get
  queries is ArmResourceActionSync<
    Entity,
    void,
    ArmResponse<GetQueriesResponse>,
    Parameters = {
      /**
       * The Kind parameter for queries
       */
      @query("kind")
      kind: EntityItemQueryKind;
    }
  >;

  /**
   * Execute Insights for an entity.
   */
  @list
  getInsights is ArmResourceActionSync<
    Entity,
    EntityGetInsightsParameters,
    ArmResponse<EntityGetInsightsResponse>
  >;

  /**
   * Timeline for an entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EntitiesGetTimeline_list")
  @list
  @action("getTimeline")
  entitiesGetTimelineList is ArmResourceActionSync<
    Entity,
    EntityTimelineParameters,
    ArmResponse<EntityTimelineResponse>
  >;
}

@@doc(Entity.name, "entity ID");
@@doc(Entities.runPlaybook::parameters.body,
  "Describes the request body for triggering a playbook on an entity."
);
@@doc(Entities.expand::parameters.body,
  "The parameters required to execute an expand operation on the given entity."
);
@@doc(Entities.getInsights::parameters.body,
  "The parameters required to execute insights on the given entity."
);
@@doc(Entities.entitiesGetTimelineList::parameters.body,
  "The parameters required to execute an timeline operation on the given entity."
);
