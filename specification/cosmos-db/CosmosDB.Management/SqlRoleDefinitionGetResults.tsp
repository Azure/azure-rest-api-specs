import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseAccountGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB SQL Role Definition.
 */
@parentResource(DatabaseAccountGetResults)
model SqlRoleDefinitionGetResults
  is Azure.ResourceManager.ProxyResource<SqlRoleDefinitionResource> {
  ...ResourceNameParameter<
    Resource = SqlRoleDefinitionGetResults,
    KeyName = "roleDefinitionId",
    SegmentName = "sqlRoleDefinitions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlRoleDefinitionGetResultsOperationGroup {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB SQL Role Definition with the given Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlRoleDefinition")
  getSqlRoleDefinition is ArmResourceRead<
    SqlRoleDefinitionGetResults,
    Error = CloudError
  >;

  /**
   * Creates or updates an Azure Cosmos DB SQL Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_CreateUpdateSqlRoleDefinition")
  createUpdateSqlRoleDefinition is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlRoleDefinitionGetResults,
    Request = SqlRoleDefinitionCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlRoleDefinitionGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlRoleDefinitionGetResults> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL Role Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_DeleteSqlRoleDefinition")
  deleteSqlRoleDefinition is ArmResourceDeleteWithoutOkAsync<
    SqlRoleDefinitionGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB SQL Role Definitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_ListSqlRoleDefinitions")
  listSqlRoleDefinitions is ArmResourceListByParent<
    SqlRoleDefinitionGetResults,
    Response = ArmResponse<SqlRoleDefinitionListResult>,
    Error = CloudError
  >;
}

@@doc(SqlRoleDefinitionGetResults.name, "The GUID for the Role Definition.");
@@doc(SqlRoleDefinitionGetResults.properties,
  "Properties related to the Role Definition."
);
@@doc(SqlRoleDefinitionGetResultsOperationGroup.createUpdateSqlRoleDefinition::parameters.resource,
  "The properties required to create or update a Role Definition."
);
