import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    billingSubscriptionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptions {
  /**
   * Gets a subscription by its billing profile and ID. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  listByBillingProfile is BillingSubscriptionOps.List<
    BillingSubscription,
    Response = ArmResponse<BillingSubscriptionListResult>,
    Parameters = {
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

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      @query("search")
      search?: string;
    }
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
    billingAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    billingSubscriptionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingSubscriptionOperationGroup {
  /**
   * Gets a subscription by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement,  Microsoft Partner Agreement, and Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  @patch(#{ implicitOptionality: false })
  update is BillingSubscriptionOperationGroupOps.CustomPatchAsync<
    BillingSubscription,
    PatchModel = BillingSubscriptionPatch
  >;

  /**
   * Cancels a billing subscription. This operation is supported only for billing accounts of type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  delete is BillingSubscriptionOperationGroupOps.DeleteWithoutOkAsync<BillingSubscription>;

  /**
   * Lists the subscriptions for a billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  listByBillingAccount is BillingSubscriptionOperationGroupOps.List<
    BillingSubscription,
    Response = ArmResponse<BillingSubscriptionListResult>,
    Parameters = {
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

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      @query("search")
      search?: string;
    }
  >;

  /**
   * Cancels a usage-based subscription. This operation is supported only for billing accounts of type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  merge is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    BillingSubscriptionMergeRequest,
    BillingSubscription
  >;

  /**
   * Moves charges for a subscription to a new invoice section. The new invoice section must belong to the same billing profile as the existing invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  move is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    BillingSubscription
  >;

  /**
   * Splits a subscription into a new subscription with quantity less than current subscription quantity and not equal to 0.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  split is BillingSubscriptionOperationGroupOps.ActionAsync<
    BillingSubscription,
    BillingSubscriptionSplitRequest,
    BillingSubscription
  >;

  /**
   * Validates if charges for a subscription can be moved to a new invoice section. This operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  validateMoveEligibility is BillingSubscriptionOperationGroupOps.ActionSync<
    BillingSubscription,
    MoveBillingSubscriptionRequest,
    ArmResponse<MoveBillingSubscriptionEligibilityResult>
  >;
}

@@doc(BillingSubscription.name,
  "The ID that uniquely identifies a subscription."
);
@@doc(BillingSubscription.properties,
  "The properties of a(n) BillingSubscription"
);
@@doc(BillingSubscriptionOperationGroup.update::parameters.properties,
  "The billing properties of a subscription."
);
@@doc(BillingSubscriptionOperationGroup.cancel::parameters.body,
  "Request parameters for cancel customer subscription."
);
@@doc(BillingSubscriptionOperationGroup.merge::parameters.body,
  "Request parameters that are provided to merge the two billing subscriptions."
);
@@doc(BillingSubscriptionOperationGroup.move::parameters.body,
  "Request parameters to transfer billing subscription."
);
@@doc(BillingSubscriptionOperationGroup.split::parameters.body,
  "Request parameters that are provided to split the billing subscription."
);
@@doc(BillingSubscriptionOperationGroup.validateMoveEligibility::parameters.body,
  "Request parameters to transfer billing subscription."
);
