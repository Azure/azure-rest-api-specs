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

@doc("Enclave Endpoint Rule Properties")
model EnclaveEndpointDestinationRule extends EndpointRuleBase {
  @doc("Protocol. Options specified by Endpoint Protocol Enum.")
  protocol?: EnclaveEndpointProtocol[];
}

@doc("Enclave Endpoint Resource properties")
model EnclaveEndpointProperties {
  @extension("x-ms-identifiers", [])
  @doc("Enclave Endpoint Rule Collection.")
  ruleCollection: EnclaveEndpointDestinationRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
