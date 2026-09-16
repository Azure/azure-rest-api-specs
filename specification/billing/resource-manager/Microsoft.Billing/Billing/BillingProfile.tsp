import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

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
    NamePattern = BillingProfileCustomerInvoiceSectionNamePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface BillingProfiles {
  /**
   * Gets a billing profile by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  @tag("BillingProfile")
  get is ArmResourceRead<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Creates or updates a billing profile. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement. If you are a MCA Individual (Pay-as-you-go) customer, then please use the Azure portal experience to create the billing profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing RP that uses 202 long running operation for create or update Billing Profile."
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
  @tag("BillingProfile")
  delete is ArmResourceDeleteWithoutOkAsync<
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the billing profiles that a user has access to. The operation is supported for billing accounts with agreement of type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
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
  @tag("BillingProfile")
  validateDeleteEligibility is ArmResourceActionSync<
    BillingProfile,
    void,
    ArmResponse<DeleteBillingProfileEligibilityResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates invoice recipient contacts for a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("BillingProfile")
  @action("updateInvoiceRecipientContacts")
  updateInvoiceRecipientContacts is ArmResourceActionAsync<
    BillingProfile,
    UpdateInvoiceRecipientContactsRequest,
    BillingProfile,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingProfile> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The list of billing requests submitted for the billing profile.
   */
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
      ...DefaultODataParameters;
    }
  >;

  /**
   * Adds a role assignment on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
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
      @query("periodStartDate")
      periodStartDate?: plainDate;

      /**
       * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      @query("periodEndDate")
      periodEndDate?: plainDate;

      ...DefaultODataParameters;
    }
  >;
  /**
   * Lists the products for a billing profile. These don't include products billed based on usage. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Partner Agreement.
   */
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
      ...DefaultODataParameters;
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

  /**
   * Lists the billed or unbilled transactions by billing profile name for given start and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
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

alias BillingProfilesListByBillingAccountParameters = {
  /**
   * Can be used to get deleted billing profiles.
   */
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  ...DefaultODataParameters;
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
