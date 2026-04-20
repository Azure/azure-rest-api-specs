import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

alias billingAccountExternalResource = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "{billingAccountName}"
>;

@armResourceOperations
interface Labs {
  /**
   * Get the details for a specific lab associated with the provided billing account name, billing profile name, and invoice section name.
   */
  get is ArmResourceRead<
    LabDetails,
    Parameters = {
      /**
       * May be used to include budget information.
       */
      @query("includeBudget")
      includeBudget?: boolean;
    }
  >;

  /**
   * Create a new lab or update a previously created lab.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabDetails>;

  /**
   * Delete a specific lab associated with the provided billing account name, billing profile name, and invoice section name. Note all students must be removed from the lab in order to delete the lab.
   */
  delete is ArmResourceDeleteSync<LabDetails>;

  /**
   * Get a list of labs associated with the provided billing account name and billing profile name.
   */
  listAll is ArmResourceListByParent<
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
    }
  >;

  /**
   * Generate invite code for a lab
   */
  generateInviteCode is ArmResourceActionSync<
    LabDetails,
    InviteCodeGenerateRequest,
    ArmResponse<LabDetails>,
    Parameters = {
      /**
       * set this flag to true if you want to update student count without generating a new invite code
       */
      @query("onlyUpdateStudentCountParameter")
      onlyUpdateStudentCountParameter?: boolean;
    }
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
