import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The properties of the EventHubConsumerGroupInfo object.
 */
@parentResource(IotHubDescription)
model EventHubConsumerGroupInfo
  is Azure.ResourceManager.ProxyResource<Record<unknown>> {
  ...ResourceNameParameter<
    Resource = EventHubConsumerGroupInfo,
    KeyName = "name",
    SegmentName = "ConsumerGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface EventHubConsumerGroupInfos {
  /**
   * Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_GetEventHubConsumerGroup")
  getEventHubConsumerGroup is ArmResourceRead<EventHubConsumerGroupInfo>;

  /**
   * Add a consumer group to an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("IotHubResource_CreateEventHubConsumerGroup")
  createEventHubConsumerGroup is ArmResourceCreateOrReplaceSync<
    EventHubConsumerGroupInfo,
    Response = ArmResourceUpdatedResponse<EventHubConsumerGroupInfo>
  >;

  /**
   * Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("IotHubResource_DeleteEventHubConsumerGroup")
  deleteEventHubConsumerGroup is ArmResourceDeleteSync<
    EventHubConsumerGroupInfo,
    Response = ArmDeletedResponse
  >;

  /**
   * Get a list of the consumer groups in the Event Hub-compatible device-to-cloud endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotHubResource_ListEventHubConsumerGroups")
  listEventHubConsumerGroups is ArmResourceListByParent<EventHubConsumerGroupInfo>;
}

@@doc(EventHubConsumerGroupInfo.name,
  "The name of the consumer group to retrieve."
);
@@encodedName(EventHubConsumerGroupInfo.eTag, "application/json", "etag");
@@doc(EventHubConsumerGroupInfo.properties, "The tags.");
@@doc(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "The consumer group to add."
);
