import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * The billing properties of a subscription.
 */
@tenantResource
@parentResource(BillingProfile)
model BillingSubscription
  is Azure.ResourceManager.ProxyResource<BillingSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = BillingSubscription,
    KeyName = "billingSubscriptionName",
    SegmentName = "billingSubscriptions",
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias BillingSubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    @pattern(GuidPattern)
    billingSubscriptionName: string;
  },
  "BillingProfileSubscription"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptions {
  /**
   * Gets a subscription by its billing profile and ID. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingSubscription")
  getByBillingProfile is BillingSubscriptionOps.Read<
    BillingSubscription,
    Parameters = {
      /**
       * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
       */
      @query("expand")
      expand?: string;
    }
  >;

  /**
   * Lists the subscriptions that are billed to a billing profile. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Partner Agreement.
   */
  @tag("BillingSubscription")
  listByBillingProfile is BillingSubscriptionOps.List<
    BillingSubscription,
    Response = ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListByBillingProfileParameters
  >;
}
alias BillingSubscriptionOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    @pattern(GuidPattern)
    billingSubscriptionName: string;
  },
  "BillingSubscription"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptionOperationGroup {
  /**
   * Gets a subscription by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement,  Microsoft Partner Agreement, and Enterprise Agreement.
   */
  @tag("BillingSubscription")
  get is BillingSubscriptionOperationGroupOps.Read<
    BillingSubscription,
    Parameters = {
      /**
       * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
       */
      @query("expand")
      expand?: string;
    }
  >;

  /**
   * Updates the properties of a billing subscription.
   */
  @tag("BillingSubscription")
  @patch(#{ implicitOptionality: false })
  update is BillingSubscriptionOperationGroupOps.CustomPatchAsync<
    BillingSubscription,
    PatchModel = BillingSubscription
  >;

  /**
   * Cancels a billing subscription. This operation is supported only for billing accounts of type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingSubscription")
  delete is BillingSubscriptionOperationGroupOps.DeleteWithoutOkAsync<BillingSubscription>;

  /**
   * Lists the subscriptions for a billing account.
   */
  @tag("BillingSubscription")
  listByBillingAccount is BillingSubscriptionOperationGroupOps.List<
    BillingSubscription,
    Response = ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListByBillingAccountParameters
  >;

  /**
   * Cancels a usage-based subscription. This operation is supported only for billing accounts of type Microsoft Partner Agreement.
   */
  @tag("BillingSubscription")
  cancel is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    CancelSubscriptionRequest,
    void,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Merges the billing subscription provided in the request with a target billing subscription.
   */
  @tag("BillingSubscription")
  merge is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    BillingSubscriptionMergeRequest,
    BillingSubscription
  >;

  /**
   * Moves charges for a subscription to a new invoice section. The new invoice section must belong to the same billing profile as the existing invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingSubscription")
  move is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    BillingSubscription
  >;

  /**
   * Splits a subscription into a new subscription with quantity less than current subscription quantity and not equal to 0.
   */
  @tag("BillingSubscription")
  split is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    BillingSubscriptionSplitRequest,
    BillingSubscription
  >;

  /**
   * Validates if charges for a subscription can be moved to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingSubscription")
  validateMoveEligibility is BillingSubscriptionOperationGroupOps.ActionSync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    ArmResponse<MoveBillingSubscriptionEligibilityResult>
  >;
}

alias BillingSubscriptionsListByBillingProfileParameters = {
  /**
   * Can be used to get deleted billing subscriptions.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
   */
  @query("expand")
  expand?: string;

  ...DefaultODataParameters;
};

alias BillingSubscriptionsListByBillingAccountParameters = {
  /**
   * Can be used to get deleted billing subscriptions.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * Can be used to get tenant-owned billing subscriptions. This field is only applies to Microsoft Online Services Program billing accounts.
   */
  @query("includeTenantSubscriptions")
  includeTenantSubscriptions?: boolean = false;

  /**
   * Can be used to get failed billing subscriptions.
   */
  @query("includeFailed")
  includeFailed?: boolean = false;

  /**
   * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
   */
  @query("expand")
  expand?: string;

  ...DefaultODataParameters;
};

@@doc(
  BillingSubscription.name,
  "The ID that uniquely identifies a subscription."
);
@@doc(
  BillingSubscription.properties,
  "The properties of a(n) BillingSubscription"
);
@@doc(
  BillingSubscriptionOperationGroup.update::parameters.properties,
  "The billing properties of a subscription."
);
@@doc(
  BillingSubscriptionOperationGroup.cancel::parameters.body,
  "Request parameters for cancel customer subscription."
);
@@doc(
  BillingSubscriptionOperationGroup.merge::parameters.body,
  "Request parameters that are provided to merge the two billing subscriptions."
);
@@doc(
  BillingSubscriptionOperationGroup.move::parameters.body,
  "Request parameters to transfer billing subscription."
);
@@doc(
  BillingSubscriptionOperationGroup.split::parameters.body,
  "Request parameters that are provided to split the billing subscription."
);
@@doc(
  BillingSubscriptionOperationGroup.validateMoveEligibility::parameters.body,
  "Request parameters to transfer billing subscription."
);
