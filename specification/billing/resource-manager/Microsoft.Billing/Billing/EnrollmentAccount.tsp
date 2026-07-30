import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Department.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
    NamePattern = BillingProfileCustomerInvoiceSectionNamePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
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
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The name of the department. */
    @path
    @segment("departments")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    departmentName: string;
  },
  {},
  {
    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    enrollmentAccountName: string;
  },
  "BillingDepartmentEnrollmentAccount"
>;

@armResourceOperations(#{ omitTags: true })
interface EnrollmentAccounts {
  /**
   * Gets an enrollment account by department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("EnrollmentAccount")
  getByDepartment is EnrollmentAccountOps.Read<EnrollmentAccount>;

  /**
   * Lists the enrollment accounts for a department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("EnrollmentAccount")
  listByDepartment is EnrollmentAccountOps.List<
    EnrollmentAccount,
    Parameters = {
      ...DefaultODataParameters;
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
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {
    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    enrollmentAccountName: string;
  },
  "BillingEnrollmentAccount"
>;

@armResourceOperations(#{ omitTags: true })
interface EnrollmentAccountOperationGroup {
  /**
   * Gets an enrollment account by ID. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("EnrollmentAccount")
  get is EnrollmentAccountOperationGroupOps.Read<EnrollmentAccount>;

  /**
   * Lists the enrollment accounts for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("EnrollmentAccount")
  listByBillingAccount is EnrollmentAccountOperationGroupOps.List<
    EnrollmentAccount,
    Parameters = {
      ...DefaultODataParameters;
    },
    Response = ArmResponse<EnrollmentAccountListResult>
  >;

  /**
   * Lists the billing permissions the caller has for an enrollment account.
   */
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
  @tag("BillingSubscription")
  @list
  @get
  @action("billingSubscriptions")
  billingSubscriptionsListByEnrollmentAccount is EnrollmentAccountOperationGroupOps.ActionSync<
    EnrollmentAccount,
    void,
    ArmResponse<BillingSubscriptionListResult>,
    Parameters = {
      ...DefaultODataParameters;
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
