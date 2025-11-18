import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the state of the enclave connection.")
union EnclaveConnectionState {
  string,

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
}

@doc("Enclave Connection Resource properties")
model EnclaveConnectionProperties {
  @doc("The state of the enclaveConnection.")
  @visibility(Lifecycle.Read)
  state?: EnclaveConnectionState;

  @doc("Community Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communityResourceId: CommunityResourceId;

  @doc("Source Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceResourceId: EnclaveConnectionSourceResourceId;

  @doc("Source CIDR.")
  sourceCidr?: string;

  @removed(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Source IP group Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipGroup?: IPGroupResourceId;

  @doc("Destination Endpoint Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  destinationEndpointId: DestinationEndpointResourceId;

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("List of resource ids modified by enclave Connections.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string[])
  resourceCollection?: armResourceIdentifier[];

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Destination Endpoint supports automatic or manual updates.")
  @visibility(Lifecycle.Read)
  updateMode?: UpdateMode;
}

@doc("Enclave Connection patchable Properties")
model EnclaveConnectionPatchProperties
  is UpdateableProperties<OmitDefaults<EnclaveConnectionProperties>>;

@doc("Enclave Connection Patch Resource")
model EnclaveConnectionPatchModel {
  @doc("Enclave Connection Patch properties")
  properties?: EnclaveConnectionPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
