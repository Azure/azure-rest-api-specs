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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model EntityQuery
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<EntityQueryKind> {
  ...ResourceNameParameter<
    Resource = EntityQuery,
    KeyName = "entityQueryId",
    SegmentName = "entityQueries",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface EntityQueriesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * providerNamespace
         */
        @path
        @segment("providers")
        providerNamespace: "Microsoft.OperationalInsights",

        /**
         * The name of the workspace.
         */
        @segment("workspaces")
        @key
        @path
        @minLength(1)
        @maxLength(90)
        @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
        workspaceName: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * entity query ID
         */
        @path
        @segment("entityQueries")
        entityQueryId: string,
      }
    > {}

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
  createOrUpdate is EntityQueriesOps.CreateOrUpdateSync<
    EntityQuery,
    Request = CustomEntityQuery,
    OverrideErrorType = CloudError
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
