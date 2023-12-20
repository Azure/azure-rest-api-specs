import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Billing;
@doc("A billing subscription.")
@tenantResource
model BillingSubscription is ProxyResource<BillingSubscriptionProperties> {
  @doc("The ID that uniquely identifies a subscription.")
  @path
  @key("billingSubscriptionName")
  @segment("billingSubscriptions")
  name: string;
}

@armResourceOperations
interface BillingSubscriptions {
  @doc("Gets a subscription by its ID. The operation is currently supported for billing accounts with agreement type Microsoft Customer Agreement, Microsoft Partner Agreement and Microsoft Online Services Program.")
  get is ArmResourceRead<BillingSubscription>;
  @doc("Updates the properties of a billing subscription.")
  update is ArmResourcePatchAsync<
    BillingSubscription,
    BillingSubscriptionProperties
  >;
  @doc("Cancels a billing subscription.")
  delete is ArmResourceDeleteAsync<BillingSubscription>;
  @doc("Lists the subscriptions for a billing account. The operation is currently supported for billing accounts with agreement type Microsoft Customer Agreement, Microsoft Partner Agreement and Microsoft Online Services Program.")
  listByBillingAccount is ArmResourceListByParent<BillingSubscription>;
  @doc("Moves a subscription's charges to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.")
  move is ArmResourceActionAsync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    BillingSubscription
  >;
  @doc("Validates if a subscription's charges can be moved to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.")
  validateMoveEligibility is ArmResourceActionSync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    ValidateMoveBillingSubscriptionEligibilityResult
  >;
  @doc("Merges the billing subscription provided in the request with a target billing subscription.")
  merge is ArmResourceActionAsync<
    BillingSubscription,
    BillingSubscriptionMergeRequest,
    BillingSubscription
  >;
  @doc("Splits a subscription into a new subscription with quantity less than current subscription quantity and not equal to 0.")
  split is ArmResourceActionAsync<
    BillingSubscription,
    BillingSubscriptionSplitRequest,
    BillingSubscription
  >;
}
