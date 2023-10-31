import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

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

@doc("Enclave Endpoint Resource properties")
model EnclaveEndpointProperties {
  @extension("x-ms-identifiers", ["name"])
  @doc("Endpoint Rule Collection.")
  endpointRuleCollection?: EnclaveEndpointRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
