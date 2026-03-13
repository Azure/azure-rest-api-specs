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
 * An invoice section.
 */
@tenantResource
@parentResource(BillingProfile)
model InvoiceSection
  is Azure.ResourceManager.ProxyResource<InvoiceSectionProperties> {
  ...ResourceNameParameter<
    Resource = InvoiceSection,
    KeyName = "invoiceSectionName",
    SegmentName = "invoiceSections",
    NamePattern = "^[a-zA-Z\\d-_]{1,128}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias InvoiceSectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
  {
    /** The ID that uniquely identifies an invoice section. */
    @path
    @segment("invoiceSections")
    @key
    invoiceSectionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface InvoiceSections {
  /**
   * Gets an invoice section by its ID. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("InvoiceSection")
  get is ArmResourceRead<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Creates or updates an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("InvoiceSection")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<InvoiceSection> | ArmResourceCreatedResponse<
      InvoiceSection,
      ArmLroLocationHeader<FinalResult = InvoiceSection> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("InvoiceSection")
  delete is ArmResourceDeleteWithoutOkAsync<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the invoice sections that a user has access to. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("InvoiceSection")
  listByBillingProfile is ArmResourceListByParent<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = InvoiceSectionsListByBillingProfileParameters,
    Response = ArmResponse<InvoiceSectionListResult>
  >;

  /**
   * Lists the billing permissions the caller has for an invoice section.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByInvoiceSection is ArmResourceActionSync<
    InvoiceSection,
    void,
    ArmResponse<BillingPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Provides a list of check access response objects for an invoice section.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByInvoiceSection is ArmResourceActionSync<
    InvoiceSection,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * The list of billing requests submitted for the invoice section.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRequest")
  @list
  @get
  @action("billingRequests")
  billingRequestsListByInvoiceSection is ArmResourceActionSync<
    InvoiceSection,
    void,
    Response = ArmResponse<BillingRequestListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
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
   * Adds a role assignment on an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("createBillingRoleAssignment")
  createByInvoiceSection is ArmResourceActionAsync<
    InvoiceSection,
    BillingRoleAssignmentProperties,
    BillingRoleAssignment,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the role assignments for the caller on an invoice section while fetching user info for each role assignment. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("resolveBillingRoleAssignments")
  resolveByInvoiceSection is ArmResourceActionAsync<
    InvoiceSection,
    void,
    BillingRoleAssignmentListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingRoleAssignmentsResolveByInvoiceSectionParameters
  >;

  /**
   * Lists the subscriptions that are billed to an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByInvoiceSection is InvoiceSectionOps.ActionSync<
    InvoiceSection,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListByInvoiceSectionParameters
  >;

  /**
   * Validates if the invoice section can be deleted. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("InvoiceSection")
  validateDeleteEligibility is ArmResourceActionSync<
    InvoiceSection,
    void,
    ArmResponse<DeleteInvoiceSectionEligibilityResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
  /**
   * Lists the products for an invoice section. These don't include products billed based on usage. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Product")
  @list
  @get
  @action("products")
  productsListByInvoiceSection is ArmResourceActionSync<
    InvoiceSection,
    void,
    ArmResponse<ProductListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
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
   * Lists the billed or unbilled transactions by invoice section name for given start date and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Transaction")
  @list
  @get
  @action("transactions")
  transactionsListByInvoiceSection is ArmResourceActionSync<
    InvoiceSection,
    void,
    ArmResponse<TransactionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The start date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      @query("periodStartDate")
      periodStartDate: plainDate;

      /**
       * The end date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      @query("periodEndDate")
      periodEndDate: plainDate;

      /**
       * The type of transaction.
       */
      @query("type")
      type: TransactionType;

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

alias BillingRoleAssignmentsResolveByInvoiceSectionParameters = {
  /**
   * Resolves the scope display name for each of the role assignments.
   */
  @query("resolveScopeDisplayNames")
  resolveScopeDisplayNames?: boolean = false;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  @query("filter")
  filter?: string;
};

alias BillingSubscriptionsListByInvoiceSectionParameters = {
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
};

alias InvoiceSectionsListByBillingProfileParameters = {
  /**
   * Can be used to get deleted invoice sections.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

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
};

@@doc(InvoiceSection.name,
  "The ID that uniquely identifies an invoice section."
);
@@doc(InvoiceSection.properties, "An invoice section.");
@@doc(InvoiceSections.createOrUpdate::parameters.resource,
  "An invoice section."
);
@@doc(InvoiceSections.checkAccessByInvoiceSection::parameters.body,
  "The request object against which access of the caller will be checked."
);
@@doc(InvoiceSections.createByInvoiceSection::parameters.body,
  "The properties of the billing role assignment."
);
