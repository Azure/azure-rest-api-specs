import "../../Models/ServerPropertiesBase.tsp";
import "../../Models/System.tsp";
import "../../Models/ManagementInformation.tsp";
import "../../Models/SetAccountRequestBody.tsp";
import "../../Models/RemoveAccountRequestBody.tsp";

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

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("The Pool Azure Resource this server is assigned to")
  poolResourceId?: PoolResourceId;

  @visibility("create", "read")
  @doc("Server management information bag")
  management: ManagementInformation;

  @visibility("read")
  @doc("Maintenance status")
  maintenanceStatus: MaintenanceStatus;

  @visibility("read")
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

@doc("The request body model of an assign POST call")
model AssignRequestBody {
  @doc("The pool Azure Resource Id to assign this Labserver to")
  poolResourceId: PoolResourceId;
}

@doc("The commands relating to power state")
union ResetType {
  @doc("Gracefully restart server")
  GracefulRestart: "GracefulRestart",

  @doc("Gracefully shut down server")
  GracefulShutdown: "GracefulShutdown",

  @doc("Force shut down server")
  ForceOff: "ForceOff",

  @doc("Turn server on")
  On: "On",

  @doc("Force restart server")
  ForceRestart: "ForceRestart",

  string,
}

@doc("The request body model of a reset POST call")
model ResetRequestBody {
  @doc("The enum describing the power state")
  resetType: ResetType;
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

@doc("The request body model for setMaintenanceState POST call")
model SetMaintenanceStateRequestBody {
  @doc("The enum describing the maintenance state")
  maintenanceState: MaintenanceState;
}

@armResourceOperations
interface LabServers {
  get is ArmResourceRead<LabServer>;
  listByParent is ArmResourceListByParent<LabServer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LabServer>;
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

  @doc("Assign the server to a pool")
  assign is ArmResourceActionNoResponseContentAsync<
    LabServer,
    AssignRequestBody
  >;

  @doc("Unassign the server from a pool")
  unassign is ArmResourceActionNoResponseContentAsync<LabServer, void>;

  @doc("Refresh hardware information")
  refresh is ArmResourceActionNoResponseContentAsync<LabServer, void>;

  @doc("Power state operations")
  reset is ArmResourceActionNoResponseContentAsync<LabServer, ResetRequestBody>;

  @doc("Request maintenance")
  setMaintenance is ArmResourceActionNoResponseContentAsync<
    LabServer,
    SetMaintenanceStateRequestBody
  >;
}
