import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
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
  create is ArmResourceCreateOrUpdateAsync<
    NetworkPacketBroker,
    BaseParameters<NetworkPacketBroker>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the Network Packet Broker resource.")
  update is ArmCustomPatchAsync<
    NetworkPacketBroker,
    NetworkPacketBrokerPatch,
    BaseParameters<NetworkPacketBroker>,
    ArmLroLocationHeader
  >;

  @doc("Deletes Network Packet Broker.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkPacketBroker,
    BaseParameters<NetworkPacketBroker>,
    ArmLroLocationHeader
  >;

  @doc("Displays NetworkPacketBrokers list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkPacketBroker>;

  @doc("Displays Network Packet Brokers list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkPacketBroker>;
}

@@projectedName(NetworkPacketBrokers.create::parameters.resource,
  "json",
  "body"
);
@@extension(NetworkPacketBrokers.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkPacketBrokers.create::parameters.resource, "Request payload.");
@@projectedName(NetworkPacketBrokers.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkPacketBrokers.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkPacketBrokers.update::parameters.properties,
  "Network Packet Broker properties to update."
);
