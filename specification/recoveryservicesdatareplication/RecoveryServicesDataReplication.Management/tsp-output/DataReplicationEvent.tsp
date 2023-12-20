import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Event model.")
@parentResource(DataReplicationVault)
model DataReplicationEvent is ProxyResource<EventModelProperties> {
  @doc("The event name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("eventName")
  @segment("events")
  name: string;
}

@armResourceOperations
interface DataReplicationEvents {
  @doc("Gets the details of the event.")
  get is ArmResourceRead<DataReplicationEvent>;
  @doc("Gets the list of events in the given vault.")
  list is ArmResourceListByParent<
    DataReplicationEvent,
    {
      ...BaseParameters<DataReplicationEvent>;

      @doc("Filter string.")
      @query("$filter")
      $filter?: string;

      @doc("Continuation token.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
