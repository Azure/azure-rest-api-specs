import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The IP Community resource definition.")
model NetworkFabricIPCommunity is TrackedResource<IpCommunityProperties> {
  @doc("Name of the IP Community.")
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  name: string;
}

@armResourceOperations
interface NetworkFabricIPCommunities {
  @doc("Implements an IP Community GET method.")
  get is ArmResourceRead<NetworkFabricIPCommunity>;
  @doc("Implements an IP Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricIPCommunity>;
  @doc("API to update certain properties of the IP Community resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricIPCommunity,
    IpCommunityProperties
  >;
  @doc("Implements IP Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricIPCommunity>;
  @doc("Implements IP Communities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricIPCommunity>;
  @doc("Implements IP Communities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricIPCommunity>;
}
