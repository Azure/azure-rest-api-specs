import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusTopic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of subscription resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusTopic)
@includeInapplicableMetadataInPayload(false)
model ServiceBusSubscription extends ProxyResource {
  /**
   * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
   */
  @path
  @key("subscriptionId")
  @segment("subscriptions")
  @visibility("read")
  name: string;

  /**
   * The system meta data relating to this resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Properties of subscriptions resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SBSubscriptionProperties;
}

@armResourceOperations
interface ServiceBusSubscriptions {
  /**
   * Returns a subscription description for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subscriptions_Get")
  get is ArmResourceRead<ServiceBusSubscription>;

  /**
   * Creates a topic subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subscriptions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusSubscription>;

  /**
   * Deletes a subscription from the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subscriptions_Delete")
  delete is ArmResourceDeleteSync<ServiceBusSubscription>;

  /**
   * List all the subscriptions under a specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subscriptions_ListByTopic")
  listByTopic is ArmResourceListByParent<
    ServiceBusSubscription,
    {
      ...BaseParameters<ServiceBusSubscription>;

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

@@projectedName(ServiceBusSubscriptions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusSubscriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusSubscriptions.createOrUpdate::parameters.resource,
  "Parameters supplied to create a subscription resource."
);
