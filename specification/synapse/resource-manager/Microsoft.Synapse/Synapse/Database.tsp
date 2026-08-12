import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KustoPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
// FIXME: Database has no properties property
/**
 * Class representing a Kusto database.
 */
@parentResource(KustoPool)
model Database is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;

  /**
   * Kind of the database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: Kind;
}

@armResourceOperations
interface Databases {
  /**
   * Returns a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabases_Get")
  get is ArmResourceRead<Database>;

  /**
   * Creates or updates a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabases_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Database,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("KustoPoolDatabases_Update")
  update is ArmCustomPatchAsync<
    Database,
    PatchModel = Database,
    Response =
      | ArmResponse<Database>
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: Database;
        })
  >;

  /**
   * Deletes the database with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("KustoPoolDatabases_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of databases of the given Kusto pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabases_ListByKustoPool")
  listByKustoPool is ArmResourceListByParent<
    Database,
    Response = ArmResponse<DatabaseListResult>
  >;

  /**
   * Checks that the data connection name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Database,
    DataConnectionCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the data connection parameters are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_dataConnectionValidation")
  dataConnectionValidation is ArmResourceActionAsync<
    Database,
    DataConnectionValidation,
    ArmResponse<DataConnectionValidationListResult>
  >;

  /**
   * Checks that the database principal assignment is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("checkPrincipalAssignmentNameAvailability")
  @operationId("KustoPoolDatabasePrincipalAssignments_CheckNameAvailability")
  kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability is ArmResourceActionSync<
    Database,
    DatabasePrincipalAssignmentCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;
}

@@doc(Database.name, "The name of the database in the Kusto pool.");
@@doc(
  Databases.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
@@doc(
  Databases.update::parameters.properties,
  "The database parameters supplied to the Update operation."
);
@@doc(
  Databases.checkNameAvailability::parameters.body,
  "The name of the data connection."
);
@@doc(
  Databases.dataConnectionValidation::parameters.body,
  "The data connection parameters supplied to the CreateOrUpdate operation."
);
@@doc(
  Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability::parameters.body,
  "The name of the resource."
);
