import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of topic resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusNamespace)
@Azure.ResourceManager.Private.armResourceInternal(SBTopicProperties)
@includeInapplicableMetadataInPayload(false)
model ServiceBusTopic extends ProxyResource {
  /**
   * The topic name.
   */
  @minLength(1)
  @path
  @key("topicName")
  @segment("topics")
  name: string;

  /**
   * Properties of topic resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SBTopicProperties;
}

@armResourceOperations
interface ServiceBusTopics {
  /**
   * Returns a description for the specified topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Topics_Get")
  get is ArmResourceRead<ServiceBusTopic>;

  /**
   * Creates a topic in the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Topics_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusTopic>;

  /**
   * Deletes a topic from the specified namespace and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Topics_Delete")
  delete is ArmResourceDeleteSync<ServiceBusTopic>;

  /**
   * Gets all the topics in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Topics_ListByNamespace")
  listByNamespace is ArmResourceListByParent<
    ServiceBusTopic,
    {
      ...BaseParameters<ServiceBusTopic>;

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

@@projectedName(ServiceBusTopics.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusTopics.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusTopics.createOrUpdate::parameters.resource,
  "Parameters supplied to create a topic resource."
);
