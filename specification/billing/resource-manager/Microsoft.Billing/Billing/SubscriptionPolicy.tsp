import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.Billing;
/**
 * A policy at subscription scope.
 */
@singleton("default")
@subscriptionResource
model SubscriptionPolicy
  is Azure.ResourceManager.ProxyResource<SubscriptionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionPolicy,
    KeyName = "policy",
    SegmentName = "policies",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface SubscriptionPolicies {
  /**
   * Lists the policies that are managed by the Billing Admin for the defined subscriptions. This is supported for Microsoft Online Services Program, Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  @tag("Policy")
  getBySubscription is ArmResourceRead<
    SubscriptionPolicy,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(SubscriptionPolicy.name, "");
@@doc(SubscriptionPolicy.properties, "A policy at subscription scope.");
