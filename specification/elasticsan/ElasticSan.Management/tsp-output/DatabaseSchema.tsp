import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: DatabaseSchema has no properties property
@doc("A database schema resource.")
@parentResource(Database)
model DatabaseSchema is ProxyResource<{}> {
  @doc("The name of the schema.")
  @path
  @key("schemaName")
  @segment("schemas")
  name: string;
}

@armResourceOperations
interface DatabaseSchemas {
  @doc("Get database schema")
  get is ArmResourceRead<DatabaseSchema>;

  @doc("List database schemas")
  listByDatabase is ArmResourceListByParent<
    DatabaseSchema,
    {
      ...BaseParameters<DatabaseSchema>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
