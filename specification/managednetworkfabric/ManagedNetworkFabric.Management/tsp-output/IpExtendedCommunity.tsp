import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The IP Extended Community resource definition.")
model IpExtendedCommunity is TrackedResource<IpExtendedCommunityProperties> {
  @doc("Name of the IP Extended Community.")
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  name: string;
}

@armResourceOperations
interface IpExtendedCommunities {
  @doc("Implements IP Extended Community GET method.")
  get is ArmResourceRead<IpExtendedCommunity>;

  @doc("Implements IP Extended Community PUT method.")
  create is ArmResourceCreateOrUpdateAsync<IpExtendedCommunity>;

  @doc("API to update certain properties of the IP Extended Community resource.")
  update is ArmCustomPatchAsync<IpExtendedCommunity, IpExtendedCommunityPatch>;

  @doc("Implements IP Extended Community DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpExtendedCommunity>;

  @doc("Implements IpExtendedCommunities list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  @doc("Implements IpExtendedCommunities list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}
