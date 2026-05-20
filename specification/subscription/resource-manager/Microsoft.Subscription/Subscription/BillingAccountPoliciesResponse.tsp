import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Subscription;
/**
 * Billing account policies information.
 */
@singleton("default")
model BillingAccountPoliciesResponse
  is Azure.ResourceManager.ProxyResource<BillingAccountPoliciesResponseProperties> {
  ...ResourceNameParameter<
    Resource = BillingAccountPoliciesResponse,
    KeyName = "policy",
    SegmentName = "policies",
    NamePattern = ""
  >;
}

alias billingAccountExternalResource = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "billingAccountId",
  ParentType = "Tenant"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingAccountPoliciesResponses {
  /**
   * Get Billing Account Policy.
   */
  getPolicy is Extension.Read<
    billingAccountExternalResource,
    BillingAccountPoliciesResponse
  >;
}

@@doc(BillingAccountPoliciesResponse.name, "");
@@doc(BillingAccountPoliciesResponse.properties,
  "Billing account policies response properties."
);
