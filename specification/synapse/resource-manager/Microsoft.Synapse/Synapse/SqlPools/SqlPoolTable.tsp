import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPoolSchema.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * A Sql pool table resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield conversion: the published API defines SqlPoolTable with no properties bag, which the standard ProxyResource<T> template cannot express."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "customAzureResource marks this hand-shaped resource as an Azure resource so it keeps the published OpenAPI shape."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Applies the same payload metadata handling that ProxyResource<T> applies, so the read-only name key stays out of request bodies and routes."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance from the common ProxyResource is required so the published allOf reference to common-types ProxyResource is preserved."
@parentResource(SqlPoolSchema)
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
model SqlPoolTable extends Azure.ResourceManager.Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

alias SqlPoolTableOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolSchemaParentParameters,
  {
    /** The name of the table. */
    @segment("tables")
    @key
    @path
    tableName: string;
  }
>;

@armResourceOperations
interface SqlPoolTables {
  /**
   * Get Sql pool table
   */
  get is SqlPoolTableOps.Read<SqlPoolTable>;

  /**
   * Gets tables of a given schema in a SQL pool.
   */
  listBySchema is SqlPoolTableOps.List<
    SqlPoolTable,
    Response = ArmResponse<SqlPoolTableListResult>,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(SqlPoolTable.name, "The name of the table.");
