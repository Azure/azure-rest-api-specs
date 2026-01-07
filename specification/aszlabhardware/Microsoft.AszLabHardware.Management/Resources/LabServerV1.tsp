import "../Models/LabResourceTypes.tsp";
import "../Models/ResourceManager.tsp";
import "../Models/System.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AszLabHardware;

@doc("A physical computer which can be reserved for use by a user")
model LabServerV1 is TrackedResource<LabServerV1Properties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("labservers")
  @path
  name: string;
}

@doc("Details of the AszLabHw LabServer.")
model LabServerV1Properties {
  @visibility(Lifecycle.Read)
  @doc("The current status of the GoalState")
  resourceManager?: ResourceManager;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The Serial Number of the LabServer.")
  serialNumber: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("IP address of the LabServer's BMC.")
  bmcIpAddress: string;

  @visibility(Lifecycle.Read)
  @doc("LabServer Inventory Information")
  inventory?: System;

  @visibility(Lifecycle.Read)
  @doc("Physical location of the LabServer.")
  physicalLocation?: string;

  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("LabServer availability for reservation.")
  availableForReservationState?: LabResourceAvailableForReservationState;

  @visibility(Lifecycle.Read)
  @doc("LabServer reservation status.")
  reservationStatus?: LabResourceReservationStatus;

  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("LabServer maintenance request state.")
  maintenanceRequestState?: LabResourceMaintenanceRequestState;

  @visibility(Lifecycle.Read)
  @doc("LabServer maintenance status.")
  maintenanceStatus?: LabResourceMaintenanceStatus;
}

@armResourceOperations
interface LabServerV1s {
  get is ArmResourceRead<LabServerV1>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LabServerV1>;
  update is ArmCustomPatchAsync<
    LabServerV1,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      LabServerV1,
      LabServerV1Properties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LabServerV1>;
  listByResourceGroup is ArmResourceListByParent<LabServerV1>;
  listBySubscription is ArmListBySubscription<LabServerV1>;
  @doc("Collects the inventory of the server")
  collectInventory is ArmResourceActionSync<LabServerV1, void, void>;
}
