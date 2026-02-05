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
  get is ArmResourceRead<RedisCacheAccessPolicyAssignment>;

  /**
   * Adds the access policy assignment to the specified users
   */
  createUpdate is ArmResourceCreateOrReplaceAsync<
    RedisCacheAccessPolicyAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = RedisCacheAccessPolicyAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the access policy assignment from a redis cache
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy approved usage of non-standard operation response codes. Consider revising in a future api version."
  delete is ArmResourceDeleteWithoutOkAsync<
    RedisCacheAccessPolicyAssignment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the list of access policy assignments associated with this redis cache
   */
  list is ArmResourceListByParent<
    RedisCacheAccessPolicyAssignment,
    Response = RedisCacheAccessPolicyAssignmentList
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
