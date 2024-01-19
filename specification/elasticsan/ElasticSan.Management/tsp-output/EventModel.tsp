import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
@doc("Event model.")
@parentResource(VaultModel)
model EventModel is ProxyResource<EventModelProperties> {
  @doc("The event name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("eventName")
  @segment("events")
  name: string;
}

@armResourceOperations
interface EventModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the event.")
  @operationId("Event_Get")
  get is ArmResourceRead<EventModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of events in the given vault.")
  @operationId("Event_List")
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
