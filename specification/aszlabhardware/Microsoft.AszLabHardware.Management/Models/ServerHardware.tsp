import "./ServerHardwareProcessor.tsp";
import "./ServerHardwareDrive.tsp";
import "./ServerHardwareGraphicsCard.tsp";
import "./ServerHardwareNetworkCard.tsp";

using OpenAPI;

@doc("The hardware information about the server")
model ServerHardware {
  @visibility(Lifecycle.Read)
  @doc("The manufacturer of the server")
  manufacturer?: string;

  @visibility(Lifecycle.Read)
  @doc("The model of the server")
  `model`?: string;

  @visibility(Lifecycle.Read)
  @doc("Powerstate of the server")
  powerState: PowerState;

  @visibility(Lifecycle.Read)
  @doc("The serial number of the server")
  serialNumber?: string;

  @visibility(Lifecycle.Read)
  @doc("The total RAM capacity of the server")
  memoryGb?: int32;

  @visibility(Lifecycle.Read)
  @doc("The total SSD capacity (SATA + NVME) of the server")
  ssdCapacityGb?: int32;

  @visibility(Lifecycle.Read)
  @doc("The total HDD capacity of the server")
  hddCapacityGb?: int32;

  @visibility(Lifecycle.Read)
  @doc("The processors of the server")
  @Azure.ResourceManager.identifiers(#[])
  processors?: ServerHardwareProcessor[];

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @doc("The drives of the server")
  drives?: ServerHardwareDrive[];

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @doc("The GPUs of the server")
  graphicsCards?: ServerHardwareGraphicsCard[];

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @doc("The network cards of the server")
  networkCards?: ServerHardwareNetworkCard[];
}

@doc("The different power states of the server")
union PowerState {
  @doc("Server is on")
  On: "On",

  @doc("Server is Off")
  Off: "Off",

  @doc("Server is powering on")
  PoweringOn: "PoweringOn",

  @doc("Server is powering off")
  PoweringOff: "PoweringOff",

  @doc("Server is paused")
  Paused: "Paused",

  string,
}
