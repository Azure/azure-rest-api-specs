import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Billing;
/**
 * A policy at billing profile scope.
 */
@singleton("default")
@tenantResource
@parentResource(BillingProfile)
model BillingProfilePolicy
  is Azure.ResourceManager.ProxyResource<BillingProfilePolicyProperties> {
  ...ResourceNameParameter<
    Resource = BillingProfilePolicy,
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Policies by design cannot be deleted, are system policies that can be toggled or read."
@armResourceOperations(#{ omitTags: true })
interface BillingProfilePolicies {
  /**
   * Lists the policies for a billing profile. This operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Policy")
  getByBillingProfile is ArmResourceRead<
    BillingProfilePolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates the policies for a billing profile. This operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Policy")
  createOrUpdateByBillingProfile is ArmResourceCreateOrReplaceAsync<
    BillingProfilePolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingProfilePolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(BillingProfilePolicy.name, "");
@@doc(BillingProfilePolicy.properties, "A policy at billing profile scope.");
@@doc(
  BillingProfilePolicies.createOrUpdateByBillingProfile::parameters.resource,
  "A policy at billing profile scope."
);
