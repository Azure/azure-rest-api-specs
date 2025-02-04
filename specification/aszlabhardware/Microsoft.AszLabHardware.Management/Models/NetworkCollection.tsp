import "./NetDevice.tsp";

@doc("Information regarding the network of the server")
model NetworkCollection {
  @doc("The list of MAC addresses")
  systemMacs?: string[];

  @doc("Information about the individual network devices of the server")
  netDevices?: NetDevice[];
}
