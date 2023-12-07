import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/endpointrulebase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Enclave Endpoint Protocol Enum")
enum EnclaveEndpointProtocol {
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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2023_11_01_preview)
@doc("Enclave Endpoint Rule Properties")
model EnclaveEndpointRule {
  @doc("Endpoint Rule Name.")
  name?: string;

  @doc("IP Address. Can include multiple CIDR/IP Addresses separated by commas.")
  address?: string;

  @doc("Port. Can include multiple ports separated by commas or a range indicated by a hyphen.")
  port?: string;

  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EnclaveEndpointProtocol;
}

@doc("Enclave Endpoint Rule Properties")
model EnclaveEndpointDestinationRule is EndpointRuleBase {
  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: EnclaveEndpointProtocol[];
}

@doc("Enclave Endpoint Resource properties")
model EnclaveEndpointProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2023_11_01_preview)
  @extension("x-ms-identifiers", [])
  @doc("Enclave Endpoint Rule Collection.")
  ruleCollection: EnclaveEndpointDestinationRule[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_11_01_preview)
  @extension("x-ms-identifiers", ["name"])
  @doc("Endpoint Rule Collection.")
  endpointRuleCollection?: EnclaveEndpointRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
