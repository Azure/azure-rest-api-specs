import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * The properties of the billing role assignment.
 */
@tenantResource
@parentResource(BillingProfile)
model BillingRoleAssignment
  is Azure.ResourceManager.ProxyResource<BillingRoleAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = BillingRoleAssignment,
    KeyName = "billingRoleAssignmentName",
    SegmentName = "billingRoleAssignments",
    NamePattern = BillingRoleAssignmentPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias BillingRoleAssignmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingProfileRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignments {
  /**
   * Gets a role assignment for the caller on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  getByBillingProfile is BillingRoleAssignmentOps.Read<BillingRoleAssignment>;

  /**
   * Deletes a role assignment on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByBillingProfile is BillingRoleAssignmentOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  listByBillingProfile is BillingRoleAssignmentOps.List<
    BillingRoleAssignment,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

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
    },
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}
alias BillingRoleAssignmentByCustomerOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingCustomerRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignmentByCustomer {
  /**
   * Gets a role assignment for the caller on a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleAssignment")
  getByCustomer is BillingRoleAssignmentByCustomerOps.Read<BillingRoleAssignment>;

  /**
   * Deletes a role assignment on a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByCustomer is BillingRoleAssignmentByCustomerOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleAssignment")
  listByCustomer is BillingRoleAssignmentByCustomerOps.List<
    BillingRoleAssignment,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

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
    },
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}
alias BillingRoleAssignmentByInvoiceSectionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;

    /** The ID that uniquely identifies an invoice section. */
    @path
    @segment("invoiceSections")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    invoiceSectionName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingInvoiceSectionRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignmentByInvoiceSection {
  /**
   * Gets a role assignment for the caller on an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  getByInvoiceSection is BillingRoleAssignmentByInvoiceSectionOps.Read<BillingRoleAssignment>;

  /**
   * Deletes a role assignment on an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByInvoiceSection is BillingRoleAssignmentByInvoiceSectionOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on an invoice section. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingRoleAssignment")
  listByInvoiceSection is BillingRoleAssignmentByInvoiceSectionOps.List<
    BillingRoleAssignment,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

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
    },
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}
alias BillingRoleAssignmentByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignmentByBillingAccount {
  /**
   * Gets a role assignment for the caller on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  getByBillingAccount is BillingRoleAssignmentByBillingAccountOps.Read<BillingRoleAssignment>;

  /**
   * Create or update a billing role assignment. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  createOrUpdateByBillingAccount is BillingRoleAssignmentByBillingAccountOps.CreateOrUpdateAsync<
    BillingRoleAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingRoleAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a role assignment on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByBillingAccount is BillingRoleAssignmentByBillingAccountOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  listByBillingAccount is BillingRoleAssignmentByBillingAccountOps.List<
    BillingRoleAssignment,
    Parameters = {
      /**
       * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
       */
      @query("filter")
      filter?: string;

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
    },
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}
alias BillingRoleAssignmentByDepartmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingDepartmentRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignmentByDepartment {
  /**
   * Gets a role assignment for the caller on a department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  getByDepartment is BillingRoleAssignmentByDepartmentOps.Read<BillingRoleAssignment>;

  /**
   * Create or update a billing role assignment. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  createOrUpdateByDepartment is BillingRoleAssignmentByDepartmentOps.CreateOrUpdateAsync<
    BillingRoleAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingRoleAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a role assignment on a department. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByDepartment is BillingRoleAssignmentByDepartmentOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on a department. The operation is supported for billing accounts of type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  listByDepartment is BillingRoleAssignmentByDepartmentOps.List<
    BillingRoleAssignment,
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}
alias BillingRoleAssignmentByEnrollmentAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    enrollmentAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role assignment. */
    @path
    @segment("billingRoleAssignments")
    @key
    @pattern(BillingRoleAssignmentPattern)
    billingRoleAssignmentName: string;
  },
  "BillingEnrollmentAccountRoleAssignment"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleAssignmentByEnrollmentAccount {
  /**
   * Gets a role assignment for the caller on a enrollment Account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  getByEnrollmentAccount is BillingRoleAssignmentByEnrollmentAccountOps.Read<BillingRoleAssignment>;

  /**
   * Create or update a billing role assignment. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  createOrUpdateByEnrollmentAccount is BillingRoleAssignmentByEnrollmentAccountOps.CreateOrUpdateAsync<
    BillingRoleAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = BillingRoleAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a role assignment on a enrollment Account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  deleteByEnrollmentAccount is BillingRoleAssignmentByEnrollmentAccountOps.DeleteSync<BillingRoleAssignment>;

  /**
   * Lists the role assignments for the caller on a enrollment account. The operation is supported for billing accounts of type Enterprise Agreement.
   */
  @tag("BillingRoleAssignment")
  listByEnrollmentAccount is BillingRoleAssignmentByEnrollmentAccountOps.List<
    BillingRoleAssignment,
    Response = ArmResponse<BillingRoleAssignmentListResult>
  >;
}

@@doc(
  BillingRoleAssignment.name,
  "The ID that uniquely identifies a role assignment."
);
@@doc(
  BillingRoleAssignment.properties,
  "The properties of the billing role assignment."
);
@@doc(
  BillingRoleAssignmentByBillingAccount.createOrUpdateByBillingAccount::parameters.resource,
  "The properties of the billing role assignment."
);
@@doc(
  BillingRoleAssignmentByDepartment.createOrUpdateByDepartment::parameters.resource,
  "The properties of the billing role assignment."
);
@@doc(
  BillingRoleAssignmentByEnrollmentAccount.createOrUpdateByEnrollmentAccount::parameters.resource,
  "The properties of the billing role assignment."
);
