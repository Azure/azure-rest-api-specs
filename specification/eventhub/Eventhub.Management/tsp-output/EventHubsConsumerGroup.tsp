import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single item in List or Get Consumer group operation
 */
@parentResource(EventHub)
model EventHubsConsumerGroup is ProxyResource<ConsumerGroupProperties> {
  /**
   * The consumer group name
   */
  @maxLength(50)
  @minLength(1)
  @path
  @key("consumerGroupName")
  @segment("consumergroups")
  name: string;
}

@armResourceOperations
interface EventHubsConsumerGroups {
  /**
   * Gets a description for the specified consumer group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerGroups_Get")
  get is ArmResourceRead<EventHubsConsumerGroup>;

  /**
   * Creates or updates an Event Hubs consumer group as a nested resource within a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerGroups_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubsConsumerGroup>;

  /**
   * Deletes a consumer group from the specified Event Hub and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerGroups_Delete")
  delete is ArmResourceDeleteSync<EventHubsConsumerGroup>;

  /**
   * Gets all the consumer groups in a Namespace. An empty feed is returned if no consumer group exists in the Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConsumerGroups_ListByEventHub")
  listByEventHub is ArmResourceListByParent<
    EventHubsConsumerGroup,
    {
      ...BaseParameters<EventHubsConsumerGroup>;

      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(EventHubsConsumerGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsConsumerGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsConsumerGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a consumer group resource."
);
