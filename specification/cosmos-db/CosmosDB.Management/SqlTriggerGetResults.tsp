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
 * An Azure Cosmos DB trigger.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SqlContainerGetResults)
model SqlTriggerGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlTriggerGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlTriggerGetResults,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlTriggerGetResultsOperationGroup {
  /**
   * Gets the SQL trigger under an existing Azure Cosmos DB database account.
   */
  getSqlTrigger is ArmResourceRead<SqlTriggerGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL trigger
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlTrigger is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlTriggerGetResults,
    Request = SqlTriggerCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlTriggerGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlTriggerGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL trigger.
   */
  deleteSqlTrigger is ArmResourceDeleteWithoutOkAsync<
    SqlTriggerGetResults,
    Response = NoContentResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the SQL trigger under an existing Azure Cosmos DB database account.
   */
  listSqlTriggers is ArmResourceListByParent<
    SqlTriggerGetResults,
    Response = ArmResponse<SqlTriggerListResult>
  >;
}

@@doc(SqlTriggerGetResults.name, "Cosmos DB trigger name.");
@@doc(SqlTriggerGetResults.properties,
  "The properties of an Azure Cosmos DB trigger"
);
@@doc(SqlTriggerGetResultsOperationGroup.createUpdateSqlTrigger::parameters.resource,
  "The parameters to provide for the current SQL trigger."
);
