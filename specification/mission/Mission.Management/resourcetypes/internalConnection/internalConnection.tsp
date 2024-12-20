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

@doc("Specifies the different types of network connections.")
union InternalConnectionType {
  @doc("InternalConnectionType Type PrivateLink")
  PrivateLink: "PrivateLink",

  @doc("InternalConnectionType Type NetworkSecurityGroup.")
  NetworkSecurityGroup: "NetworkSecurityGroup",

  string,
}

@doc("Specifies the state of the internalConnection.")
union InternalConnectionState {
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Pending")
  Pending: "Pending",

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Pending Approval")
  PendingApproval: "PendingApproval",

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Pending Update")
  PendingUpdate: "PendingUpdate",

  @doc("InternalConnectionState Type Approved")
  Approved: "Approved",

  @doc("InternalConnectionState Type Active")
  Active: "Active",

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Failed")
  Failed: "Failed",

  string,
}

@doc("Describes the properties of an Internal Connection.")
model InternalConnectionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Specifies the type of internal connection. \n Possible values are:\n PrivateLink \n NetworkSecurityGroup")
  connectionType: InternalConnectionType;

  @doc("The state of the internalConnection.")
  state?: InternalConnectionState;

  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("The destination enclave's resource ID.")
  destinationEnclaveId: VirtualEnclaveResourceId;

  @doc("The destination endpoint's resource ID.")
  destinationEndpointId: EndpointResourceId;

  @doc("The source enclave's resource ID.")
  sourceEnclaveId: VirtualEnclaveResourceId;

  @doc("The source CIDR IP addresses.")
  sourceCidrs: string[];

  @doc("List of resource ids modified by internalConnections.")
  resourceCollection?: string[];
}
