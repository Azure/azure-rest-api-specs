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
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlTriggerGetResultsOperationGroup {
  /**
   * Gets the SQL trigger under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlTrigger")
  getSqlTrigger is ArmResourceRead<SqlTriggerGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL trigger
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_CreateUpdateSqlTrigger")
  createUpdateSqlTrigger is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlTriggerGetResults,
    Request = SqlTriggerCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlTriggerGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SqlTriggerGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL trigger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_DeleteSqlTrigger")
  deleteSqlTrigger is ArmResourceDeleteWithoutOkAsync<SqlTriggerGetResults>;

  /**
   * Lists the SQL trigger under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_ListSqlTriggers")
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
