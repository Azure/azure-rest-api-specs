import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Billing;
/**
 * A policy at billing account scope.
 */
@singleton("default")
@tenantResource
@parentResource(BillingAccount)
model BillingAccountPolicy
  is Azure.ResourceManager.ProxyResource<BillingAccountPolicyProperties> {
  ...ResourceNameParameter<
    Resource = BillingAccountPolicy,
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
interface BillingAccountPolicies {
  /**
   * Get the policies for a billing account of Enterprise Agreement type.
   */
  @tag("Policy")
  getByBillingAccount is ArmResourceRead<
    BillingAccountPolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update the policies for a billing account of Enterprise Agreement type.
   */
  @tag("Policy")
  createOrUpdateByBillingAccount is ArmResourceCreateOrReplaceAsync<
    BillingAccountPolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingAccountPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(BillingAccountPolicy.name, "");
@@doc(BillingAccountPolicy.properties, "A policy at billing account scope.");
@@doc(
  BillingAccountPolicies.createOrUpdateByBillingAccount::parameters.resource,
  "A policy at billing account scope."
);
