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
 * An Azure Cosmos DB userDefinedFunction.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
@parentResource(SqlContainerGetResults)
model SqlUserDefinedFunctionGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlUserDefinedFunctionGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlUserDefinedFunctionGetResults,
    KeyName = "userDefinedFunctionName",
    SegmentName = "userDefinedFunctions",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SqlUserDefinedFunctionGetResultsOperationGroup {
  /**
   * Gets the SQL userDefinedFunction under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlUserDefinedFunction")
  getSqlUserDefinedFunction is ArmResourceRead<SqlUserDefinedFunctionGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL userDefinedFunction
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_CreateUpdateSqlUserDefinedFunction")
  createUpdateSqlUserDefinedFunction is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlUserDefinedFunctionGetResults,
    Request = SqlUserDefinedFunctionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlUserDefinedFunctionGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SqlUserDefinedFunctionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL userDefinedFunction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_DeleteSqlUserDefinedFunction")
  deleteSqlUserDefinedFunction is ArmResourceDeleteWithoutOkAsync<SqlUserDefinedFunctionGetResults>;

  /**
   * Lists the SQL userDefinedFunction under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_ListSqlUserDefinedFunctions")
  listSqlUserDefinedFunctions is ArmResourceListByParent<
    SqlUserDefinedFunctionGetResults,
    Response = ArmResponse<SqlUserDefinedFunctionListResult>
  >;
}

@@doc(SqlUserDefinedFunctionGetResults.name,
  "Cosmos DB userDefinedFunction name."
);
@@doc(SqlUserDefinedFunctionGetResults.properties,
  "The properties of an Azure Cosmos DB userDefinedFunction"
);
@@doc(SqlUserDefinedFunctionGetResultsOperationGroup.createUpdateSqlUserDefinedFunction::parameters.resource,
  "The parameters to provide for the current SQL userDefinedFunction."
);
