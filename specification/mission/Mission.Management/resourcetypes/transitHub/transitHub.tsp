import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the state of the transitHub.")
union TransitHubState {
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

  string,
}

@doc("Specifies the type of the transitOption.")
union TransitOptionType {
  @doc("TransitOptionType ExpressRoute")
  ExpressRoute: "ExpressRoute",

  @doc("TransitOptionType Gateway")
  Gateway: "Gateway",

  @doc("TransitOptionType Peering")
  Peering: "Peering",

  string,
}

@doc("TransitOptionParams Properties")
model TransitOptionParams {
  @doc("Transit Option Params scaleUnits.")
  scaleUnits?: int64;

  @doc("Transit Option Params remoteVirtualNetworkId.")
  remoteVirtualNetworkId?: string;
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
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the transitHub.")
  state?: TransitHubState;

  @doc("The TransitOption of the transitHub.")
  transitOption?: TransitOption;

  @doc("List of resource ids modified by transitHubs.")
  resourceCollection?: string[];
}
