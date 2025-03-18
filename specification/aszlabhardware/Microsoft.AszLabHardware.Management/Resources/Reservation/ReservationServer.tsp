import "../../Models/SetAccountRequestBody.tsp";
import "../../Models/RemoveAccountRequestBody.tsp";
import "../../Models/ResetRequestBody.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AszLabHardware;

@doc("Microsoft.AszLabHardware/Reservation/Server resource")
@parentResource(Reservation)
model ReservationServer is ProxyResource<ReservationServerProperties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("servers")
  @path
  name: string;
}

@doc("Microsoft.AszLabHardware/Reservation/Server properties")
model ReservationServerProperties {
  ...ServerPropertiesBase;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Endpoint for managing the server")
  managementEndpoint?: string;
}

@armResourceOperations
interface ReservationServers {
  get is ArmResourceRead<ReservationServer>;
  listByParent is ArmResourceListByParent<ReservationServer>;

  @doc("Set BMC account")
  setAccount is ArmResourceActionNoResponseContentAsync<
    ReservationServer,
    SetAccountRequestBody
  >;

  @doc("Remove BMC account")
  removeAccount is ArmResourceActionNoResponseContentAsync<
    ReservationServer,
    RemoveAccountRequestBody
  >;

  @doc("Power state operations")
  reset is ArmResourceActionNoResponseContentAsync<
    ReservationServer,
    ResetRequestBody
  >;

  @doc("Allows any requested maintenance on this Server")
  allowMaintenance is ArmResourceActionSync<ReservationServer, void, void>;
}
