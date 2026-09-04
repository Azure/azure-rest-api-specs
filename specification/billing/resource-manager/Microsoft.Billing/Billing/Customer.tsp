import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * A partner's customer.
 */
@tenantResource
@parentResource(BillingProfile)
model Customer is Azure.ResourceManager.ProxyResource<CustomerProperties> {
  ...ResourceNameParameter<
    Resource = Customer,
    KeyName = "customerName",
    SegmentName = "customers",
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
interface Customers {
  /**
   * Gets a customer by its ID. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Customer")
  get is ArmResourceRead<
    Customer,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the customers that are billed to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Customer")
  listByBillingProfile is ArmResourceListByParent<
    Customer,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = CustomersListParametersWithExpand,
    Response = ArmResponse<CustomerListResult>
  >;

  /**
   * Lists the billing permissions the caller has for a customer.
   */
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByCustomer is ArmResourceActionSync<
    Customer,
    void,
    ArmResponse<BillingPermissionListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Provides a list of check access response objects for a customer.
   */
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByCustomer is ArmResourceActionSync<
    Customer,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * The list of billing requests submitted for the customer.
   */
  @tag("BillingRequest")
  @list
  @get
  @action("billingRequests")
  billingRequestsListByCustomer is ArmResourceActionSync<
    Customer,
    void,
    ArmResponse<BillingRequestListResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = DefaultODataParameters
  >;

  /**
   * Adds a role assignment on a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleAssignment")
  @action("createBillingRoleAssignment")
  createByCustomer is ArmResourceActionAsync<
    Customer,
    BillingRoleAssignmentProperties,
    BillingRoleAssignment,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the role assignments for the caller on a customer while fetching user info for each role assignment. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleAssignment")
  @action("resolveBillingRoleAssignments")
  resolveByCustomer is ArmResourceActionAsync<
    Customer,
    void,
    BillingRoleAssignmentListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingRoleAssignmentsResolveByCustomerParameters
  >;

  /**
   * Lists the subscriptions for a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByCustomer is ArmResourceActionSync<
    Customer,
    void,
    BillingSubscriptionListResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = BillingSubscriptionsListParameters
  >;

  /**
   * Lists the billed or unbilled transactions by customer id for given start date and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
  @tag("Transaction")
  @list
  @get
  @action("transactions")
  transactionsListByCustomer is ArmResourceActionSync<
    Customer,
    void,
    TransactionListResult,
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

alias CustomerOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  "BillingCustomer"
>;

// TODO: @removed() to deprecate billing account scope operations. 2026 GA. Excluding Products.
@armResourceOperations(#{ omitTags: true })
interface CustomerOperationGroup {
  /**
   * Gets a customer by its ID at billing account level. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Customer")
  getByBillingAccount is CustomerOperationGroupOps.Read<Customer>;

  /**
   * Lists the customers that are billed to a billing account. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Customer")
  listByBillingAccount is CustomerOperationGroupOps.List<
    Customer,
    Parameters = {
      ...CustomersListParametersWithExpand;
    },
    Response = ArmResponse<CustomerListResult>
  >;

  /**
   * Lists the billing permissions the caller has for a customer at billing account level.
   */
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByCustomerAtBillingAccount is CustomerOperationGroupOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingPermissionListResult>
  >;

  /**
   * Lists the subscriptions for a customer at billing account level. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByCustomerAtBillingAccount is CustomerOperationGroupOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListParameters
  >;

  /**
   * Lists the products for a customer. These don't include products billed based on usage.The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Product")
  @list
  @get
  @action("products")
  listByCustomer is CustomerOperationGroupOps.ActionSync<
    Customer,
    void,
    ArmResponse<ProductListResult>,
    Parameters = {
      ...DefaultODataParameters;
    }
  >;
}

alias BillingRoleAssignmentsResolveByCustomerParameters = {
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

alias BillingSubscriptionsListParameters = {
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

alias CustomersListParametersWithExpand = {
  /**
   * May be used to expand enabledAzurePlans and resellers
   */
  @query("expand")
  expand?: string;

  ...DefaultODataParameters;
};

alias CustomerNameParameter = {
  /** The ID that uniquely identifies a customer. */
  @path
  @segment("customers")
  @key
  @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
  customerName: string;
};

@@doc(Customer.name, "The ID that uniquely identifies a customer.");
@@doc(Customer.properties, "A partner's customer.");
@@doc(
  Customers.checkAccessByCustomer::parameters.body,
  "The request object against which access of the caller will be checked."
);
@@doc(
  Customers.createByCustomer::parameters.body,
  "The properties of the billing role assignment."
);
