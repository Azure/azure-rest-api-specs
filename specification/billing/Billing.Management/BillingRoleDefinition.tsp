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
    NamePattern = "^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitions {
  /**
   * Gets the definition for a role on a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByBillingProfile is BillingRoleDefinitionOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a billing profile. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByBillingProfile is BillingRoleDefinitionOps.List<BillingRoleDefinition>;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    billingProfileName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    customerName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByCustomer {
  /**
   * Gets the definition for a role on a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByCustomer is BillingRoleDefinitionByCustomerOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a customer. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByCustomer is BillingRoleDefinitionByCustomerOps.List<BillingRoleDefinition>;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    billingProfileName: string;

    /** The ID that uniquely identifies an invoice section. */
    @path
    @segment("invoiceSections")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    invoiceSectionName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByInvoiceSection {
  /**
   * Gets the definition for a role on an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByInvoiceSection is BillingRoleDefinitionByInvoiceSectionOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for an invoice section. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByInvoiceSection is BillingRoleDefinitionByInvoiceSectionOps.List<BillingRoleDefinition>;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByBillingAccount {
  /**
   * Gets the definition for a role on a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByBillingAccount is BillingRoleDefinitionByBillingAccountOps.Read<BillingRoleDefinition>;

  /**
   * Lists the role definitions for a billing account. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByBillingAccount is BillingRoleDefinitionByBillingAccountOps.List<BillingRoleDefinition>;
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
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByDepartment {
  /**
   * Gets the definition for a role on a department. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByDepartment is BillingRoleDefinitionByDepartmentOps.Read<BillingRoleDefinition>;

  /**
   * List the definition for a department. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByDepartment is BillingRoleDefinitionByDepartmentOps.List<BillingRoleDefinition>;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The name of the enrollment account. */
    @path
    @segment("enrollmentAccounts")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    enrollmentAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a role definition. */
    @path
    @segment("billingRoleDefinitions")
    @key
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    roleDefinitionName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface BillingRoleDefinitionByEnrollmentAccount {
  /**
   * Gets the definition for a role on an enrollment account. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  getByEnrollmentAccount is BillingRoleDefinitionByEnrollmentAccountOps.Read<BillingRoleDefinition>;

  /**
   * List the definition for an enrollment account. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingRoleDefinition")
  listByEnrollmentAccount is BillingRoleDefinitionByEnrollmentAccountOps.List<BillingRoleDefinition>;
}

@@doc(BillingRoleDefinition.name,
  "The ID that uniquely identifies a role definition."
);
@@doc(BillingRoleDefinition.properties, "The properties of a role definition.");
