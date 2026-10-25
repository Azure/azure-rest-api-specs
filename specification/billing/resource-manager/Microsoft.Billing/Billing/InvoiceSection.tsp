import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
    NamePattern = BillingProfileCustomerInvoiceSectionNamePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias InvoiceSectionNameParameter = {
  /** The ID that uniquely identifies an invoice section. */
  @path
  @segment("invoiceSections")
  @key
  @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
  invoiceSectionName: string;
};

@armResourceOperations(#{ omitTags: true })
interface InvoiceSections {
  /**
   * Gets an invoice section by its ID. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("InvoiceSection")
  get is ArmResourceRead<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Creates or updates an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing RP that uses 202 long running operation for create or update Billing Profile."
  @tag("InvoiceSection")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response =
      | ArmResourceUpdatedResponse<InvoiceSection>
      | ArmResourceCreatedResponse<
          InvoiceSection,
          ArmLroLocationHeader<FinalResult = InvoiceSection> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("InvoiceSection")
  delete is ArmResourceDeleteWithoutOkAsync<
    InvoiceSection,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the invoice sections that a user has access to. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
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
      ...DefaultODataParameters;
    }
  >;

  /**
   * Adds a role assignment on an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
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
  @tag("BillingSubscription")
  @list
  @get
  billingSubscriptionsListByInvoiceSection is ArmResourceListByParent<
    BillingSubscription,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      ...InvoiceSectionNameParameter;
      ...BillingSubscriptionsListByInvoiceSectionParameters;
    },
    Response = ArmResponse<BillingSubscriptionListResult>
  >;

  /**
   * Validates if the invoice section can be deleted. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
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
      ...DefaultODataParameters;
    }
  >;

  /**
   * Lists the billed or unbilled transactions by invoice section name for given start date and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
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

      ...DefaultODataParameters;
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

  ...DefaultODataParameters;
};

alias InvoiceSectionsListByBillingProfileParameters = {
  /**
   * Can be used to get deleted invoice sections.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  ...DefaultODataParameters;
};

@@doc(
  InvoiceSection.name,
  "The ID that uniquely identifies an invoice section."
);
@@doc(InvoiceSection.properties, "An invoice section.");
@@doc(
  InvoiceSections.createOrUpdate::parameters.resource,
  "An invoice section."
);
@@doc(
  InvoiceSections.checkAccessByInvoiceSection::parameters.body,
  "The request object against which access of the caller will be checked."
);
@@doc(
  InvoiceSections.createByInvoiceSection::parameters.body,
  "The properties of the billing role assignment."
);
