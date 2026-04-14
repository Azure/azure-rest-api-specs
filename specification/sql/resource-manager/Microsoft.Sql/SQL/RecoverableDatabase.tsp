import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A recoverable database resource.
 */
@parentResource(Server)
model RecoverableDatabase
  is Azure.ResourceManager.ProxyResource<RecoverableDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = RecoverableDatabase,
    KeyName = "databaseName",
    SegmentName = "recoverableDatabases",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RecoverableDatabases {
  /**
   * Gets a recoverable database.
   */
  get is ArmResourceRead<
    RecoverableDatabase,
    Parameters = {
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
  listByServer is ArmResourceListByParent<RecoverableDatabase>;
}

@@doc(RecoverableDatabase.name, "The name of the database.");
@@doc(RecoverableDatabase.properties, "Resource properties.");
