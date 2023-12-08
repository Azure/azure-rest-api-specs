@doc("Base Endpoint Rule Properties")
model EndpointRuleBase {
  @doc("Endpoint Rule Name.")
  name?: string;

  @doc("Destination address. Can include multiple CIDR/IP Addresses or fqdn tags or fqdns (for community endpoint) separated by commas.")
  destination?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;
}
