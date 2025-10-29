import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the state of the transitHub.")
union TransitHubState {
  string,

  @doc("TransitHubState Type PendingApproval")
  PendingApproval: "PendingApproval",

  @doc("TransitHubState Type Approved")
  Approved: "Approved",

  @doc("TransitHubState Type PendingUpdate")
  PendingUpdate: "PendingUpdate",

  @doc("TransitHubState Type Active")
  Active: "Active",

  @doc("TransitHubState Type Failed")
  Failed: "Failed",
}

@doc("Specifies the type of the transitOption.")
union TransitOptionType {
  string,

  @doc("TransitOptionType ExpressRoute")
  ExpressRoute: "ExpressRoute",

  @doc("TransitOptionType Gateway")
  Gateway: "Gateway",

  @doc("TransitOptionType Peering")
  Peering: "Peering",
}

@doc("TransitOptionParams Properties")
model TransitOptionParams {
  @doc("Transit Option Params scaleUnits.")
  scaleUnits?: int64;

  @doc("Transit Option Params remoteVirtualNetworkId.")
  remoteVirtualNetworkId?: VirtualNetworkResourceId;
}

@doc("TransitOption Properties")
model TransitOption {
  @doc("Transit Option Type.")
  type?: TransitOptionType;

  @doc("Transit Option Params")
  params?: TransitOptionParams;
}

@doc("Describes the properties of an Transit Hub.")
model TransitHubProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The state of the transitHub.")
  state?: TransitHubState;

  @doc("The TransitOption of the transitHub.")
  transitOption?: TransitOption;

  @doc("List of resource ids modified by transitHubs.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string[])
  resourceCollection?: armResourceIdentifier[];
}

@doc("Transit Hub patchable Properties")
model TransitHubPatchProperties
  is UpdateableProperties<OmitDefaults<TransitHubProperties>>;

@doc("TH Patch Resource")
model TransitHubPatchModel {
  @doc("The TransitHub resource.")
  properties?: TransitHubPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
