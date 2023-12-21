import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The IP Prefix resource definition.")
model IpPrefix is TrackedResource<IpPrefixProperties> {
  @doc("Name of the IP Prefix.")
  @path
  @key("ipPrefixName")
  @segment("ipPrefixes")
  name: string;
}

@armResourceOperations
interface IpPrefixes {
  @doc("Implements IP Prefix GET method.")
  get is ArmResourceRead<IpPrefix>;
  @doc("Implements IP Prefix PUT method.")
  create is ArmResourceCreateOrUpdateAsync<IpPrefix>;
  @doc("API to update certain properties of the IP Prefix resource.")
  update is ArmResourcePatchAsync<IpPrefix, IpPrefixProperties>;
  @doc("Implements IP Prefix DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<IpPrefix>;
  @doc("Implements IpPrefixes list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;
  @doc("Implements IpPrefixes list by subscription GET method.")
  listBySubscription is ArmListBySubscription<IpPrefix>;
}
