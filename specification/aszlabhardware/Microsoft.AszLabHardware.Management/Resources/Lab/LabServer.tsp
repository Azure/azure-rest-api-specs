import "../../Models/ServerPropertiesBase.tsp";
import "../../Models/System.tsp";
import "../../Models/ManagementInformation.tsp";
import "../../Models/SetAccountRequestBody.tsp";
import "../../Models/RemoveAccountRequestBody.tsp";
import "../../Models/ExternalReference.tsp";
import "../../Models/ResetRequestBody.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AszLabHardware;

@doc("Details about the AszLabHardware Lab/Server resource")
@parentResource(Lab)
model LabServer is ProxyResource<LabServerProperties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("servers")
  @path
  name: string;
}

@doc("Properties")
model LabServerProperties {
  ...ServerPropertiesBase;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Update, Lifecycle.Read)
  @doc("The Pool Azure Resource this server is assigned to")
  poolResourceId?: PoolResourceId;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Server management information bag")
  management: ManagementInformation;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The backing data source for this resource")
  externalReference: ExternalReference;

  @visibility(Lifecycle.Read)
  @doc("Maintenance status")
  maintenanceStatus: MaintenanceStatus;

  @visibility(Lifecycle.Update, Lifecycle.Read)
  @doc("Maintenance state")
  maintenanceState?: MaintenanceState;

  @visibility(Lifecycle.Read)
  @doc("Reservation status")
  reservationStatus: ReservationStatus;
}

@doc("The reservation status of the server")
union ReservationStatus {
  @doc("Reserved status")
  Reserved: "Reserved",

  @doc("Not Reserved status")
  NotReserved: "NotReserved",

  string,
}

@doc("The maintenance status of the server")
union MaintenanceStatus {
  @doc("Lab manager has requested maintenance")
  RequestedMaintenance: "RequestedMaintenance",

  @doc("Server is in maintenance")
  InMaintenance: "InMaintenance",

  @doc("Server is not in maintenance")
  NotInMaintenance: "NotInMaintenance",

  string,
}

@doc("The maintenance state of the server")
union MaintenanceState {
  @doc("Requires maintenance")
  Require: "Require",

  @doc("Request maintenance on server")
  Request: "Request",

  @doc("No maintenance needed on server")
  Clear: "Clear",

  string,
}

@armResourceOperations
interface LabServers {
  get is ArmResourceRead<LabServer>;
  listByParent is ArmResourceListByParent<LabServer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LabServer>;
  update is ArmResourcePatchAsync<LabServer, LabServerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<LabServer>;

  @doc("Set BMC account")
  setAccount is ArmResourceActionNoResponseContentAsync<
    LabServer,
    SetAccountRequestBody
  >;

  @doc("Remove BMC account")
  removeAccount is ArmResourceActionNoResponseContentAsync<
    LabServer,
    RemoveAccountRequestBody
  >;

  @doc("Refresh hardware information")
  refresh is ArmResourceActionNoResponseContentAsync<LabServer, void>;

  @doc("Power state operations")
  reset is ArmResourceActionNoResponseContentAsync<LabServer, ResetRequestBody>;
}
