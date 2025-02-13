import "./NetDevice.tsp";

using OpenAPI;

@doc("Information regarding the network of the server")
model NetworkCollection {
  @doc("The list of MAC addresses")
  systemMacs?: string[];

  @doc("Information about the individual network devices of the server")
  @extension("x-ms-identifiers", ["netDeviceId"])
  netDevices?: NetDevice[];
}
