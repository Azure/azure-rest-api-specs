import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Lab Plans act as a permission container for creating labs via labs.azure.com. Additionally, they can provide a set of default configurations that will apply at the time of creating a lab, but these defaults can still be overwritten.
 */
model LabPlan is TrackedResource<LabPlanProperties> {
  /**
   * The name of the lab plan that uniquely identifies it within containing resource group. Used in resource URIs and in UI.
   */
  @maxLength(100)
  @minLength(1)
  @path
  @key("labPlanName")
  @segment("labPlans")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LabPlan>;

  /**
   * Operation to update a Lab Plan resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    LabPlan,
    LabPlanUpdate,
    BaseParameters<LabPlan>,
    ArmLroLocationHeader
  >;

  /**
   * Operation to delete a Lab Plan resource. Deleting a lab plan does not delete labs associated with a lab plan, nor does it delete shared images added to a gallery via the lab plan permission container.
   */
  delete is ArmResourceDeleteAsync<
    LabPlan,
    BaseParameters<LabPlan>,
    ArmLroLocationHeader
  >;

  /**
   * Returns a list of all lab plans for a subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LabPlans_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LabPlan>;

  /**
   * Returns a list of all lab plans within a subscription
   */
  listBySubscription is ArmListBySubscription<LabPlan>;

  /**
   * Saves an image from a lab VM to the attached shared image gallery.
   */
  saveImage is ArmResourceActionAsync<
    LabPlan,
    SaveImageBody,
    void,
    BaseParameters<LabPlan>,
    ArmLroLocationHeader
  >;
}

@@projectedName(LabPlans.createOrUpdate::parameters.resource, "json", "body");
@@extension(LabPlans.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(LabPlans.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(LabPlans.update::parameters.properties, "json", "body");
@@extension(LabPlans.update::parameters.properties, "x-ms-client-name", "body");
@@doc(LabPlans.update::parameters.properties, "The request body.");
@@doc(LabPlans.saveImage::parameters.body, "The request body.");
