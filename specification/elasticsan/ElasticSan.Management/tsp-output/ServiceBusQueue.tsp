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
@doc("Description of queue Resource.")
@parentResource(ServiceBusNamespace)
model ServiceBusQueue is ProxyResource<SBQueueProperties> {
  @doc("The queue name.")
  @minLength(1)
  @path
  @key("queueName")
  @segment("queues")
  name: string;
}

@armResourceOperations
interface ServiceBusQueues {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a description for the specified queue.")
  @operationId("Queues_Get")
  get is ArmResourceRead<ServiceBusQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a Service Bus queue. This operation is idempotent.")
  @operationId("Queues_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a queue from the specified namespace in a resource group.")
  @operationId("Queues_Delete")
  delete is ArmResourceDeleteSync<ServiceBusQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the queues within a namespace.")
  @operationId("Queues_ListByNamespace")
  listByNamespace is ArmResourceListByParent<
    ServiceBusQueue,
    {
      ...BaseParameters<ServiceBusQueue>;

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

@@projectedName(ServiceBusQueues.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusQueues.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusQueues.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a queue resource."
);
