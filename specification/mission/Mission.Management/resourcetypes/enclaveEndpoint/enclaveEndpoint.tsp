import "@typespec/rest";
import "@typespec/versioning";
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

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Enclave Endpoint Protocol Enum")
union EnclaveEndpointProtocol {
  @doc("EndpointProtocol Type ANY")
  ANY: "ANY",

  @doc("EndpointProtocol Type TCP")
  TCP: "TCP",

  @doc("EndpointProtocol Type UDP")
  UDP: "UDP",

  @doc("EndpointProtocol Type ICMP")
  ICMP: "ICMP",

  @doc("EndpointProtocol Type ESP")
  ESP: "ESP",

  @doc("EndpointProtocol Type AH")
  AH: "AH",

  string,
}

@doc("Enclave Endpoint Rule Properties")
model EnclaveEndpointDestinationRule is EndpointRuleBase {
  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: EnclaveEndpointProtocol[];
}

@doc("Enclave Endpoint Resource properties")
model EnclaveEndpointProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @extension("x-ms-identifiers", #[])
  @doc("Enclave Endpoint Rule Collection.")
  ruleCollection: EnclaveEndpointDestinationRule[];

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of resource ids created by community endpoint.")
  resourceCollection?: string[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Whether approval is needed for the connection (True or False).")
  approvalRequired?: boolean;
}

@doc("Enclave Endpoint Patch properties")
model EnclaveEndpointPatchProperties is EnclaveEndpointProperties;

@doc("Enclave Endpoint Patch Resource")
model EnclaveEndpointPatchResource {
  @doc("Enclave Endpoint Patch properties")
  properties?: Update<EnclaveEndpointPatchProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
