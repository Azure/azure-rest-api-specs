import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A recoverable database resource.")
@parentResource(Server)
model RecoverableDatabase is ProxyResource<RecoverableDatabaseProperties> {
  @doc("The name of the database.")
  @path
  @key("databaseName")
  @segment("recoverableDatabases")
  name: string;
}

@armResourceOperations
interface RecoverableDatabases {
  @doc("Gets a recoverable database.")
  get is ArmResourceRead<
    RecoverableDatabase,
    {
      ...BaseParameters<RecoverableDatabase>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Gets a list of recoverable databases.")
  listByServer is ArmResourceListByParent<RecoverableDatabase>;
}
