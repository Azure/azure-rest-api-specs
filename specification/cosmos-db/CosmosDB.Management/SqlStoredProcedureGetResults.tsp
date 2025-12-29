import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlContainerGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB storedProcedure.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SqlContainerGetResults)
model SqlStoredProcedureGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlStoredProcedureGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlStoredProcedureGetResults,
    KeyName = "storedProcedureName",
    SegmentName = "storedProcedures",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlStoredProcedureGetResultsOperationGroup {
  /**
   * Gets the SQL storedProcedure under an existing Azure Cosmos DB database account.
   */
  getSqlStoredProcedure is ArmResourceRead<SqlStoredProcedureGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL storedProcedure
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlStoredProcedure is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlStoredProcedureGetResults,
    Request = SqlStoredProcedureCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlStoredProcedureGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlStoredProcedureGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL storedProcedure.
   */
  deleteSqlStoredProcedure is ArmResourceDeleteWithoutOkAsync<
    SqlStoredProcedureGetResults,
    Response = NoContentResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the SQL storedProcedure under an existing Azure Cosmos DB database account.
   */
  listSqlStoredProcedures is ArmResourceListByParent<
    SqlStoredProcedureGetResults,
    Response = ArmResponse<SqlStoredProcedureListResult>,
    Error = CloudError
  >;
}

@@doc(SqlStoredProcedureGetResults.name, "Cosmos DB storedProcedure name.");
@@doc(SqlStoredProcedureGetResults.properties,
  "The properties of an Azure Cosmos DB storedProcedure"
);
@@doc(SqlStoredProcedureGetResultsOperationGroup.createUpdateSqlStoredProcedure::parameters.resource,
  "The parameters to provide for the current SQL storedProcedure."
);
