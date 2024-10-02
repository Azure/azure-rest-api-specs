import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkPacketBroker resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NetworkPacketBroker
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Packet Broker.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkPacketBrokerName")
  @segment("networkPacketBrokers")
  @visibility("read")
  name: string;

  /** The NetworkPacketBroker properties */
  properties: NetworkPacketBrokerProperties;
}

@armResourceOperations
interface NetworkPacketBrokers {
  /**
   * Retrieves details of this Network Packet Broker.
   */
  get is ArmResourceRead<NetworkPacketBroker>;

  /**
   * Creates a Network Packet Broker.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkPacketBroker>;

  /**
   * API to update certain properties of the Network Packet Broker resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkPacketBroker, NetworkPacketBrokerPatch>;

  /**
   * Deletes Network Packet Broker.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkPacketBroker>;

  /**
   * Displays NetworkPacketBrokers list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkPacketBroker>;

  /**
   * Displays Network Packet Brokers list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<NetworkPacketBroker>;
}

@@doc(NetworkPacketBrokers.create::parameters.resource, "Request payload.");
@@doc(NetworkPacketBrokers.update::parameters.properties,
  "Network Packet Broker properties to update."
);
