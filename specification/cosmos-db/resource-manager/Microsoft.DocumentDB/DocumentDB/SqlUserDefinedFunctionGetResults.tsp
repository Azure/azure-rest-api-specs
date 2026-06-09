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
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SqlContainerGetResults)
model SqlUserDefinedFunctionGetResults
  is Azure.ResourceManager.ProxyResource<SqlUserDefinedFunctionGetProperties> {
  ...ResourceNameParameter<
    Resource = SqlUserDefinedFunctionGetResults,
    KeyName = "userDefinedFunctionName",
    SegmentName = "userDefinedFunctions",
    NamePattern = ""
  >;

  /** The location of the resource group to which the resource belongs. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /** Tags are a list of key-value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater than 128 characters and value no greater than 256 characters. For example, the default experience for a template type is set with \"defaultExperience\": \"Cassandra\". Current \"defaultExperience\" values also include \"Table\", \"Graph\", \"DocumentDB\", and \"MongoDB\". */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface SqlUserDefinedFunctionGetResultsOperationGroup {
  /**
   * Gets the SQL userDefinedFunction under an existing Azure Cosmos DB database account.
   */
  getSqlUserDefinedFunction is ArmResourceRead<SqlUserDefinedFunctionGetResults>;

  /**
   * Create or update an Azure Cosmos DB SQL userDefinedFunction
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlUserDefinedFunction is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlUserDefinedFunctionGetResults,
    Request = SqlUserDefinedFunctionCreateUpdateParameters,
    Response =
      | ArmResourceUpdatedResponse<SqlUserDefinedFunctionGetResults>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlUserDefinedFunctionGetResults> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL userDefinedFunction.
   */
  deleteSqlUserDefinedFunction is ArmResourceDeleteWithoutOkAsync<
    SqlUserDefinedFunctionGetResults,
    Response =
      | NoContentResponse
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>
  >;

  /**
   * Lists the SQL userDefinedFunction under an existing Azure Cosmos DB database account.
   */
  listSqlUserDefinedFunctions is ArmResourceListByParent<
    SqlUserDefinedFunctionGetResults,
    Response = ArmResponse<SqlUserDefinedFunctionListResult>
  >;
}

@@doc(
  SqlUserDefinedFunctionGetResults.name,
  "Cosmos DB userDefinedFunction name."
);
@@doc(
  SqlUserDefinedFunctionGetResults.properties,
  "The properties of an Azure Cosmos DB userDefinedFunction"
);
@@doc(
  SqlUserDefinedFunctionGetResultsOperationGroup.createUpdateSqlUserDefinedFunction::parameters.resource,
  "The parameters to provide for the current SQL userDefinedFunction."
);
@@visibility(
  SqlUserDefinedFunctionGetResults.location,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
