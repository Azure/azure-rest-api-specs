import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The IP Extended Community resource definition.")
model NetworkFabricIPExtendedCommunity
  is TrackedResource<IpExtendedCommunityProperties> {
  @doc("Name of the IP Extended Community.")
  @path
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  name: string;
}

@armResourceOperations
interface NetworkFabricIPExtendedCommunities {
  @doc("Implements IP Extended Community GET method.")
  get is ArmResourceRead<NetworkFabricIPExtendedCommunity>;
  @doc("Implements IP Extended Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricIPExtendedCommunity>;
  @doc("API to update certain properties of the IP Extended Community resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricIPExtendedCommunity,
    IpExtendedCommunityProperties
  >;
  @doc("Implements IP Extended Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricIPExtendedCommunity>;
  @doc("Implements IpExtendedCommunities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricIPExtendedCommunity>;
  @doc("Implements IpExtendedCommunities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricIPExtendedCommunity>;
}
