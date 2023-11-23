import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.MobileNetwork;
@doc("Mobile network resource.")
model MobileNetwork is TrackedResource<MobileNetworkPropertiesFormat> {
  @doc("The name of the mobile network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("mobileNetworkName")
  @segment("mobileNetworks")
  name: string;
}

@armResourceOperations
interface MobileNetworks {
  @doc("Gets information about the specified mobile network.")
  get is ArmResourceRead<MobileNetwork>;
  @doc("Creates or updates a mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetwork>;
  @doc("Updates mobile network tags.")
  updateTags is ArmTagsPatchSync<MobileNetwork>;
  @doc("Deletes the specified mobile network.")
  delete is ArmResourceDeleteAsync<MobileNetwork>;
  @doc("Lists all the mobile networks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<MobileNetwork>;
  @doc("Lists all the mobile networks in a subscription.")
  listBySubscription is ArmListBySubscription<MobileNetwork>;
}
