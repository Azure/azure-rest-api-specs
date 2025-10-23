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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoMIRoleAssignmentResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB MongoMI Role Assignment with the given Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getMongoMIRoleAssignment is ArmResourceRead<MongoMIRoleAssignmentResource>;

  /**
   * Creates or updates an Azure Cosmos DB MongoMI Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateMongoMIRoleAssignment is ArmResourceCreateOrReplaceAsync<
    MongoMIRoleAssignmentResource,
    Response = ArmResourceUpdatedResponse<MongoMIRoleAssignmentResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MongoMIRoleAssignmentResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB MongoMI Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteMongoMIRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    MongoMIRoleAssignmentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB MongoMI Role Assignments.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listMongoMIRoleAssignments is ArmResourceListByParent<MongoMIRoleAssignmentResource>;
}

@@doc(MongoMIRoleAssignmentResource.name, "The GUID for the Role Assignment.");
@@doc(MongoMIRoleAssignmentResource.properties,
  "Properties to create and update an Azure Cosmos DB MongoMI Role Assignment."
);
@@doc(MongoMIRoleAssignmentResources.createUpdateMongoMIRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
