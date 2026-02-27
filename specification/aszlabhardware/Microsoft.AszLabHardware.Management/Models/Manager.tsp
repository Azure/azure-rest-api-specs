import "./InventoryLocalAccount.tsp";

using Azure.ResourceManager;

@doc("The model representing the BMC")
model Manager {
  @visibility(Lifecycle.Read)
  @doc("Manufacturer of BMC")
  manufacturer?: string;

  @visibility(Lifecycle.Read)
  @doc("Model of BMC")
  `model`?: string;

  @visibility(Lifecycle.Read)
  @doc("Firmware version of BMC")
  firmwareVersion?: string;

  @visibility(Lifecycle.Read)
  @doc("List of BMC accounts")
  @identifiers(#["username"])
  accounts?: InventoryLocalAccount[];
}
