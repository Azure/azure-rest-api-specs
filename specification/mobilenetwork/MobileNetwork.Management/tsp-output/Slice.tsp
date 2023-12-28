import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Network slice resource. Must be created in the same location as its parent mobile network.")
@parentResource(MobileNetwork)
model Slice is TrackedResource<SlicePropertiesFormat> {
  @doc("The name of the network slice.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("sliceName")
  @segment("slices")
  name: string;
}

@armResourceOperations
interface Slices {
  @doc("Gets information about the specified network slice.")
  get is ArmResourceRead<Slice>;
  @doc("Creates or updates a network slice. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Slice>;
  @doc("Updates slice tags.")
  updateTags is ArmCustomPatchSync<Slice, TagsObject>;
  @doc("Deletes the specified network slice.")
  delete is ArmResourceDeleteAsync<Slice>;
  @doc("Lists all slices in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<Slice>;
}
