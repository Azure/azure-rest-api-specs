import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Describes the access policy assignment of Redis Enterprise database
 */
@parentResource(Database)
model AccessPolicyAssignment
  is Azure.ResourceManager.ProxyResource<AccessPolicyAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = AccessPolicyAssignment,
    KeyName = "accessPolicyAssignmentName",
    SegmentName = "accessPolicyAssignments",
    NamePattern = "^[A-Za-z0-9]{1,60}$"
  >;
}

@armResourceOperations
interface AccessPolicyAssignments {
  /**
   * Gets information about access policy assignment for database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessPolicyAssignment_Get")
  get is ArmResourceRead<AccessPolicyAssignment>;

  /**
   * Creates/Updates a particular access policy assignment for a database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessPolicyAssignment_CreateUpdate")
  createUpdate is ArmResourceCreateOrReplaceAsync<AccessPolicyAssignment>;

  /**
   * Deletes a single access policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("AccessPolicyAssignment_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessPolicyAssignment,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all access policy assignments..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AccessPolicyAssignment_List")
  list is ArmResourceListByParent<
    AccessPolicyAssignment,
    Response = ArmResponse<AccessPolicyAssignmentList>
  >;
}

@@doc(AccessPolicyAssignment.name,
  "The name of the Redis Enterprise database access policy assignment."
);
@@doc(AccessPolicyAssignment.properties,
  "Properties of the access policy assignment."
);
@@doc(AccessPolicyAssignments.createUpdate::parameters.resource,
  "Parameters supplied to the create access policy assignment for database."
);
