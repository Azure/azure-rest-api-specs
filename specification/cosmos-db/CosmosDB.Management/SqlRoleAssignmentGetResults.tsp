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
 * An Azure Cosmos DB Role Assignment
 */
@parentResource(DatabaseAccountGetResults)
model SqlRoleAssignmentGetResults
  is Azure.ResourceManager.ProxyResource<SqlRoleAssignmentResource> {
  ...ResourceNameParameter<
    Resource = SqlRoleAssignmentGetResults,
    KeyName = "roleAssignmentId",
    SegmentName = "sqlRoleAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlRoleAssignmentGetResultsOperationGroup {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB SQL Role Assignment with the given Id.
   */
  getSqlRoleAssignment is ArmResourceRead<
    SqlRoleAssignmentGetResults,
    Error = CloudError
  >;

  /**
   * Creates or updates an Azure Cosmos DB SQL Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateSqlRoleAssignment is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    SqlRoleAssignmentGetResults,
    Request = SqlRoleAssignmentCreateUpdateParameters,
    Response = ArmResourceUpdatedResponse<SqlRoleAssignmentGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SqlRoleAssignmentGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes an existing Azure Cosmos DB SQL Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteSqlRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    SqlRoleAssignmentGetResults,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB SQL Role Assignments.
   */
  listSqlRoleAssignments is ArmResourceListByParent<
    SqlRoleAssignmentGetResults,
    Response = ArmResponse<SqlRoleAssignmentListResult>,
    Error = CloudError
  >;
}

@@doc(SqlRoleAssignmentGetResults.name, "The GUID for the Role Assignment.");
@@doc(SqlRoleAssignmentGetResults.properties,
  "Properties related to the Role Assignment."
);
@@doc(SqlRoleAssignmentGetResultsOperationGroup.createUpdateSqlRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
