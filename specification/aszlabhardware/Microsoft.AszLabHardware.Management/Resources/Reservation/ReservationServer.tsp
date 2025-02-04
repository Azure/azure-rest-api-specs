import "../../Models/SetAccountRequestBody.tsp";
import "../../Models/RemoveAccountRequestBody.tsp";

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

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Endpoint for managing the server")
  managementEndpoint?: string;
}

@armResourceOperations
interface ReservationServers {
  get is ArmResourceRead<ReservationServer>;
  listByParent is ArmResourceListByParent<ReservationServer>;
  setAccount is ArmResourceActionNoResponseContentAsync<
    ReservationServer,
    SetAccountRequestBody
  >;
  removeAccount is ArmResourceActionNoResponseContentAsync<
    ReservationServer,
    RemoveAccountRequestBody
  >;
}
