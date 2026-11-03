import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Base Endpoint Rule Properties")
model EndpointRuleBase {
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "name")
  @doc("Endpoint Rule Name.")
  endpointRuleName?: string;

  @doc("Destination address. Can include multiple CIDR/IP Addresses or fqdn tags or fqdns (for community endpoint) separated by commas.")
  destination?: string;

  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "port")
  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  ports?: string;
}
