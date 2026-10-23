import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Department.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * It is an organizational hierarchy within a billing account to administer and manage azure costs.
 */
@tenantResource
@parentResource(Department)
model EnrollmentAccount
  is Azure.ResourceManager.ProxyResource<EnrollmentAccountProperties> {
  ...ResourceNameParameter<
    Resource = EnrollmentAccount,
    KeyName = "enrollmentAccountName",
    SegmentName = "enrollmentAccounts",
    NamePattern = "^[a-zA-Z\\d-_]{1,128}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias EnrollmentAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The name of the department. */
    @path
    @segment("departments")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    departmentName: string;
  },
  {},
  {
    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    enrollmentAccountName: string;
  },
  "BillingDepartmentEnrollmentAccount"
>;

@armResourceOperations(#{ omitTags: true })
interface EnrollmentAccounts {
  /**
   * Gets an enrollment account by department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("EnrollmentAccount")
  getByDepartment is EnrollmentAccountOps.Read<EnrollmentAccount>;

  /**
   * Lists the enrollment accounts for a department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("EnrollmentAccount")
  listByDepartment is EnrollmentAccountOps.List<
    EnrollmentAccount,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing listByDepartment.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByDepartment.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    },
    Response = ArmResponse<EnrollmentAccountListResult>
  >;
}

alias EnrollmentAccountOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    enrollmentAccountName: string;
  },
  "BillingEnrollmentAccount"
>;

alias EnrollmentAccountOperationGroupNoPatternOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    enrollmentAccountName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface EnrollmentAccountOperationGroup {
  /**
   * Gets an enrollment account by ID. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("EnrollmentAccount")
  get is EnrollmentAccountOperationGroupOps.Read<EnrollmentAccount>;

  /**
   * Lists the enrollment accounts for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("EnrollmentAccount")
  listByBillingAccount is EnrollmentAccountOperationGroupOps.List<
    EnrollmentAccount,
    Parameters = {
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
    Response = ArmResponse<EnrollmentAccountListResult>
  >;

  /**
   * Lists the billing permissions the caller has for an enrollment account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @list
  @get
  @action("billingPermissions")
  listByEnrollmentAccount is EnrollmentAccountOperationGroupOps.ActionSync<
    EnrollmentAccount,
    void,
    ArmResponse<BillingPermissionListResult>
  >;

  /**
   * Provides a list of check access response objects for an enrollment account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingPermission")
  @action("checkAccess")
  checkAccessByEnrollmentAccount is EnrollmentAccountOperationGroupOps.ActionSync<
    EnrollmentAccount,
    CheckAccessRequest,
    ArmResponse<CheckAccessResponse[]>
  >;

  /**
   * Lists the subscriptions for an enrollment account. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByEnrollmentAccount is EnrollmentAccountOperationGroupNoPatternOps.ActionSync<
    EnrollmentAccount,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * The orderby query option allows clients to request resources in a particular order.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.orderBy retains the orderBy query parameter; preserve wire compatibility."
      @query("orderBy")
      orderBy?: string;

      /**
       * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int64;

      /**
       * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.skip retains the skip query parameter; preserve wire compatibility."
      @query("skip")
      skip?: int64;

      /**
       * The count query option allows clients to request a count of the matching resources included with the resources in the response.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing billingSubscriptionsListByEnrollmentAccount.count has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.count retains the count query parameter; preserve wire compatibility."
      @query("count")
      count?: boolean;

      /**
       * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing billingSubscriptionsListByEnrollmentAccount.search retains the search query parameter; preserve wire compatibility."
      @query("search")
      search?: string;
    }
  >;
}

@@doc(EnrollmentAccount.name, "The name of the enrollment account.");
@@doc(
  EnrollmentAccount.properties,
  "It is an organizational hierarchy within a billing account to administer and manage azure costs."
);
@@doc(
  EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount::parameters.body,
  "The request object against which access of the caller will be checked."
);
