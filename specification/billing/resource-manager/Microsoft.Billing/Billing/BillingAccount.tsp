import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * A billing account.
 */
@tenantResource
model BillingAccount
  is Azure.ResourceManager.ProxyResource<BillingAccountProperties> {
  ...ResourceNameParameter<
    Resource = BillingAccount,
    KeyName = "billingAccountName",
    SegmentName = "billingAccounts",
    NamePattern = "^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface BillingAccounts {
  /**
   * Gets a billing account by its ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  get is ArmResourceRead<
    BillingAccount,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates the properties of a billing account. Currently, displayName and address can be updated for billing accounts with agreement type Microsoft Customer Agreement. Currently address and notification email address can be updated for billing accounts with agreement type Microsoft Online Services Agreement. Currently, purchase order number can be edited for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BillingAccount,
    PatchModel = BillingAccountPatch,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the billing accounts that a user has access to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  list is ArmResourceListByParent<
    BillingAccount,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingAccountsListParameters,
    Response = ArmResponse<BillingAccountListResult>
  >;

  /**
   * Adds payment terms to all the billing profiles under the billing account. Currently, payment terms can be added only on billing accounts that have Agreement Type as 'Microsoft Customer Agreement' and AccountType as 'Enterprise'. This action needs pre-authorization and only Field Sellers are authorized to add the payment terms and is not a self-serve action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  addPaymentTerms is ArmResourceActionAsync<
    BillingAccount,
    PaymentTerm[],
    BillingAccount,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Cancels all the payment terms on billing account that falls after the cancellation date in the request. Currently, cancel payment terms is only served by admin actions and is not a self-serve action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  cancelPaymentTerms is ArmResourceActionAsync<
    BillingAccount,
    utcDateTime,
    BillingAccount,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Gets the transition details for a billing account that has transitioned from agreement type Microsoft Online Services Program to agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  confirmTransition is ArmResourceActionSync<
    BillingAccount,
    void,
    ArmResponse<TransitionDetails>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the invoice sections for which the user has permission to create Azure subscriptions. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  @list
  @action("listInvoiceSectionsWithCreateSubscriptionPermission")
  listInvoiceSectionsByCreateSubscriptionPermission is ArmResourceActionSync<
    BillingAccount,
    void,
    ArmResponse<InvoiceSectionWithCreateSubPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;
    }
  >;

  /**
   * Validates payment terms on a billing account with agreement type 'Microsoft Customer Agreement' and account type 'Enterprise'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  validatePaymentTerms is ArmResourceActionSync<
    BillingAccount,
    PaymentTerm[],
    ArmResponse<PaymentTermsEligibilityResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the billing permissions the caller has on a billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByBillingAccount is ArmResourceActionSync<
    BillingAccount,
    void,
    ArmResponse<BillingPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Provides a list of check access response objects for a billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByBillingAccount is ArmResourceActionSync<
    BillingAccount,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * The list of billing requests submitted for the billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRequest")
  @list
  @get
  @action("billingRequests")
  billingRequestsListByBillingAccount is ArmResourceActionSync<
    BillingAccount,
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
   * Adds a role assignment on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("createBillingRoleAssignment")
  createByBillingAccount is ArmResourceActionAsync<
    BillingAccount,
    BillingRoleAssignmentProperties,
    BillingRoleAssignment,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the role assignments for the caller on a billing account while fetching user info for each role assignment. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("resolveBillingRoleAssignments")
  resolveByBillingAccount is ArmResourceActionAsync<
    BillingAccount,
    void,
    BillingRoleAssignmentListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingRoleAssignmentsResolveByBillingAccountParameters
  >;

  /**
   * List savings plans by billing account.
   */
  @tag("Savings plan")
  @list
  @get
  @action("savingsPlans")
  savingsPlansListByBillingAccount is ArmResourceActionSync<
    BillingAccount,
    void,
    ArmResponse<SavingsPlanModelListResult>,
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
       * The number of savings plans to skip from the list before returning results
       */
      @query("skiptoken")
      skiptoken?: float32;

      /**
       * The number of savings plans to return
       */
      @query("take")
      take?: float32;

      /**
       * The selected provisioning state
       */
      @query("selectedState")
      selectedState?: string;

      /**
       * To indicate whether to refresh the roll up counts of the savings plans group by provisioning states
       */
      @query("refreshSummary")
      refreshSummary?: string;
    }
  >;

  /**
   * Gets a URL to download multiple invoice documents (invoice pdf, tax receipts, credit notes) as a zip file. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Invoice")
  @action("downloadDocuments")
  downloadDocumentsByBillingAccount is ArmResourceActionAsyncBase<
    BillingAccount,
    DocumentDownloadRequest[],
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<DocumentDownloadResult> | ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = DocumentDownloadResult> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Lists the reservations in the billing account and the roll up counts of reservations group by provisioning states.
   */
  @tag("Reservations")
  @list
  @get
  @action("reservations")
  reservationsListByBillingAccount is ArmResourceActionSync<
    BillingAccount,
    void,
    ArmResponse<ReservationsListResult>,
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
       * The number of reservations to skip from the list before returning results
       */
      @query("skiptoken")
      skiptoken?: float32;

      /**
       * To indicate whether to refresh the roll up counts of the reservations group by provisioning states
       */
      @query("refreshSummary")
      refreshSummary?: string;

      /**
       * The selected provisioning state
       */
      @query("selectedState")
      selectedState?: string;

      /**
       * The number of reservations to return in API response.
       */
      @query("take")
      take?: float32;
    }
  >;
}

