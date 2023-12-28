import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("Lab Plans act as a permission container for creating labs via labs.azure.com. Additionally, they can provide a set of default configurations that will apply at the time of creating a lab, but these defaults can still be overwritten.")
model LabPlan is TrackedResource<LabPlanProperties> {
  @doc("The name of the lab plan that uniquely identifies it within containing resource group. Used in resource URIs and in UI.")
  @maxLength(100)
  @minLength(1)
  @key("labPlanName")
  @segment("labPlans")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface LabPlans {
  @doc("Retrieves the properties of a Lab Plan.")
  get is ArmResourceRead<LabPlan>;
  @doc("Operation to create or update a Lab Plan resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LabPlan>;
  @doc("Operation to update a Lab Plan resource.")
  update is ArmCustomPatchAsync<LabPlan, LabPlanUpdate>;
  @doc("Operation to delete a Lab Plan resource. Deleting a lab plan does not delete labs associated with a lab plan, nor does it delete shared images added to a gallery via the lab plan permission container.")
  delete is ArmResourceDeleteAsync<LabPlan>;
  @doc("Returns a list of all lab plans for a subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<LabPlan>;
  @doc("Returns a list of all lab plans within a subscription")
  listBySubscription is ArmListBySubscription<LabPlan>;
  @doc("Saves an image from a lab VM to the attached shared image gallery.")
  saveImage is ArmResourceActionAsync<LabPlan, SaveImageBody, void>;
}
