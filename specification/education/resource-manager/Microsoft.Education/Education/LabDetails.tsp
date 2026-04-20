import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Education;
/**
 * Lab details.
 */
@singleton("default")
model LabDetails is Azure.ResourceManager.ProxyResource<LabProperties> {
  ...ResourceNameParameter<
    Resource = LabDetails,
    KeyName = "lab",
    SegmentName = "labs",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing billing invoice-section Labs_List path for backward compatibility."
alias InvoiceSectionLabOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The billing provider namespace. */
    @path
    @segment("providers")
    @key
    billingProviderNamespace: "Microsoft.Billing";

    /** The name of the billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;

    /** The name of the billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;

    /** The name of the invoice section. */
    @path
    @segment("invoiceSections")
    @key
    invoiceSectionName: string;

    ...Legacy.Provider;
  },
  {},
  {
    /** The lab name. */
    @path
    @segment("labs")
    @key
    lab: "default";
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing billing-profile Labs_ListAll path for backward compatibility."
alias BillingProfileLabOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The billing provider namespace. */
    @path
    @segment("providers")
    @key
    billingProviderNamespace: "Microsoft.Billing";

    /** The name of the billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;

    /** The name of the billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;

    ...Legacy.Provider;
  },
  {},
  {
    /** The lab name. */
    @path
    @segment("labs")
    @key
    lab: "default";
  }
>;

@armResourceOperations
interface Labs {
  /**
   * Get the details for a specific lab associated with the provided billing account name, billing profile name, and invoice section name.
   */
  get is InvoiceSectionLabOps.Read<
    LabDetails,
    Parameters = {
      /**
       * May be used to include budget information.
       */
      @query("includeBudget")
      includeBudget?: boolean;
    },
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Create a new lab or update a previously created lab.
   */
  createOrUpdate is InvoiceSectionLabOps.CreateOrUpdateSync<
    LabDetails,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a specific lab associated with the provided billing account name, billing profile name, and invoice section name. Note all students must be removed from the lab in order to delete the lab.
   */
  delete is InvoiceSectionLabOps.DeleteSync<
    LabDetails,
    ErrorType = DeleteErrorResponse
  >;

  /**
   * Get the details for a specific lab associated with the provided billing account name, billing profile name, and invoice section name.
   */
  list is InvoiceSectionLabOps.List<
    LabDetails,
    Parameters = {
      /**
       * May be used to include budget information.
       */
      @query("includeBudget")
      includeBudget?: boolean;
    },
    Response = ArmResponse<LabListResult>,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Get a list of labs associated with the provided billing account name and billing profile name.
   */
  listAll is BillingProfileLabOps.List<
    LabDetails,
    Parameters = {
      /**
       * May be used to include budget information.
       */
      @query("includeBudget")
      includeBudget?: boolean;

      /**
       * May be used to show deleted items.
       */
      @query("includeDeleted")
      includeDeleted?: boolean;
    },
    Response = ArmResponse<LabListResult>,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Generate invite code for a lab
   */
  @action("generateInviteCode")
  generateInviteCode is InvoiceSectionLabOps.ActionSync<
    LabDetails,
    InviteCodeGenerateRequest,
    ArmResponse<LabDetails>,
    Parameters = {
      /**
       * set this flag to true if you want to update student count without generating a new invite code
       */
      @query("onlyUpdateStudentCountParameter")
      onlyUpdateStudentCountParameter?: boolean;
    },
    ErrorType = DefaultErrorResponse
  >;
}

@@doc(LabDetails.name, "");
@@doc(LabDetails.properties, "Get lab response properties.");
@@doc(Labs.createOrUpdate::parameters.resource,
  "Request parameters that are provided to create lab resource."
);
@@doc(Labs.generateInviteCode::parameters.body,
  "Request parameters that are provided to generate invite code."
);
