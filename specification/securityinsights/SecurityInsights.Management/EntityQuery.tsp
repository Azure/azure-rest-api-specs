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
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * the entity query kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: EntityQueryKind;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface EntityQueries {
  /**
   * Gets an entity query.
   */
  get is ArmResourceRead<EntityQuery>;

  /**
   * Creates or updates the entity query.
   */
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    EntityQuery,
    Request = CustomEntityQuery
  >;

  /**
   * Delete the entity query.
   */
  delete is ArmResourceDeleteSync<EntityQuery>;

  /**
   * Gets all entity queries.
   */
  list is ArmResourceListByParent<
    EntityQuery,
    Parameters = {
      /**
       * The entity query kind we want to fetch
       */
      @query("kind")
      kind?: EntityQueryTemplateKind;
    },
    Response = ArmResponse<EntityQueryList>
  >;
}

@@doc(EntityQuery.name, "entity query ID");
@@doc(EntityQueries.createOrUpdate::parameters.resource,
  "The entity query we want to create or update"
);
