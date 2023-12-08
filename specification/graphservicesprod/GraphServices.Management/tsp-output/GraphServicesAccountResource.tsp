import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.GraphServices;
@doc("Account details")
model GraphServicesAccountResource
  is TrackedResource<AccountResourceProperties> {
  @doc("The name of the resource.")
  @path
  @key("resourceName")
  @segment("accounts")
  name: string;
}

@armResourceOperations
interface GraphServicesAccountResources {
  @doc("Returns account resource for a given name.")
  get is ArmResourceRead<GraphServicesAccountResource>;
  @doc("Create or update account resource.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<GraphServicesAccountResource>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Update account details.")
  update is ArmCustomPatchSync<
    GraphServicesAccountResource,
    AccountPatchResource
  >;
  @doc("Deletes a account resource.")
  delete is ArmResourceDeleteSync<GraphServicesAccountResource>;
  @doc("Returns list of accounts apps.")
  listByResourceGroup is ArmResourceListByParent<GraphServicesAccountResource>;
  @doc("Returns list of accounts belonging to a subscription.")
  listBySubscription is ArmListBySubscription<GraphServicesAccountResource>;
}
