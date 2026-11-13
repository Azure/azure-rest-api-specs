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

namespace KustoPools;
/**
 * Class representing a Kusto database.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Brownfield conversion: the published API defines Database as a polymorphic base with no properties bag, which the standard ProxyResource<T> template cannot express."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "customAzureResource marks this hand-shaped polymorphic base as an Azure resource so it keeps the published OpenAPI shape."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Applies the same payload metadata handling that ProxyResource<T> applies, so the read-only name key stays out of request bodies and routes."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance from the common ProxyResource is required so the published allOf reference to common-types ProxyResource is preserved."
@discriminator("kind")
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
@Http.Private.includeInapplicableMetadataInPayload(false)
model Database extends Azure.ResourceManager.Foundations.ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("databaseName")
  @segment("databases")
  name: string;

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

alias DatabaseOps = Azure.ResourceManager.Legacy.LegacyOperations<
  KustoPoolParentParameters,
  {
    /** The name of the database in the Kusto pool. */
    @segment("databases")
    @key
    @path
    databaseName: string;
  }
>;

@armResourceOperations
interface Databases {
  /**
   * Returns a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabases_Get")
  get is DatabaseOps.Read<Database>;

  /**
   * Creates or updates a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabases_CreateOrUpdate")
  createOrUpdate is DatabaseOps.CreateOrUpdateAsync<
    Database,
    LroHeaders = ArmLroLocationHeader<FinalResult = Database> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("KustoPoolDatabases_Update")
  @patch(#{ implicitOptionality: false })
  update is DatabaseOps.CustomPatchAsync<
    Database,
    PatchModel = Database,
    Response =
      | ArmResponse<Database>
      | (ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmLroLocationHeader<FinalResult = Database> &
            Azure.Core.Foundations.RetryAfterHeader
        > & {
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
  delete is DatabaseOps.DeleteWithoutOkAsync<
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
  listByKustoPool is DatabaseOps.List<
    Database,
    Response = ArmResponse<DatabaseListResult>
  >;

  /**
   * Checks that the data connection name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_CheckNameAvailability")
  checkNameAvailability is DatabaseOps.ActionSync<
    Database,
    DataConnectionCheckNameRequest,
    ArmResponse<CheckNameResult>
  >;

  /**
   * Checks that the data connection parameters are valid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDataConnections_dataConnectionValidation")
  dataConnectionValidation is DatabaseOps.ActionAsync<
    Database,
    DataConnectionValidation,
    ArmResponse<DataConnectionValidationListResult>,
    LroHeaders = ArmLroLocationHeader<FinalResult = DataConnectionValidationListResult> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Checks that the database principal assignment is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabasePrincipalAssignments_CheckNameAvailability")
  @action("checkPrincipalAssignmentNameAvailability")
  kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability is DatabaseOps.ActionSync<
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
