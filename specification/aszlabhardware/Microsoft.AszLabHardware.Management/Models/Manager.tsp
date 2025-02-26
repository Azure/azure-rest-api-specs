import "./InventoryLocalAccount.tsp";

using OpenAPI;

@doc("The model representing the BMC")
model Manager {
  @visibility("read")
  @doc("Manufacturer of BMC")
  manufacturer?: string;

  @visibility("read")
  @doc("Model of BMC")
  `model`?: string;

  @visibility("read")
  @doc("Firmware version of BMC")
  firmwareVersion?: string;

  @visibility("read")
  @doc("List of BMC accounts")
  @extension("x-ms-identifiers", ["username"])
  accounts?: InventoryLocalAccount[];
}
