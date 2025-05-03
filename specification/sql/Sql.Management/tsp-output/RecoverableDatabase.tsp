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
/**
 * A recoverable database resource.
 */
@parentResource(Server)
model RecoverableDatabase is ProxyResource<RecoverableDatabaseProperties> {
  /**
   * The name of the database.
   */
  @path
  @key("databaseName")
  @segment("recoverableDatabases")
  name: string;
}

@armResourceOperations
interface RecoverableDatabases {
  /**
   * Gets a recoverable database.
   */
  get is ArmResourceRead<
    RecoverableDatabase,
    {
      ...BaseParameters<RecoverableDatabase>;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets a list of recoverable databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoverableDatabases_ListByServer")
  listByServer is ArmResourceListByParent<RecoverableDatabase>;
}
