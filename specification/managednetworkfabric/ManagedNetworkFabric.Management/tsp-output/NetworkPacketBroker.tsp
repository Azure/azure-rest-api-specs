import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The NetworkPacketBroker resource definition.")
model NetworkPacketBroker is TrackedResource<NetworkPacketBrokerProperties> {
  @doc("Name of the Network Packet Broker.")
  @path
  @key("networkPacketBrokerName")
  @segment("networkPacketBrokers")
  name: string;
}

@armResourceOperations
interface NetworkPacketBrokers {
  @doc("Retrieves details of this Network Packet Broker.")
  get is ArmResourceRead<NetworkPacketBroker>;
  @doc("Creates a Network Packet Broker.")
  create is ArmResourceCreateOrUpdateAsync<NetworkPacketBroker>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("API to update certain properties of the Network Packet Broker resource.")
  update is ArmCustomPatchAsync<NetworkPacketBroker, NetworkPacketBrokerPatch>;
  @doc("Deletes Network Packet Broker.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkPacketBroker>;
  @doc("Displays NetworkPacketBrokers list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkPacketBroker>;
  @doc("Displays Network Packet Brokers list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkPacketBroker>;
}
