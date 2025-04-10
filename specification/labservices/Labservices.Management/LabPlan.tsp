import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Lab Plans act as a permission container for creating labs via labs.azure.com. Additionally, they can provide a set of default configurations that will apply at the time of creating a lab, but these defaults can still be overwritten.
 */
model LabPlan
  is Azure.ResourceManager.TrackedResource<LabPlanProperties, false> {
  ...ResourceNameParameter<
    Resource = LabPlan,
    KeyName = "labPlanName",
    SegmentName = "labPlans",
    NamePattern = ""
  >;

  /**
   * Managed Identity Information
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface LabPlans {
  /**
   * Retrieves the properties of a Lab Plan.
   */
  get is ArmResourceRead<LabPlan>;

  /**
   * Operation to create or update a Lab Plan resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LabPlan,
    Response = ArmResourceUpdatedResponse<LabPlan> | ArmResourceCreatedResponse<LabPlan> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: LabPlan;
    })
  >;

  /**
   * Operation to update a Lab Plan resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    LabPlan,
    PatchModel = LabPlanUpdate,
    Response = ArmResponse<LabPlan> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: LabPlan;
    })
  >;

  /**
   * Operation to delete a Lab Plan resource. Deleting a lab plan does not delete labs associated with a lab plan, nor does it delete shared images added to a gallery via the lab plan permission container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    LabPlan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of all lab plans for a subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    LabPlan,
    Response = ArmResponse<PagedLabPlans>
  >;

  /**
   * Returns a list of all lab plans within a subscription
   */
  listBySubscription is ArmListBySubscription<
    LabPlan,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedLabPlans>
  >;

  /**
   * Saves an image from a lab VM to the attached shared image gallery.
   */
  saveImage is ArmResourceActionAsync<LabPlan, SaveImageBody, OkResponse>;
}

@@maxLength(LabPlan.name, 100);
@@minLength(LabPlan.name, 1);
@@doc(LabPlan.name,
  "The name of the lab plan that uniquely identifies it within containing resource group. Used in resource URIs and in UI."
);
@@doc(LabPlan.properties, "Lab plan resource properties");
@@doc(LabPlans.createOrUpdate::parameters.resource, "The request body.");
@@doc(LabPlans.update::parameters.properties, "The request body.");
@@doc(LabPlans.saveImage::parameters.body, "The request body.");
