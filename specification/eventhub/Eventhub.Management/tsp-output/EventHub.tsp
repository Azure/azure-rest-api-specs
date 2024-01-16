import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EventHubsNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
@doc("Single item in List or Get Event Hub operation")
@parentResource(EventHubsNamespace)
model EventHub is ProxyResource<EventhubProperties> {
  @doc("The Event Hub name")
  @maxLength(256)
  @minLength(1)
  @path
  @key("eventHubName")
  @segment("eventhubs")
  name: string;
}

@armResourceOperations
interface EventHubs {
  @doc("Gets an Event Hubs description for the specified Event Hub.")
  get is ArmResourceRead<EventHub>;

  @doc("Creates or updates a new Event Hub as a nested resource within a Namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHub>;

  @doc("Deletes an Event Hub from the specified Namespace and resource group.")
  delete is ArmResourceDeleteSync<EventHub>;

  @doc("Gets all the Event Hubs in a Namespace.")
  listByNamespace is ArmResourceListByParent<
    EventHub,
    {
      ...BaseParameters<EventHub>;

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

@@projectedName(EventHubs.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubs.createOrUpdate::parameters.resource,
  "Parameters supplied to create an Event Hub resource."
);
