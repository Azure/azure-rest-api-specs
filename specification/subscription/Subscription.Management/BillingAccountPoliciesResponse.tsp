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
@tenantResource
model BillingAccountPoliciesResponse
  is Azure.ResourceManager.ProxyResource<BillingAccountPoliciesResponseProperties> {
  ...ResourceNameParameter<
    Resource = BillingAccountPoliciesResponse,
    KeyName = "policy",
    SegmentName = "policies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BillingAccountPoliciesResponses {
  /**
   * Get Billing Account Policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BillingAccount_GetPolicy")
  getPolicy is ArmResourceRead<
    BillingAccountPoliciesResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(BillingAccountPoliciesResponse.name, "");
@@doc(BillingAccountPoliciesResponse.properties,
  "Billing account policies response properties."
);
