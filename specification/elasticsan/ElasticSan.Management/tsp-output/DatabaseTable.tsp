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
@doc("A database table resource.")
@parentResource(DatabaseSchema)
model DatabaseTable is ProxyResource<DatabaseTableProperties> {
  @doc("The name of the table.")
  @path
  @key("tableName")
  @segment("tables")
  name: string;
}

@armResourceOperations
interface DatabaseTables {
  @doc("Get database table")
  get is ArmResourceRead<DatabaseTable>;

  @doc("List database tables")
  listBySchema is ArmResourceListByParent<
    DatabaseTable,
    {
      ...BaseParameters<DatabaseTable>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