alias BillingAccountsListParameters = {
  /**
   * When true, results will include Billing Accounts that the user does not have a direct role assignment on if the user has one of the following AAD roles: Global Administrator, Global Reader, Billing Administrator.
   */
  @query("includeAll")
  includeAll?: boolean = false;

  /**
   * When true, results will include Billing Accounts that are not fully created if the user has one of the following AAD roles: Global Administrator, Global Reader, Billing Administrator.
   */
  @query("includeAllWithoutBillingProfiles")
  includeAllWithoutBillingProfiles?: boolean = false;

  /**
   * When true, results will include any billing accounts in a deleted state.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * Includes billing accounts with agreement pending signature that the user has access to.
   */
  @query("includePendingAgreement")
  includePendingAgreement?: boolean = false;

  /**
   * Includes the customer's billing account of Microsoft Partner Agreement that the user has access to.
   */
  @query("includeResellee")
  includeResellee?: boolean = false;

  /**
   * Must be combined with legalOwnerOID, results will only include Billing Accounts for whom is legally responsible for the Billing Accounts. Optional.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("legalOwnerTID")
  legalOwnerTID?: string;

  /**
   * Must be combined with legalOwnerTID, results will only include Billing Accounts for whom is legally responsible for the Billing Accounts. Optional.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("legalOwnerOID")
  legalOwnerOID?: string;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  @query("filter")
  filter?: string;

  /**
   * Expand is allowed for SoldTo and EnrollmentDetails/PONumber.
   */
  @query("expand")
  expand?: string;

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
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  @query("search")
  search?: string;
};

alias BillingRoleAssignmentsResolveByBillingAccountParameters = {
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

@@doc(BillingAccount.name,
  "The ID that uniquely identifies a billing account."
);
@@doc(BillingAccount.properties, "A billing account.");
@@doc(BillingAccounts.update::parameters.properties, "A billing account.");
@@doc(BillingAccounts.addPaymentTerms::parameters.body,
  "The properties of payment term."
);
@@doc(BillingAccounts.cancelPaymentTerms::parameters.body,
  "Date after which any payment terms that needs to be cancelled."
);
@@doc(BillingAccounts.validatePaymentTerms::parameters.body,
  "The properties of payment term."
);
@@doc(BillingAccounts.checkAccessByBillingAccount::parameters.body,
  "The request object against which access of the caller will be checked."
);
@@doc(BillingAccounts.createByBillingAccount::parameters.body,
  "The properties of the billing role assignment."
);
@@doc(BillingAccounts.downloadDocumentsByBillingAccount::parameters.body,
  "A list of download details for individual documents."
);
