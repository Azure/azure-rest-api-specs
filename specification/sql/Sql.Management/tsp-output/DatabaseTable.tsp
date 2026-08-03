import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseSchema.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database table resource.
 */
@parentResource(DatabaseSchema)
model DatabaseTable is ProxyResource<DatabaseTableProperties> {
  /**
   * The name of the table.
   */
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

@armResourceOperations
interface DatabaseTables {
  /**
   * Get database table
   */
  get is ArmResourceRead<DatabaseTable>;

  /**
   * List database tables
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseTables_ListBySchema")
  listBySchema is ArmResourceListByParent<
    DatabaseTable,
    {
      ...BaseParameters<DatabaseTable>;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
