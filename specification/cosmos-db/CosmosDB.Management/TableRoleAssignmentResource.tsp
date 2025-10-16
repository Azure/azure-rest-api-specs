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
 * Parameters to create and update an Azure Cosmos DB Table Role Assignment.
 */
@parentResource(DatabaseAccountGetResults)
model TableRoleAssignmentResource
  is Azure.ResourceManager.ProxyResource<TableRoleAssignmentResourceProperties> {
  ...ResourceNameParameter<
    Resource = TableRoleAssignmentResource,
    KeyName = "roleAssignmentId",
    SegmentName = "tableRoleAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TableRoleAssignmentResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Table Role Assignment with the given Id.
   */
  getTableRoleAssignment is ArmResourceRead<TableRoleAssignmentResource>;

  /**
   * Creates or updates an Azure Cosmos DB Table Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateTableRoleAssignment is ArmResourceCreateOrReplaceAsync<
    TableRoleAssignmentResource,
    Response = ArmResourceUpdatedResponse<TableRoleAssignmentResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = TableRoleAssignmentResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Table Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteTableRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    TableRoleAssignmentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Table Role Assignments.
   */
  listTableRoleAssignments is ArmResourceListByParent<
    TableRoleAssignmentResource,
    Response = TableRoleAssignmentListResult
  >;
}

@@doc(TableRoleAssignmentResource.name, "The GUID for the Role Assignment.");
@@doc(TableRoleAssignmentResource.properties,
  "Properties to create and update an Azure Cosmos DB Table Role Assignment."
);
@@doc(TableRoleAssignmentResources.createUpdateTableRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
