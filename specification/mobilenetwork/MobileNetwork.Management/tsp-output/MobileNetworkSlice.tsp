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
model MobileNetworkSlice is TrackedResource<SlicePropertiesFormat> {
  @doc("The name of the network slice.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("sliceName")
  @segment("slices")
  name: string;
}

@armResourceOperations
interface MobileNetworkSlices {
  @doc("Gets information about the specified network slice.")
  get is ArmResourceRead<MobileNetworkSlice>;
  @doc("Creates or updates a network slice. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkSlice>;
  @doc("Updates slice tags.")
  updateTags is ArmTagsPatchSync<MobileNetworkSlice>;
  @doc("Deletes the specified network slice.")
  delete is ArmResourceDeleteAsync<MobileNetworkSlice>;
  @doc("Lists all slices in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<MobileNetworkSlice>;
}
