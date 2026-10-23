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
 * A partner's customer.
 */
@tenantResource
@parentResource(BillingProfile)
model Customer is Azure.ResourceManager.ProxyResource<CustomerProperties> {
  ...ResourceNameParameter<
    Resource = Customer,
    KeyName = "customerName",
    SegmentName = "customers",
    NamePattern = "^[a-zA-Z\\d-_]{1,128}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias CustomerOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    billingProfileName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    customerName: string;
  },
  "BillingProfileCustomer"
>;

alias CustomerNoPatternOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    customerName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Customers {
  /**
   * Gets a customer by its ID. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Customer")
  get is CustomerOps.Read<Customer>;

  /**
   * Lists the customers that are billed to a billing profile. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Customer")
  listByBillingProfile is CustomerOps.List<
    Customer,
    Parameters = {
      /**
       * May be used to expand enabledAzurePlans and resellers
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.expand retains the expand query parameter; preserve wire compatibility."
      @query("expand")
      expand?: string;

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing listByBillingProfile.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingProfile.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    },
    Response = ArmResponse<CustomerListResult>
  >;

  /**
   * Lists the billing permissions the caller has for a customer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByCustomer is CustomerOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingPermissionListResult>
  >;

  /**
   * Provides a list of check access response objects for a customer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByCustomer is CustomerOps.ActionSync<
    Customer,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>
  >;

  /**
   * The list of billing requests submitted for the customer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRequest")
  @list
  @get
  @action("billingRequests")
  billingRequestsListByCustomer is CustomerOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingRequestListResult>,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing billingRequestsListByCustomer.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingRequestsListByCustomer.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;

  /**
   * Adds a role assignment on a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("createBillingRoleAssignment")
  createByCustomer is CustomerOps.ActionAsync<
    Customer,
    BillingRoleAssignmentProperties,
    BillingRoleAssignment
  >;

  /**
   * Lists the role assignments for the caller on a customer while fetching user info for each role assignment. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleAssignment")
  @action("resolveBillingRoleAssignments")
  resolveByCustomer is CustomerOps.ActionAsync<
    Customer,
    void,
    BillingRoleAssignmentListResult,
    Parameters = BillingRoleAssignmentsResolveByCustomerParameters
  >;

  /**
   * Lists the subscriptions for a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByCustomer is CustomerNoPatternOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListByCustomerParameters
  >;

  /**
   * Updates the policies for a customer. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-tenant-level-apis" "Existing createOrUpdateByCustomer retains its tenant-scoped route; preserve published resource IDs and API paths."
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Policy")
  @put
  @action("policies/default")
  createOrUpdateByCustomer is CustomerOps.ActionAsync<
    Customer,
    CustomerPolicy,
    CustomerPolicy,
    Response =
      | ArmResourceCreatedResponse<
          CustomerPolicy,
          ArmLroLocationHeader<FinalResult = CustomerPolicy> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmResponse<CustomerPolicy>
  >;

  /**
   * Lists the billed or unbilled transactions by customer id for given start date and end date. Transactions include purchases, refunds and Azure usage charges. Unbilled transactions are listed under pending invoice Id and do not include tax. Tax is added to the amount once an invoice is generated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Transaction")
  @list
  @get
  @action("transactions")
  transactionsListByCustomer is CustomerOps.ActionSync<
    Customer,
    void,
    ArmResponse<TransactionListResult>,
    Parameters = {
      /**
       * The start date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.periodStartDate retains the periodStartDate query parameter; preserve wire compatibility."
      @query("periodStartDate")
      periodStartDate: plainDate;

      /**
       * The end date to fetch the transactions. The date should be specified in MM-DD-YYYY format.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.periodEndDate retains the periodEndDate query parameter; preserve wire compatibility."
      @query("periodEndDate")
      periodEndDate: plainDate;

      /**
       * The type of transaction.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.type retains the type query parameter; preserve wire compatibility."
      @query("type")
      type: TransactionType;

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing transactionsListByCustomer.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing transactionsListByCustomer.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    customerName: string;
  },
  "BillingCustomer"
>;

alias CustomerOperationGroupNoPatternOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    customerName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface CustomerOperationGroup {
  /**
   * Gets a customer by its ID at billing account level. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Customer")
  getByBillingAccount is CustomerOperationGroupOps.Read<Customer>;

  /**
   * Lists the customers that are billed to a billing account. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Customer")
  listByBillingAccount is CustomerOperationGroupOps.List<
    Customer,
    Parameters = {
      /**
       * May be used to expand enabledAzurePlans and resellers
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.expand retains the expand query parameter; preserve wire compatibility."
      @query("expand")
      expand?: string;

      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing listByBillingAccount.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByBillingAccount.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    },
    Response = ArmResponse<CustomerListResult>
  >;

  /**
   * Lists the billing permissions the caller has for a customer at billing account level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByCustomerAtBillingAccount is CustomerOperationGroupNoPatternOps.ActionSync<
    Customer,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = BillingSubscriptionsListByCustomerAtBillingAccountParameters
  >;

  /**
   * Lists the products for a customer. These don't include products billed based on usage.The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Product")
  @list
  @get
  @action("products")
  listByCustomer is CustomerOperationGroupOps.ActionSync<
    Customer,
    void,
    ArmResponse<ProductListResult>,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing listByCustomer.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByCustomer.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;
}

alias BillingRoleAssignmentsResolveByCustomerParameters = {
  /**
   * Resolves the scope display name for each of the role assignments.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-post" "Existing POST contracts using BillingRoleAssignmentsResolveByCustomerParameters.resolveScopeDisplayNames retain the resolveScopeDisplayNames query parameter for wire compatibility."
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing BillingRoleAssignmentsResolveByCustomerParameters.resolveScopeDisplayNames has a boolean wire value; preserve the published property contract."
  @query("resolveScopeDisplayNames")
  resolveScopeDisplayNames?: boolean = false;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-post" "Existing POST contracts using BillingRoleAssignmentsResolveByCustomerParameters.filter retain the filter query parameter for wire compatibility."
  @query("filter")
  filter?: string;
};

alias BillingSubscriptionsListByCustomerParameters = {
  /**
   * Can be used to get deleted billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing BillingSubscriptionsListByCustomerParameters.includeDeleted has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.includeDeleted retains the includeDeleted query parameter; preserve wire compatibility."
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.expand retains the expand query parameter; preserve wire compatibility."
  @query("expand")
  expand?: string;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.filter retains the filter query parameter; preserve wire compatibility."
  @query("filter")
  filter?: string;

  /**
   * The orderby query option allows clients to request resources in a particular order.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.orderBy retains the orderBy query parameter; preserve wire compatibility."
  @query("orderBy")
  orderBy?: string;

  /**
   * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.top retains the top query parameter; preserve wire compatibility."
  @query("top")
  top?: int64;

  /**
   * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.skip retains the skip query parameter; preserve wire compatibility."
  @query("skip")
  skip?: int64;

  /**
   * The count query option allows clients to request a count of the matching resources included with the resources in the response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing BillingSubscriptionsListByCustomerParameters.count has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.count retains the count query parameter; preserve wire compatibility."
  @query("count")
  count?: boolean;

  /**
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerParameters.search retains the search query parameter; preserve wire compatibility."
  @query("search")
  search?: string;
};

alias BillingSubscriptionsListByCustomerAtBillingAccountParameters = {
  /**
   * Can be used to get deleted billing subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.includeDeleted has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.includeDeleted retains the includeDeleted query parameter; preserve wire compatibility."
  @query("includeDeleted")
  includeDeleted?: boolean = false;

  /**
   * Can be used to expand `Reseller`, `ConsumptionCostCenter`, `LastMonthCharges` and `MonthToDateCharges`
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.expand retains the expand query parameter; preserve wire compatibility."
  @query("expand")
  expand?: string;

  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.filter retains the filter query parameter; preserve wire compatibility."
  @query("filter")
  filter?: string;

  /**
   * The orderby query option allows clients to request resources in a particular order.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.orderBy retains the orderBy query parameter; preserve wire compatibility."
  @query("orderBy")
  orderBy?: string;

  /**
   * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.top retains the top query parameter; preserve wire compatibility."
  @query("top")
  top?: int64;

  /**
   * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.skip retains the skip query parameter; preserve wire compatibility."
  @query("skip")
  skip?: int64;

  /**
   * The count query option allows clients to request a count of the matching resources included with the resources in the response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.count has a boolean wire value; preserve the published property contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.count retains the count query parameter; preserve wire compatibility."
  @query("count")
  count?: boolean;

  /**
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing BillingSubscriptionsListByCustomerAtBillingAccountParameters.search retains the search query parameter; preserve wire compatibility."
  @query("search")
  search?: string;
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
@@doc(
  Customers.createOrUpdateByCustomer::parameters.body,
  "A policy at customer scope."
);
