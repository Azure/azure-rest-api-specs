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
 * Parameters to create and update an Azure Cosmos DB MongoMI Role Assignment.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@parentResource(DatabaseAccountGetResults)
model MongoMIRoleAssignmentResource
  is Azure.ResourceManager.ProxyResource<MongoMIRoleAssignmentResourceProperties> {
  ...ResourceNameParameter<
    Resource = MongoMIRoleAssignmentResource,
    KeyName = "roleAssignmentId",
    SegmentName = "mongoMIRoleAssignments",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface MongoMIRoleAssignmentResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB MongoMI Role Assignment with the given Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoMIResources_GetMongoMIRoleAssignment")
  getMongoMIRoleAssignment is ArmResourceRead<MongoMIRoleAssignmentResource>;

  /**
   * Creates or updates an Azure Cosmos DB MongoMI Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  @operationId("MongoMIResources_CreateUpdateMongoMIRoleAssignment")
  createUpdateMongoMIRoleAssignment is ArmResourceCreateOrReplaceAsync<
    MongoMIRoleAssignmentResource,
    Response = ArmResourceUpdatedResponse<MongoMIRoleAssignmentResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = MongoMIRoleAssignmentResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoMI Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  @operationId("MongoMIResources_DeleteMongoMIRoleAssignment")
  deleteMongoMIRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    MongoMIRoleAssignmentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB MongoMI Role Assignments.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoMIResources_ListMongoMIRoleAssignments")
  listMongoMIRoleAssignments is ArmResourceListByParent<MongoMIRoleAssignmentResource>;
}

@@doc(MongoMIRoleAssignmentResource.name, "The GUID for the Role Assignment.");
@@doc(MongoMIRoleAssignmentResource.properties,
  "Properties to create and update an Azure Cosmos DB MongoMI Role Assignment."
);
@@doc(MongoMIRoleAssignmentResources.createUpdateMongoMIRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
