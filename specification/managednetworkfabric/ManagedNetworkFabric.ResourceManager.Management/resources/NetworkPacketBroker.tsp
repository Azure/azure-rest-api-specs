import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The NetworkPacketBroker resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkPacketBroker
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Packet Broker.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkPacketBrokerName")
  @segment("networkPacketBrokers")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkPacketBroker properties */
  properties: NetworkPacketBrokerProperties;
}

@armResourceOperations
interface NetworkPacketBrokers {
  @doc("Retrieves details of this Network Packet Broker.")
  get is ArmResourceRead<NetworkPacketBroker>;

  @doc("Creates a Network Packet Broker.")
  create is ArmResourceCreateOrReplaceAsync<NetworkPacketBroker>;

  @doc("API to update certain properties of the Network Packet Broker resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkPacketBroker, NetworkPacketBrokerPatch>;

  @doc("Deletes Network Packet Broker.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkPacketBroker>;

  @doc("Displays NetworkPacketBrokers list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkPacketBroker>;

  @doc("Displays Network Packet Brokers list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkPacketBroker>;
}

@@doc(NetworkPacketBrokers.create::parameters.resource, "Request payload.");
@@doc(NetworkPacketBrokers.update::parameters.properties,
  "Network Packet Broker properties to update."
);
