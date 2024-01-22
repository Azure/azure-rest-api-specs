import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The properties of the EventHubConsumerGroupInfo object.
 */
@parentResource(IotHubDescription)
model EventHubConsumerGroupInfo is ProxyResource<Record<unknown>> {
  /**
   * The name of the consumer group to retrieve.
   */
  @path
  @key("name")
  @segment("ConsumerGroups")
  name: string;

  /**
   * The etag.
   */
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface EventHubConsumerGroupInfos {
  /**
   * Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_GetEventHubConsumerGroup")
  getEventHubConsumerGroup is ArmResourceRead<EventHubConsumerGroupInfo>;

  /**
   * Add a consumer group to an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_CreateEventHubConsumerGroup")
  createEventHubConsumerGroup is ArmResourceCreateOrReplaceSync<EventHubConsumerGroupInfo>;

  /**
   * Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_DeleteEventHubConsumerGroup")
  deleteEventHubConsumerGroup is ArmResourceDeleteSync<EventHubConsumerGroupInfo>;

  /**
   * Get a list of the consumer groups in the Event Hub-compatible device-to-cloud endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotHubResource_ListEventHubConsumerGroups")
  listEventHubConsumerGroups is ArmResourceListByParent<EventHubConsumerGroupInfo>;
}

@@projectedName(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "json",
  "consumerGroupBody"
);
@@extension(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "x-ms-client-name",
  "consumerGroupBody"
);
@@doc(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "The consumer group to add."
);
