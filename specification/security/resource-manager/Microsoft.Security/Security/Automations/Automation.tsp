import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace AutomationsAPI;
/**
 * The security automation resource.
 */
model Automation is Azure.ResourceManager.ProxyResource<AutomationProperties> {
  ...ResourceNameParameter<
    Resource = Automation,
    KeyName = "automationName",
    SegmentName = "automations",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface Automations {
  /**
   * Retrieves information about the model of a security automation.
   */
  get is ArmResourceRead<Automation, Error = CloudError>;

  /**
   * Creates or updates a security automation. If a security automation is already created and a subsequent request is issued for the same automation id, then it will be updated.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Automation,
    Error = CloudError
  >;

  /**
   * Updates a security automation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Automation,
    PatchModel = AutomationUpdateModel,
    Error = CloudError
  >;

  /**
   * Deletes a security automation.
   */
  delete is ArmResourceDeleteSync<Automation, Error = CloudError>;

  /**
   * Lists all the security automations in the specified resource group. Use the 'nextLink' property in the response to get the next page of security automations for the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Automation,
    Response = ArmResponse<AutomationList>,
    Error = CloudError
  >;

  /**
   * Lists all the security automations in the specified subscription. Use the 'nextLink' property in the response to get the next page of security automations for the specified subscription.
   */
  list is ArmListBySubscription<
    Automation,
    Response = ArmResponse<AutomationList>,
    Error = CloudError
  >;

  /**
   * Validates the security automation model before create or update. Any validation errors are returned to the client.
   */
  validate is ArmResourceActionSync<
    Automation,
    Automation,
    ArmResponse<AutomationValidationStatus>,
    Error = CloudError
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
@@visibility(Automation.location,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);



