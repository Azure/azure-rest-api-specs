import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Provisioning state enum")
union ProvisioningState {
  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource action is successful.")
  Succeeded: "Succeeded",

  @doc("The resource action has failed.")
  Failed: "Failed",

  @doc("The resource action has been cancelled.")
  Canceled: "Canceled",

  @doc("The resource provisioning has been accepted.")
  Accepted: "Accepted",

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource has been deleted.")
  Deleted: "Deleted",

  @doc("The resource status is unspecified.")
  NotSpecified: "NotSpecified",

  string,
}

@doc("Device type enum")
union DeviceType {
  @doc("The Server.")
  Server: "Server",

  @doc("The ChassisManager.")
  ChassisManager: "ChassisManager",

  @doc("The EpmsSensor.")
  EpmsSensor: "EpmsSensor",

  @doc("The RackManager.")
  RackManager: "RackManager",

  @doc("The EPMS.")
  EPMS: "EPMS",

  string,
}
