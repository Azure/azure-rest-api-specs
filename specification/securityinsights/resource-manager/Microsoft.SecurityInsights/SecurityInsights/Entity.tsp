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

@armResourceOperations
interface Entities {
  /**
   * Gets an entity.
   */
  get is Extension.Read<workspaceExternalResource, Entity, Error = CloudError>;

  /**
   * Gets all entities.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    Entity,
    Response = ArmResponse<EntityList>,
    Error = CloudError
  >;

  /**
   * Triggers playbook on a specific entity.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "entityId",
    "entityIdentifier"
  )
  runPlaybook is Extension.ActionSync<
    workspaceExternalResource,
    Entity,
    EntityManualTriggerRequestBody,
    NoContentResponse,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Expands an entity.
   */
  expand is Extension.ActionSync<
    workspaceExternalResource,
    Entity,
    EntityExpandParameters,
    ArmResponse<EntityExpandResponse>,
    Error = CloudError
  >;

  /**
   * Get Insights and Activities for an entity.
   */
  @get
  @list
  queries is Extension.ActionSync<
    workspaceExternalResource,
    Entity,
    void,
    ArmResponse<GetQueriesResponse>,
    Parameters = {
      /**
       * The Kind parameter for queries
       */
      @query("kind")
      kind: EntityItemQueryKind;
    },
    Error = CloudError
  >;

  /**
   * Execute Insights for an entity.
   */
  getInsights is Extension.ActionSync<
    workspaceExternalResource,
    Entity,
    EntityGetInsightsParameters,
    ArmResponse<EntityGetInsightsResponse>,
    Error = CloudError
  >;

  /**
   * Timeline for an entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EntitiesGetTimeline_list")
  @action("getTimeline")
  entitiesGetTimelineList is Extension.ActionSync<
    workspaceExternalResource,
    Entity,
    EntityTimelineParameters,
    ArmResponse<EntityTimelineResponse>,
    Error = CloudError
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
