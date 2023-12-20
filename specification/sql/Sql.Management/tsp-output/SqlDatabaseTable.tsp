import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabaseSchema.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A database table resource.")
@parentResource(SqlDatabaseSchema)
model SqlDatabaseTable is ProxyResource<DatabaseTableProperties> {
  @doc("The name of the table.")
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

@armResourceOperations
interface SqlDatabaseTables {
  @doc("Get database table")
  get is ArmResourceRead<SqlDatabaseTable>;
  @doc("List database tables")
  listBySchema is ArmResourceListByParent<
    SqlDatabaseTable,
    {
      ...BaseParameters<SqlDatabaseTable>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
