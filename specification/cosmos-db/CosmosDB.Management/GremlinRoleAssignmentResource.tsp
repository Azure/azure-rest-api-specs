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
 * Parameters to create and update an Azure Cosmos DB Gremlin Role Assignment.
 */
@parentResource(DatabaseAccountGetResults)
model GremlinRoleAssignmentResource
  is Azure.ResourceManager.ProxyResource<GremlinRoleAssignmentResourceProperties> {
  ...ResourceNameParameter<
    Resource = GremlinRoleAssignmentResource,
    KeyName = "roleAssignmentId",
    SegmentName = "gremlinRoleAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GremlinRoleAssignmentResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Gremlin Role Assignment with the given Id.
   */
  getGremlinRoleAssignment is ArmResourceRead<GremlinRoleAssignmentResource>;

  /**
   * Creates or updates an Azure Cosmos DB Gremlin Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateGremlinRoleAssignment is ArmResourceCreateOrReplaceAsync<
    GremlinRoleAssignmentResource,
    Response = ArmResourceUpdatedResponse<GremlinRoleAssignmentResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GremlinRoleAssignmentResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Gremlin Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteGremlinRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    GremlinRoleAssignmentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Gremlin Role Assignments.
   */
  listGremlinRoleAssignments is ArmResourceListByParent<GremlinRoleAssignmentResource>;
}

@@doc(GremlinRoleAssignmentResource.name, "The GUID for the Role Assignment.");
@@doc(GremlinRoleAssignmentResource.properties,
  "Properties to create and update an Azure Cosmos DB Gremlin Role Assignment."
);
@@doc(GremlinRoleAssignmentResources.createUpdateGremlinRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
