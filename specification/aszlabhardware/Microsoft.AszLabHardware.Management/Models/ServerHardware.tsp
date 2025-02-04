import "./ServerHardwareProcessor.tsp";
import "./ServerHardwareDrive.tsp";
import "./ServerHardwareGraphicsCard.tsp";
import "./ServerHardwareNetworkCard.tsp";

using OpenAPI;

@doc("The hardware information about the server")
model ServerHardware {
  @visibility("read")
  @doc("The manufacturer of the server")
  manufacturer?: string;

  @visibility("read")
  @doc("The model of the server")
  `model`?: string;

  @visibility("read")
  @doc("Powerstate of the server")
  powerState: PowerState;

  @visibility("read")
  @doc("The serial number of the server")
  serialNumber?: string;

  @visibility("read")
  @doc("The total RAM capacity of the server")
  memoryGb?: int32;

  @visibility("read")
  @doc("The total SSD capacity (SATA + NVME) of the server")
  ssdCapacityGb?: int32;

  @visibility("read")
  @doc("The total HDD capacity of the server")
  hddCapacityGb?: int32;

  @visibility("read")
  @doc("The processors of the server")
  @extension("x-ms-identifiers", [])
  processors?: ServerHardwareProcessor[];

  @visibility("read")
  @extension("x-ms-identifiers", [])
  @doc("The drives of the server")
  drives?: ServerHardwareDrive[];

  @visibility("read")
  @extension("x-ms-identifiers", [])
  @doc("The GPUs of the server")
  graphicsCards?: ServerHardwareGraphicsCard[];

  @visibility("read")
  @extension("x-ms-identifiers", [])
  @doc("The network cards of the server")
  networkCards?: ServerHardwareNetworkCard[];
}

@doc("The different power states of the server")
union PowerState {
  @doc("On")
  On: "On",

  @doc("Off")
  Off: "Off",

  @doc("Powering on")
  PoweringOn: "PoweringOn",

  @doc("Powering off")
  PoweringOff: "PoweringOff",

  @doc("Paused")
  Paused: "Paused",

  string,
}
