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
/**
 * The NetworkPacketBroker resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkPacketBrokerProperties
)
@includeInapplicableMetadataInPayload(false)
model NetworkPacketBroker extends TrackedResourceBase {
  /**
   * Name of the Network Packet Broker.
   */
  @path
  @key("networkPacketBrokerName")
  @segment("networkPacketBrokers")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  create is ArmResourceCreateOrReplaceAsync<
    NetworkPacketBroker,
    BaseParameters<NetworkPacketBroker>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the Network Packet Broker resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkPacketBroker,
    NetworkPacketBrokerPatch,
    BaseParameters<NetworkPacketBroker>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes Network Packet Broker.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkPacketBroker,
    BaseParameters<NetworkPacketBroker>,
    ArmLroLocationHeader
  >;

  /**
   * Displays NetworkPacketBrokers list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkPacketBrokers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkPacketBroker>;

  /**
   * Displays Network Packet Brokers list by subscription GET method.
   */
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
