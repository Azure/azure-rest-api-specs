import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkPacketBroker resource definition.
 */
model NetworkPacketBroker
  is Azure.ResourceManager.TrackedResource<
    NetworkPacketBrokerProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NetworkPacketBroker,
    KeyName = "networkPacketBrokerName",
    SegmentName = "networkPacketBrokers",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkPacketBroker,
    PatchModel = NetworkPacketBrokerPatch
  >;

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

@@doc(NetworkPacketBroker.name, "Name of the Network Packet Broker.");
@@doc(NetworkPacketBroker.properties, "Resource properties.");
@@doc(NetworkPacketBrokers.create::parameters.resource, "Request payload.");
@@doc(NetworkPacketBrokers.update::parameters.properties,
  "Network Packet Broker properties to update."
);
