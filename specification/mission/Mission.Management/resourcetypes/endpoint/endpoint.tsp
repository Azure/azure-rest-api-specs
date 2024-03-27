import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../virtualEnclave/virtualenclave.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Endpoint Protocol Enum")
enum EndpointProtocol {
  @doc("EndpointProtocol Type ANY")
  ANY,

  @doc("EndpointProtocol Type TCP")
  TCP,

  @doc("EndpointProtocol Type UDP")
  UDP,

  @doc("EndpointProtocol Type ICMP")
  ICMP,

  @doc("EndpointProtocol Type ESP")
  ESP,

  @doc("EndpointProtocol Type AH")
  AH,
}

@doc("EndpointRule Properties")
model EndpointRule {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Endpoint Rule Id.")
  id?: string;

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Endpoint Rule Name.")
  name?: string;

  @doc("IP Address. Can include multiple CIDR/IP Addresses separated by commas.")
  address?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EndpointProtocol;
}

@doc("Endpoint Resource properties")
model EndpointProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Endpoint Description.")
  description?: string;

  @extension("x-ms-identifiers", ["name"])
  @doc("Endpoint Rule Collection.")
  endpointRuleCollection?: EndpointRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
