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
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a database.
 */
@parentResource(Server)
model Database is Azure.ResourceManager.ProxyResource<DatabaseProperties> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = "^[a-zA-Z_][\\w\\-]{0,62}$"
  >;
}

@armResourceOperations
interface Databases {
  /**
   * Gets information about an existing database.
   */
  get is ArmResourceRead<Database>;

  /**
   * Creates a new database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Database,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Database> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing database.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all databases in a server.
   */
  listByServer is ArmResourceListByParent<
    Database,
    Response = ArmResponse<DatabaseList>
  >;
}

@@maxLength(Database.name, 63);
@@minLength(Database.name, 1);
@@doc(Database.name,
  "Name of the database (case-sensitive). Exact database names can be retrieved by getting the list of all existing databases in a server."
);
@@doc(Database.properties, "Properties of a database.");
@@doc(Databases.create::parameters.resource,
  "Parameters required to create a new database."
);
