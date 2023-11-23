import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The properties of the EventHubConsumerGroupInfo object.")
@parentResource(IotHubDescription)
model EventHubConsumerGroupInfo is ProxyResource<Record<unknown>> {
  @doc("The name of the consumer group to retrieve.")
  @path
  @key("name")
  @segment("ConsumerGroups")
  name: string;
}

@armResourceOperations
interface EventHubConsumerGroupInfos {
  @doc("Get a consumer group from the Event Hub-compatible device-to-cloud endpoint for an IoT hub.")
  getEventHubConsumerGroup is ArmResourceRead<EventHubConsumerGroupInfo>;
  @doc("Add a consumer group to an Event Hub-compatible endpoint in an IoT hub.")
  createEventHubConsumerGroup is ArmResourceCreateOrReplaceSync<EventHubConsumerGroupInfo>;
  @doc("Delete a consumer group from an Event Hub-compatible endpoint in an IoT hub.")
  deleteEventHubConsumerGroup is ArmResourceDeleteSync<EventHubConsumerGroupInfo>;
  @doc("Get a list of the consumer groups in the Event Hub-compatible device-to-cloud endpoint in an IoT hub.")
  listEventHubConsumerGroups is ArmResourceListByParent<EventHubConsumerGroupInfo>;
}
