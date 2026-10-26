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
 * A billing profile.
 */
@tenantResource
@parentResource(BillingAccount)
model BillingProfile
  is Azure.ResourceManager.ProxyResource<BillingProfileProperties> {
  ...ResourceNameParameter<
    Resource = BillingProfile,
    KeyName = "billingProfileName",
    SegmentName = "billingProfiles",
    NamePattern = "^[a-zA-Z\\d-_]{1,128}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface BillingProfiles {
  /**
   * Gets a billing profile by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProfile")
  get is ArmResourceRead<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Creates or updates a billing profile. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement. If you are a MCA Individual (Pay-as-you-go) customer, then please use the Azure portal experience to create the billing profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProfile")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response =
      | ArmResourceUpdatedResponse<BillingProfile>
      | ArmResourceCreatedResponse<
          BillingProfile,
          ArmLroLocationHeader<FinalResult = BillingProfile> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a billing profile. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProfile")
  delete is ArmResourceDeleteWithoutOkAsync<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the billing profiles that a user has access to. The operation is supported for billing accounts with agreement of type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProfile")
  listByBillingAccount is ArmResourceListByParent<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingProfilesListByBillingAccountParameters,
    Response = ArmResponse<BillingProfileListResult>
  >;

  /**
   * Lists the billing permissions the caller has on a billing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<BillingPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Provides a list of check access response objects for a billing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Validates if the billing profile can be deleted. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingProfile")
  validateDeleteEligibility is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<DeleteBillingProfileEligibilityResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * The list of billing requests submitted for the billing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRequest")
  @list
  @get
  @action("billingRequests")
  billingRequestsListByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<BillingRequestListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing billingRequestsListByBillingProfile.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;

  /**
   * Adds a role assignment on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("createBillingRoleAssignment")
  createByBillingProfile is ArmResourceActionAsync<
    BillingProfile,
    BillingRoleAssignmentProperties,
    BillingRoleAssignment,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the role assignments for the caller on an billing profile while fetching user info for each role assignment. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("resolveBillingRoleAssignments")
  resolveByBillingProfile is ArmResourceActionAsync<
    BillingProfile,
    void,
    BillingRoleAssignmentListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingRoleAssignmentsResolveByBillingProfileParameters
  >;

  /**
   * Lists the invoices for a billing profile for a given start date and end date. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Invoice")
  @list
  @get
  @action("invoices")
  invoicesListByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    InvoiceListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.periodStartDate retains the periodStartDate query parameter; preserve wire compatibility."
      @query("periodStartDate")
      periodStartDate?: plainDate;

      /**
       * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.periodEndDate retains the periodEndDate query parameter; preserve wire compatibility."
      @query("periodEndDate")
      periodEndDate?: plainDate;

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing invoicesListByBillingProfile.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;
  /**
   * Lists the products for a billing profile. These don't include products billed based on usage. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Product")
  @list
  @get
  @action("products")
  productsListByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<ProductListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing productsListByBillingProfile.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;

  /**
   * Lists the reservations for a billing profile and the roll up counts of reservations group by provisioning state.
   */
  @tag("Reservations")
  @list
  @get
  @action("reservations")
  reservationsListByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<ReservationsListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The number of reservations to skip from the list before returning results
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.skiptoken retains the skiptoken query parameter; preserve wire compatibility."
      @query("skiptoken")
      skiptoken?: float32;

      /**
       * To indicate whether to refresh the roll up counts of the reservations group by provisioning states
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.refreshSummary retains the refreshSummary query parameter; preserve wire compatibility."
      @query("refreshSummary")
      refreshSummary?: string;

      /**
       * The selected provisioning state
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.selectedState retains the selectedState query parameter; preserve wire compatibility."
      @query("selectedState")
      selectedState?: string;

      /**
       * The number of reservations to return in API response.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing reservationsListByBillingProfile.take retains the take query parameter; preserve wire compatibility."
      @query("take")
      take?: float32;
    }
  >;

  /**
   * Lists the billed or unbilled transactions by billing profile name for given start and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Transaction")
  @list
  @get
  @action("transactions")
  transactionsListByBillingProfile is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<TransactionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The start date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.periodStartDate retains the periodStartDate query parameter; preserve wire compatibility."
      @query("periodStartDate")
      periodStartDate: plainDate;

      /**
       * The end date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.periodEndDate retains the periodEndDate query parameter; preserve wire compatibility."
      @query("periodEndDate")
      periodEndDate: plainDate;

      /**
       * The type of transaction.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.type retains the type query parameter; preserve wire compatibility."
      @query("type")
      type: TransactionType;

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing transactionsListByBillingProfile.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;
}

alias BillingProfilesListByBillingAccountParameters = {
  /**
   * Can be used to get deleted billing profiles.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.includeDeleted retains the includeDeleted query parameter; preserve wire compatibility."
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.filter retains the filter query parameter; preserve wire compatibility."
  @query("filter")
  filter?: string;

  /**
   * The orderby query option allows clients to request resources in a particular order.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.orderBy retains the orderBy query parameter; preserve wire compatibility."
  @query("orderBy")
  orderBy?: string;

  /**
   * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.top retains the top query parameter; preserve wire compatibility."
  @query("top")
  top?: int64;

  /**
   * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.skip retains the skip query parameter; preserve wire compatibility."
  @query("skip")
  skip?: int64;

  /**
   * The count query option allows clients to request a count of the matching resources included with the resources in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.count retains the count query parameter; preserve wire compatibility."
  @query("count")
  count?: boolean;

  /**
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing BillingProfilesListByBillingAccountParameters.search retains the search query parameter; preserve wire compatibility."
  @query("search")
  search?: string;
};

alias BillingRoleAssignmentsResolveByBillingProfileParameters = {
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

@@doc(
  BillingProfile.name,
  "The ID that uniquely identifies a billing profile."
);
@@doc(BillingProfile.properties, "A billing profile.");
@@doc(
  BillingProfiles.createOrUpdate::parameters.resource,
  "A billing profile."
);
@@doc(
  BillingProfiles.checkAccessByBillingProfile::parameters.body,
  "The request object against which access of the caller will be checked."
);
@@doc(
  BillingProfiles.createByBillingProfile::parameters.body,
  "The properties of the billing role assignment."
);
