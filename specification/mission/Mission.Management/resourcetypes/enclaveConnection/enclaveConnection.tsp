import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the state of the enclave connection.")
union EnclaveConnectionState {
  @doc("EnclaveConnectionState Type Pending Approval")
  PendingApproval: "PendingApproval",

  @doc("EnclaveConnectionState Type Pending Update")
  PendingUpdate: "PendingUpdate",

  @doc("EnclaveConnectionState Type Approved")
  Approved: "Approved",

  @doc("EnclaveConnectionState Type Active")
  Active: "Active",

  @doc("EnclaveConnectionState Type Failed")
  Failed: "Failed",

  @doc("EnclaveConnectionState Type Connected")
  Connected: "Connected",

  @doc("EnclaveConnectionState Type Disconnected")
  Disconnected: "Disconnected",

  string,
}

@doc("Enclave Connection Resource properties")
model EnclaveConnectionProperties {
  @doc("The state of the enclaveConnection.")
  state?: EnclaveConnectionState;

  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("Source Resource Id.")
  sourceResourceId: EnclaveConnectionSourceResourceId;

  @doc("Source CIDR.")
  sourceCidr?: string;

  @doc("Source IP group Resource Id.")
  ipGroup?: IPGroupResourceId;

  @doc("Destination Endpoint Resource Id.")
  destinationEndpointId: DestinationEndpointResourceId;

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("List of resource ids modified by enclave Connections.")
  resourceCollection?: string[];
}

@doc("Enclave Connection Patch properties")
model EnclaveConnectionPatchProperties is EnclaveConnectionProperties;

@doc("Enclave Connection Patch Resource")
model EnclaveConnectionPatchResource {
  @doc("Enclave Connection Patch properties")
  properties?: Update<EnclaveConnectionPatchProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
