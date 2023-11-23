import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Single item in List or Get Event Hub operation")
@parentResource(EHNamespace)
model Eventhub is ProxyResource<EventhubProperties> {
  @doc("The Event Hub name")
  @maxLength(256)
  @minLength(1)
  @path
  @key("eventHubName")
  @segment("eventhubs")
  name: string;
}

@armResourceOperations
interface Eventhubs {
  @doc("Gets an Event Hubs description for the specified Event Hub.")
  get is ArmResourceRead<Eventhub>;
  @doc("Creates or updates a new Event Hub as a nested resource within a Namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Eventhub>;
  @doc("Deletes an Event Hub from the specified Namespace and resource group.")
  delete is ArmResourceDeleteSync<Eventhub>;
  @doc("Gets all the Event Hubs in a Namespace.")
  listByNamespace is ArmResourceListByParent<
    Eventhub,
    {
      ...BaseParameters<Eventhub>;

      @doc("Skip is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skip parameter that specifies a starting point to use for subsequent calls.")
      @query("$skip")
      $skip?: int32;

      @doc("May be used to limit the number of results to the most recent N usageDetails.")
      @query("$top")
      $top?: int32;
    }
  >;
}
