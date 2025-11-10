import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Eventhub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Single item in List or Get Consumer group operation
 */
@parentResource(Eventhub)
model ConsumerGroup
  is Azure.ResourceManager.ProxyResource<ConsumerGroupProperties> {
  ...ResourceNameParameter<
    Resource = ConsumerGroup,
    KeyName = "consumerGroupName",
    SegmentName = "consumergroups",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ConsumerGroups {
  /**
   * Gets a description for the specified consumer group.
   */
  get is ArmResourceRead<ConsumerGroup, Error = ErrorResponse>;

  /**
   * Creates or updates an Event Hubs consumer group as a nested resource within a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ConsumerGroup,
    Response = ArmResourceUpdatedResponse<ConsumerGroup>,
    Error = ErrorResponse
  >;

  /**
   * Deletes a consumer group from the specified Event Hub and resource group.
   */
  delete is ArmResourceDeleteSync<ConsumerGroup, Error = ErrorResponse>;

  /**
   * Gets all the consumer groups in a Namespace. An empty feed is returned if no consumer group exists in the Namespace.
   */
  listByEventHub is ArmResourceListByParent<
    ConsumerGroup,
    Parameters = {
      /**
       * Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.
       */
      @maxValue(1000)
      @minValue(0)
      @query("$skip")
      $skip?: int32;

      /**
       * May be used to limit the number of results to the most recent N usageDetails.
       */
      @maxValue(1000)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = ErrorResponse
  >;
}

@@maxLength(ConsumerGroup.name, 50);
@@minLength(ConsumerGroup.name, 1);
@@doc(ConsumerGroup.name, "The consumer group name");
@@doc(ConsumerGroup.properties,
  "Single item in List or Get Consumer group operation"
);
@@doc(ConsumerGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a consumer group resource."
);
