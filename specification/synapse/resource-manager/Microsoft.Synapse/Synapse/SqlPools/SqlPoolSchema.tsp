import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * A Sql pool schema resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield conversion: the published API defines SqlPoolSchema with no properties bag, which the standard ProxyResource<T> template cannot express."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "customAzureResource marks this hand-shaped resource as an Azure resource so it keeps the published OpenAPI shape."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Applies the same payload metadata handling that ProxyResource<T> applies, so the read-only name key stays out of request bodies and routes."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance from the common ProxyResource is required so the published allOf reference to common-types ProxyResource is preserved."
@parentResource(SqlPool)
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
model SqlPoolSchema extends Azure.ResourceManager.Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("schemaName")
  @segment("schemas")
  name: string;
}

alias SqlPoolSchemaOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The name of the schema. */
    @segment("schemas")
    @key
    @path
    schemaName: string;
  }
>;

@armResourceOperations
interface SqlPoolSchemas {
  /**
   * Get Sql Pool schema
   */
  get is SqlPoolSchemaOps.Read<SqlPoolSchema>;

  /**
   * Gets schemas of a given SQL pool.
   */
  list is SqlPoolSchemaOps.List<
    SqlPoolSchema,
    Response = ArmResponse<SqlPoolSchemaListResult>,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(SqlPoolSchema.name, "The name of the schema.");
