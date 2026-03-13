import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface BillingAccountPolicies {
  /**
   * Get the policies for a billing account of Enterprise Agreement type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Policy")
  getByBillingAccount is ArmResourceRead<
    BillingAccountPolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update the policies for a billing account of Enterprise Agreement type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
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
@@doc(BillingAccountPolicies.createOrUpdateByBillingAccount::parameters.resource,
  "A policy at billing account scope."
);
