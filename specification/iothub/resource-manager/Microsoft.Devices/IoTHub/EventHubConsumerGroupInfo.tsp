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
 * Intermediate path segment for Event Hub endpoints.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "EventHubEndpoint is an intermediate path segment in the published API with no properties of its own; the empty model is required to represent the parent resource path."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This intermediate path-segment resource has no properties or provisioningState in the published API; retained as-is to preserve backward compatibility."
@parentResource(IotHubDescription)
model EventHubEndpoint is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = EventHubEndpoint,
    KeyName = "eventHubEndpointName",
    SegmentName = "eventHubEndpoints",
    NamePattern = ""
  >;
}

/**
 * The properties of the EventHubConsumerGroupInfo object.
 */
@parentResource(EventHubEndpoint)
model EventHubConsumerGroupInfo
  is Azure.ResourceManager.ProxyResource<Record<unknown>> {
  ...ResourceNameParameter<
    Resource = EventHubConsumerGroupInfo,
    KeyName = "name",
    SegmentName = "ConsumerGroups",
    NamePattern = ""
  >;

  /**
   * The etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is exposed at the resource envelope root in the published API; retained at this position to preserve backward compatibility."
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface EventHubConsumerGroupInfos {
  /**
   * Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for an IoT hub.
   */
  @summary("Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for an IoT hub")
  @tag("GET")
  getEventHubConsumerGroup is ArmResourceRead<
    EventHubConsumerGroupInfo,
    Error = ErrorDetails
  >;

  /**
   * Add a consumer group to an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This create operation returns only 200 in the published API; response codes are retained to preserve backward compatibility."
  @summary("Add a consumer group to an Event Hub-compatible endpoint in an IoT hub")
  @tag("PUT")
  createEventHubConsumerGroup is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    EventHubConsumerGroupInfo,
    Request = EventHubConsumerGroupBodyDescription,
    Response = ArmResourceUpdatedResponse<EventHubConsumerGroupInfo>,
    Error = ErrorDetails
  >;

  /**
   * Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "This synchronous delete returns only 200 in the published API; response codes are retained to preserve backward compatibility."
  @summary("Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub")
  @tag("DELETE")
  deleteEventHubConsumerGroup is ArmResourceDeleteSync<
    EventHubConsumerGroupInfo,
    Response = ArmDeletedResponse,
    Error = ErrorDetails
  >;

  /**
   * Get a list of the consumer groups in the Event Hub-compatible device-to-cloud endpoint in an IoT hub.
   */
  @summary("Get a list of the consumer groups in the Event Hub-compatible device-to-cloud endpoint in an IoT hub")
  @tag("GET")
  listEventHubConsumerGroups is ArmResourceListByParent<
    EventHubConsumerGroupInfo,
    Response = ArmResponse<EventHubConsumerGroupsListResult>,
    Error = ErrorDetails
  >;
}

@@doc(
  EventHubConsumerGroupInfo.name,
  "The name of the consumer group to retrieve."
);
@@doc(EventHubConsumerGroupInfo.properties, "The tags.");
@@doc(
  EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "The consumer group to add."
);
