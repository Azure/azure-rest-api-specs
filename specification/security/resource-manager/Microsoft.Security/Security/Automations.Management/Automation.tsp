import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The security automation resource.
 */
model Automation
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<AutomationProperties> {
  ...ResourceNameParameter<
    Resource = Automation,
    KeyName = "automationName",
    SegmentName = "automations",
    NamePattern = ""
  >;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Automations {
  /**
   * Retrieves information about the model of a security automation.
   */
  get is ArmResourceRead<Automation>;

  /**
   * Creates or updates a security automation. If a security automation is already created and a subsequent request is issued for the same automation id, then it will be updated.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Automation>;

  /**
   * Updates a security automation
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Automation, PatchModel = AutomationUpdateModel>;

  /**
   * Deletes a security automation.
   */
  delete is ArmResourceDeleteSync<Automation>;

  /**
   * Lists all the security automations in the specified resource group. Use the 'nextLink' property in the response to get the next page of security automations for the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Automation,
    Response = ArmResponse<AutomationList>
  >;

  /**
   * Lists all the security automations in the specified subscription. Use the 'nextLink' property in the response to get the next page of security automations for the specified subscription.
   */
  list is ArmListBySubscription<
    Automation,
    Response = ArmResponse<AutomationList>
  >;

  /**
   * Validates the security automation model before create or update. Any validation errors are returned to the client.
   */
  validate is ArmResourceActionSync<
    Automation,
    Automation,
    ArmResponse<AutomationValidationStatus>
  >;
}

@@doc(Automation.name, "The security automation name.");
@@doc(Automation.properties, "Security automation data");
@@doc(Automations.createOrUpdate::parameters.resource,
  "The security automation resource"
);
@@doc(Automations.update::parameters.properties,
  "The update model of security automation resource"
);
@@doc(Automations.validate::parameters.body,
  "The security automation resource"
);
