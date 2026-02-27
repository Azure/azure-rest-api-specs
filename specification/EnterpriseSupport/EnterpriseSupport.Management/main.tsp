import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;

@armProviderNamespace("Microsoft.EnterpriseSupport")
@service(#{
  title: "Microsoft ESRP",
  version: "2024-09-24-preview",
  summary: "Microsoft Enterprise Support Resource Provider",
})
namespace Microsoft.EnterpriseSupport;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ESRPProviderHub resource")
model EnterpriseSupports
  is TrackedResource<EnterpriseSupportsResponseProperties> {
  @doc("The name of the  Enterprise Support")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("EnterpriseSupportName")
  @segment("enterpriseSupports")
  @path
  name: string;

  ...ManagedByProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  Deleted,
  Succeeded,
  Failed,
}

@doc("Details of the ESRP EnterpriseSupport.")
model EnterpriseSupportsResponseProperties {
  @doc("Provisioning status")
  provisioningState?: ProvisioningState;

  @doc("Billing Account ID")
  billingAccountId: string;

  @doc("Billing Group ID")
  billingGroupId: string;

  @doc("Invoice section for the billing account")
  projectId: string;

  @doc("Quantity for the purchase")
  quantity: integer;

  @doc("Service start date for  Enterprise Support")
  serviceStartDate: utcDateTime;

  @doc("CSAM for the  Enterprise Support")
  csam: string;

  @doc("Product UPN")
  upn: string;
}

@doc("The request for an eligibility check.")
model ValidateEnterpriseSupportRequest {
  @doc("The array of line items to be validated")
  lineItems: Array<ValidateEnterpriseSupportRequestItem>;
}

@doc("The item to be validated.")
model ValidateEnterpriseSupportRequestItem {
  @doc("The scope. e.g. /billingAccounts/ba1/billingProfiles/bp1")
  scope: string;

  @doc("The product upn")
  upn: string;

  @doc("The quantity for this purchase")
  quantity: integer;

  @doc("The start date for this purchase")
  serviceStartDate?: utcDateTime;
}

@doc("The response for an eligibility check.")
model ValidateEnterpriseSupportResponse {
  @doc("The array of line item validations.")
  lineItems: Array<ValidateEnterpriseSupportResponseItem>;
}

@doc("The eligibility decision")
enum ValidateEligibility {
  eligible,
  ineligible,
  undetermined,
}

@doc("The item for an eligibility check.")
model ValidateEnterpriseSupportResponseItem {
  @doc("The scope. e.g. /billingAccounts/ba1/billingProfiles/bp1")
  scope: string;

  @doc("The product upn")
  upn: string;

  @doc("The quantity for this purchase")
  quantity: integer;

  @doc("The start date for this purchase")
  serviceStartDate?: utcDateTime;

  @doc("eligibility")
  isEligible: ValidateEligibility;

  @doc("String reason for isEligible")
  reason?: string;

  @doc("Code reason for isEligible")
  reasonCode?: integer;
}

@doc("Model for Support Price Breakdown")
model SupportPriceBreakdownItem {
  @doc("Product Cost")
  productCost: float32;

  @doc("Support Cost")
  supportCost: float32;

  @doc("Support Rate Applied")
  supportRateApplied: float32;
}

@doc("Response Model for Support Cost Response Item")
model SupportCostResponseItem {
  @doc("The billing period in form of YYYY-MM")
  billingPeriod: string;

  @doc("How support charge was calculated, % applied")
  pricingBucketBreakdown: Array<PricingBucketBreakdown>;

  @doc("The floor price")
  floorPrice: float32;

  @doc("Is billing closed")
  isClosed: boolean;

  @doc("The billing currency")
  billingCurrency: string;
}

@doc("Response Model for Pricing Bucket breakdown")
model PricingBucketBreakdown {
  @doc("The Id")
  id: string;

  @doc("The product running total")
  productRunningTotal: float32;

  @doc("The support running total")
  supportRunningTotal: float32;

  @doc("How support charge was calculated, % applied")
  pricingTierBreakdown: Array<SupportPriceBreakdownItem>;

  @doc("Pricing Bucket � Azure Monthly, Azure Yearly, Bizapps Monthly, BizApps Yearly")
  pricingBucket: float32;
}

@armResourceOperations
interface EnterpriseSupportsResource
  extends TrackedResourceOperations<
      EnterpriseSupports,
      EnterpriseSupportsResponseProperties
    > {
  @post
  @doc("Custom operation to get support cost for a customer by billing period")
  SupportCost(
    ...ResourceInstanceParameters<EnterpriseSupports>,
    @query billingPeriod: string,
  ): ArmResponse<SupportCostResponseItem> | ErrorResponse;
}

@autoRoute
@armResourceOperations
interface ProviderLevelOperations {
  @post
  @doc("ProviderLevel operation to check eligibility to create EnterpriseSupport instance")
  @segment("providers/Microsoft.EnterpriseSupport/validate")
  validateEnterpriseSupport(
    @doc("lineItems to validate") @body body: ValidateEnterpriseSupportRequest,
  ): ArmResponse<ValidateEnterpriseSupportResponse>;
}
