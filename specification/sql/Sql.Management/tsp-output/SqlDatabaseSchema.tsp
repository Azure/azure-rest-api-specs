import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
// FIXME: SqlDatabaseSchema has no properties property
@doc("A database schema resource.")
@parentResource(SqlDatabase)
model SqlDatabaseSchema is ProxyResource<{}> {
  @doc("The name of the schema.")
  @path
  @key("schemaName")
  @segment("schemas")
  name: string;
}

@armResourceOperations
interface SqlDatabaseSchemas {
  @doc("Get database schema")
  get is ArmResourceRead<SqlDatabaseSchema>;
  @doc("List database schemas")
  listByDatabase is ArmResourceListByParent<
    SqlDatabaseSchema,
    {
      ...BaseParameters<SqlDatabaseSchema>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
