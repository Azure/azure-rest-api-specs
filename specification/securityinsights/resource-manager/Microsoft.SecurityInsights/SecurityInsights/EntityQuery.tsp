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
// FIXME: EntityQuery has no properties property
/**
 * Specific entity query.
 */
model EntityQuery is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = EntityQuery,
    KeyName = "entityQueryId",
    SegmentName = "entityQueries",
    NamePattern = ""
  >;

  /**
   * the entity query kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: EntityQueryKind;
}

@armResourceOperations
interface EntityQueries {
  /**
   * Gets an entity query.
   */
  get is Extension.Read<
    workspaceExternalResource,
    EntityQuery,
    Error = CloudError
  >;

  /**
   * Creates or updates the entity query.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    EntityQuery,
    Error = CloudError
  >;

  /**
   * Delete the entity query.
   */
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    EntityQuery,
    Error = CloudError
  >;

  /**
   * Gets all entity queries.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    EntityQuery,
    Parameters = {
      /**
       * The entity query kind we want to fetch
       */
      @query("kind")
      kind?: EntityQueryTemplateKind;
    },
    Response = ArmResponse<EntityQueryList>,
    Error = CloudError
  >;
}

@@doc(EntityQuery.name, "entity query ID");
@@doc(EntityQueries.createOrUpdate::parameters.resource,
  "The entity query we want to create or update"
);
