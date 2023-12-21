import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EventHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.EventHubs;
@doc("Single item in List or Get Consumer group operation")
@parentResource(EventHub)
model EventHubsConsumerGroup is ProxyResource<ConsumerGroupProperties> {
  @doc("The consumer group name")
  @maxLength(50)
  @minLength(1)
  @path
  @key("consumerGroupName")
  @segment("consumergroups")
  name: string;
}

@armResourceOperations
interface ConsumerGroups {
  @doc("Gets a description for the specified consumer group.")
  get is ArmResourceRead<EventHubsConsumerGroup>;
  @doc("Creates or updates an Event Hubs consumer group as a nested resource within a Namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsConsumerGroup>;
  @doc("Deletes a consumer group from the specified Event Hub and resource group.")
  delete is ArmResourceDeleteSync<EventHubsConsumerGroup>;
  @doc("Gets all the consumer groups in a Namespace. An empty feed is returned if no consumer group exists in the Namespace.")
  listByEventHub is ArmResourceListByParent<
    EventHubsConsumerGroup,
    {
      ...BaseParameters<EventHubsConsumerGroup>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}
