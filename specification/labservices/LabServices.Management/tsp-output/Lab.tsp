import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("The lab resource.")
model Lab is TrackedResource<LabProperties> {
  @doc("The name of the lab that uniquely identifies it within containing lab plan. Used in resource URIs.")
  @maxLength(100)
  @minLength(1)
  @key("labName")
  @segment("labs")
  name: string;
}

@armResourceOperations
interface Labs {
  @doc("Returns the properties of a lab resource.")
  get is ArmResourceRead<Lab>;
  @doc("Operation to create or update a lab resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Lab>;
  @doc("Operation to update a lab resource.")
  update is ArmCustomPatchAsync<Lab, LabUpdate>;
  @doc("Operation to delete a lab resource.")
  delete is ArmResourceDeleteAsync<Lab>;
  @doc("Returns a list of all labs in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Lab>;
  @doc("Returns a list of all labs for a subscription.")
  listBySubscription is ArmListBySubscription<Lab>;
  @doc("Publish or re-publish a lab. This will create or update all lab resources, such as virtual machines.")
  publish is ArmResourceActionAsync<Lab, void, void>;
  @doc("Action used to manually kick off an AAD group sync job.")
  syncGroup is ArmResourceActionAsync<Lab, void, void>;
}
