import "./endpointProtocol.tsp";

@doc("EndpointRule Properties")
model EndpointRule {
  @doc("Endpoint Rule Name.")
  name?: string;

  @doc("IP Address. Can include multiple CIDR/IP Addresses separated by commas.")
  address?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EndpointProtocol;
}
