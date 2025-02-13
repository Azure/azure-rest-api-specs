import "./Port.tsp";

using OpenAPI;

@doc("Information about a network device")
model NetDevice {
  @doc("Id of network device")
  netDeviceId: string;

  @doc("Manufacturer of the network device")
  manufacturer?: string;

  @doc("Model of the network device")
  `model`?: string;

  @doc("Part number of the network device")
  partNumber?: string;

  @doc("Serial number of the network device")
  serialNumber?: string;

  @doc("Firmware version of the network device")
  firmwareVersion?: string;

  @doc("Number of ports on the network device")
  portCount: int32;

  @doc("List of MACs for network device")
  netDeviceMacs: string[];

  @doc("Information of individual ports on network device")
  @extension("x-ms-identifiers", ["portId"])
  ports: Port[];
}
