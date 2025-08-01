import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Enclave Endpoint Protocol Enum")
union EnclaveEndpointProtocol {
  string,

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
}

@doc("Enclave Endpoint Rule Properties")
model EnclaveEndpointDestinationRule {
  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: EnclaveEndpointProtocol[];

  ...EndpointRuleBase;
}

@doc("Enclave Endpoint Resource properties")
model EnclaveEndpointProperties {
  @extension("x-ms-identifiers", #[])
  @doc("Enclave Endpoint Rule Collection.")
  ruleCollection: EnclaveEndpointDestinationRule[];

  @doc("List of resource ids created by community endpoint.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string[])
  resourceCollection?: armResourceIdentifier[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Whether approval is needed for the connection (True or False).")
  approvalRequired?: boolean;
}

@doc("Enclave Endpoint patchable Properties")
model EnclaveEndpointPatchProperties
  is UpdateableProperties<OmitDefaults<EnclaveEndpointProperties>>;

@doc("Enclave Endpoint Patch Resource")
model EnclaveEndpointPatchModel {
  @doc("Enclave Endpoint Patch properties")
  properties?: EnclaveEndpointPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
