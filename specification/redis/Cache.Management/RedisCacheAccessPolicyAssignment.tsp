import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Response to an operation on access policy assignment
 */
@parentResource(RedisResource)
model RedisCacheAccessPolicyAssignment
  is Azure.ResourceManager.ProxyResource<RedisCacheAccessPolicyAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = RedisCacheAccessPolicyAssignment,
    KeyName = "accessPolicyAssignmentName",
    SegmentName = "accessPolicyAssignments",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]|[a-zA-Z0-9])$"
  >;
}

@armResourceOperations
interface RedisCacheAccessPolicyAssignments {
  /**
   * Gets the list of assignments for an access policy of a redis cache
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AccessPolicyAssignment_Get")
  get is ArmResourceRead<RedisCacheAccessPolicyAssignment>;

  /**
   * Adds the access policy assignment to the specified users
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AccessPolicyAssignment_CreateUpdate")
  createUpdate is ArmResourceCreateOrReplaceAsync<
    RedisCacheAccessPolicyAssignment,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the access policy assignment from a redis cache
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy approved usage of operation response codes. Consider updating in a future API version."
  @operationId("AccessPolicyAssignment_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    RedisCacheAccessPolicyAssignment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the list of access policy assignments associated with this redis cache
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("AccessPolicyAssignment_List")
  list is ArmResourceListByParent<
    RedisCacheAccessPolicyAssignment,
    Response = ArmResponse<RedisCacheAccessPolicyAssignmentList>
  >;
}

@@maxLength(RedisCacheAccessPolicyAssignment.name, 63);
@@minLength(RedisCacheAccessPolicyAssignment.name, 3);
@@doc(RedisCacheAccessPolicyAssignment.name,
  "The name of the access policy assignment."
);
@@doc(RedisCacheAccessPolicyAssignment.properties,
  "Properties of an access policy assignment"
);
@@doc(RedisCacheAccessPolicyAssignments.createUpdate::parameters.resource,
  "Parameters supplied to the Create Update Access Policy Assignment operation."
);
