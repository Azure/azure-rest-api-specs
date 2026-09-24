import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingProfile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * The properties of a role definition.
 */
@tenantResource
@parentResource(BillingProfile)
model BillingRoleDefinition
  is Azure.ResourceManager.ProxyResource<BillingRoleDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = BillingRoleDefinition,
    KeyName = "roleDefinitionName",
    SegmentName = "billingRoleDefinitions",
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias BillingRoleDefinitionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingProfileRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitions {
  /**
   * Gets the definition for a role on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingRoleDefinition")
  getByBillingProfile is BillingRoleDefinitionOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  listByBillingProfile is BillingRoleDefinitionOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}
alias BillingRoleDefinitionByCustomerOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingCustomerRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByCustomer {
  /**
   * Gets the definition for a role on a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleDefinition")
  getByCustomer is BillingRoleDefinitionByCustomerOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("BillingRoleDefinition")
  listByCustomer is BillingRoleDefinitionByCustomerOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}
alias BillingRoleDefinitionByInvoiceSectionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingInvoiceSectionRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByInvoiceSection {
  /**
   * Gets the definition for a role on an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("BillingRoleDefinition")
  getByInvoiceSection is BillingRoleDefinitionByInvoiceSectionOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for an invoice section. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("BillingRoleDefinition")
  listByInvoiceSection is BillingRoleDefinitionByInvoiceSectionOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}
alias BillingRoleDefinitionByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByBillingAccount {
  /**
   * Gets the definition for a role on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  getByBillingAccount is BillingRoleDefinitionByBillingAccountOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  listByBillingAccount is BillingRoleDefinitionByBillingAccountOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}
alias BillingRoleDefinitionByDepartmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingDepartmentRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByDepartment {
  /**
   * Gets the definition for a role on a department. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  getByDepartment is BillingRoleDefinitionByDepartmentOps.Read<BillingRoleDefinition>;

  /**
   * List the definition for a department. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  listByDepartment is BillingRoleDefinitionByDepartmentOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}
alias BillingRoleDefinitionByEnrollmentAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern(GuidPattern)
    roleDefinitionName: string;
  },
  "BillingEnrollmentAccountRoleDefinition"
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByEnrollmentAccount {
  /**
   * Gets the definition for a role on an enrollment account. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  getByEnrollmentAccount is BillingRoleDefinitionByEnrollmentAccountOps.Read<BillingRoleDefinition>;

  /**
   * List the definition for an enrollment account. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("BillingRoleDefinition")
  listByEnrollmentAccount is BillingRoleDefinitionByEnrollmentAccountOps.List<
    BillingRoleDefinition,
    Response = ArmResponse<BillingRoleDefinitionListResult>
  >;
}

@@doc(
  BillingRoleDefinition.name,
  "The ID that uniquely identifies a role definition."
);
@@doc(BillingRoleDefinition.properties, "The properties of a role definition.");
