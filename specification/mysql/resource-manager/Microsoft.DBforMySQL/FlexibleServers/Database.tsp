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

namespace Microsoft.DBforMySQL;
/**
 * Represents a Database.
 */
@parentResource(Server)
model Database is Azure.ResourceManager.ProxyResource<DatabaseProperties> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Databases {
  /**
   * Gets information about a database.
   */
  get is ArmResourceRead<Database>;

  /**
   * Creates a new database or updates an existing database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Database,
    Response = ArmResourceUpdatedResponse<Database> | ArmResourceCreatedResponse<
      Database,
      ArmLroLocationHeader<FinalResult = Database> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the databases in a given server.
   */
  listByServer is ArmResourceListByParent<
    Database,
    Response = ArmResponse<DatabaseListResult>
  >;
}

@@doc(Database.name, "The name of the database.");
@@doc(Database.properties, "The properties of a database.");
@@doc(Databases.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating a database."
);
