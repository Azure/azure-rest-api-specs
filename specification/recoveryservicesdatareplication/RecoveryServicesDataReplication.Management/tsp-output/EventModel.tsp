import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Event model.")
@parentResource(VaultModel)
model EventModel is ProxyResource<EventModelProperties> {
  @doc("The event name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("eventName")
  @segment("events")
  name: string;
}

@armResourceOperations
@projectedName("client", "Event")
interface EventModels_Event {
  @doc("Gets the details of the event.")
  get is ArmResourceRead<EventModel>;

  @doc("Gets the list of events in the given vault.")
  list is ArmResourceListByParent<
    EventModel,
    {
      ...BaseParameters<EventModel>;

      @doc("Filter string.")
      @query("$filter")
      $filter?: string;

      @doc("Continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
