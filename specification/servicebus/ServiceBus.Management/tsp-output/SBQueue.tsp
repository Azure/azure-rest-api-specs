import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of queue Resource.")
@parentResource(SBNamespace)
model SBQueue is ProxyResource<SBQueueProperties> {
  @doc("The queue name.")
  @minLength(1)
  @path
  @key("queueName")
  @segment("queues")
  name: string;
}

@armResourceOperations
interface SBQueues {
  @doc("Returns a description for the specified queue.")
  get is ArmResourceRead<SBQueue>;
  @doc("Creates or updates a Service Bus queue. This operation is idempotent.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SBQueue>;
  @doc("Deletes a queue from the specified namespace in a resource group.")
  delete is ArmResourceDeleteSync<SBQueue>;
  @doc("Gets the queues within a namespace.")
  listByNamespace is ArmResourceListByParent<
    SBQueue,
    {
      ...BaseParameters<SBQueue>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query("$top")
      $top?: int32;
    }
  >;
}
