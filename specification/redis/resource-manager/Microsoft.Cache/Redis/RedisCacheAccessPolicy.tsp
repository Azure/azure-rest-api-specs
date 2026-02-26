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
 * Response to get/put access policy.
 */
@parentResource(RedisResource)
model RedisCacheAccessPolicy
  is Azure.ResourceManager.ProxyResource<RedisCacheAccessPolicyProperties> {
  ...ResourceNameParameter<
    Resource = RedisCacheAccessPolicy,
    KeyName = "accessPolicyName",
    SegmentName = "accessPolicies",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9- ]*[a-zA-Z0-9]|[a-zA-Z0-9])$"
  >;
}

@armResourceOperations
interface RedisCacheAccessPolicies {
  /**
   * Gets the detailed information about an access policy of a redis cache
   */
  get is ArmResourceRead<RedisCacheAccessPolicy>;

  /**
   * Adds an access policy to the redis cache
   */
  createUpdate is ArmResourceCreateOrReplaceAsync<
    RedisCacheAccessPolicy,
    LroHeaders = ArmLroLocationHeader<FinalResult = RedisCacheAccessPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the access policy from a redis cache
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Legacy approved usage of non-standard operation response codes. Consider revising in a future api version."
  delete is ArmResourceDeleteWithoutOkAsync<
    RedisCacheAccessPolicy,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the list of access policies associated with this redis cache
   */
  list is ArmResourceListByParent<
    RedisCacheAccessPolicy,
    Response = RedisCacheAccessPolicyList
  >;
}

@@maxLength(RedisCacheAccessPolicy.name, 63);
@@minLength(RedisCacheAccessPolicy.name, 3);
@@doc(RedisCacheAccessPolicy.name,
  "The name of the access policy that is being added to the Redis cache."
);
@@doc(RedisCacheAccessPolicy.properties, "Properties of an access policy.");
@@doc(RedisCacheAccessPolicies.createUpdate::parameters.resource,
  "Parameters supplied to the Create Update Access Policy operation."
);
