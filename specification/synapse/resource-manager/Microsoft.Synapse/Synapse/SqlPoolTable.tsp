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

namespace Microsoft.Synapse;
// FIXME: SqlPoolTable has no properties property
/**
 * A Sql pool table resource.
 */
@parentResource(SqlPoolSchema)
model SqlPoolTable is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SqlPoolTable,
    KeyName = "tableName",
    SegmentName = "tables",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlPoolTables {
  /**
   * Get Sql pool table
   */
  get is ArmResourceRead<SqlPoolTable>;

  /**
   * Gets tables of a given schema in a SQL pool.
   */
  listBySchema is ArmResourceListByParent<
    SqlPoolTable,
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
