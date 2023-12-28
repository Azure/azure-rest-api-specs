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
model IpCommunity is TrackedResource<IpCommunityProperties> {
  @doc("Name of the IP Community.")
  @key("ipCommunityName")
  @segment("ipCommunities")
  name: string;
}

@armResourceOperations
interface IpCommunities {
  @doc("Implements an IP Community GET method.")
  get is ArmResourceRead<IpCommunity>;
  @doc("Implements an IP Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<IpCommunity>;
  @doc("API to update certain properties of the IP Community resource.")
  update is ArmCustomPatchAsync<IpCommunity, IpCommunityPatch>;
  @doc("Implements IP Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpCommunity>;
  @doc("Implements IP Communities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;
  @doc("Implements IP Communities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpCommunity>;
}
