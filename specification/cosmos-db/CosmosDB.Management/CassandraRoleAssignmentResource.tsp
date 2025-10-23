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
 * Parameters to create and update an Azure Cosmos DB Cassandra Role Assignment.
 */
@parentResource(DatabaseAccountGetResults)
model CassandraRoleAssignmentResource
  is Azure.ResourceManager.ProxyResource<CassandraRoleAssignmentResourceProperties> {
  ...ResourceNameParameter<
    Resource = CassandraRoleAssignmentResource,
    KeyName = "roleAssignmentId",
    SegmentName = "cassandraRoleAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CassandraRoleAssignmentResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Cassandra Role Assignment with the given Id.
   */
  getCassandraRoleAssignment is ArmResourceRead<CassandraRoleAssignmentResource>;

  /**
   * Creates or updates an Azure Cosmos DB Cassandra Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUpdateCassandraRoleAssignment is ArmResourceCreateOrReplaceAsync<
    CassandraRoleAssignmentResource,
    Response = ArmResourceUpdatedResponse<CassandraRoleAssignmentResource> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CassandraRoleAssignmentResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes an existing Azure Cosmos DB Cassandra Role Assignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteCassandraRoleAssignment is ArmResourceDeleteWithoutOkAsync<
    CassandraRoleAssignmentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the list of all Azure Cosmos DB Cassandra Role Assignments.
   */
  listCassandraRoleAssignments is ArmResourceListByParent<CassandraRoleAssignmentResource>;
}

@@doc(CassandraRoleAssignmentResource.name,
  "The GUID for the Role Assignment."
);
@@doc(CassandraRoleAssignmentResource.properties,
  "Properties to create and update an Azure Cosmos DB Cassandra Role Assignment."
);
@@doc(CassandraRoleAssignmentResources.createUpdateCassandraRoleAssignment::parameters.resource,
  "The properties required to create or update a Role Assignment."
);
