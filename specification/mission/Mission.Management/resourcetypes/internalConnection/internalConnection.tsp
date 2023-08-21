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

@doc("Specifies the different types of network connections.")
enum InternalConnectionType {
  @doc("InternalConnectionType Type PrivateLink")
  PrivateLink,

  @doc("InternalConnectionType Type NetworkSecurityGroup.")
  NetworkSecurityGroup,
}

@doc("Specifies the state of the internalConnection.")
enum InternalConnectionState {
  @renamedFrom(Microsoft.Mission.Versions.v2023_08_01_preview, "Pending")
  @doc("InternalConnectionState Type Pending Approval")
  PendingApproval,

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Pending Update")
  PendingUpdate,

  @doc("InternalConnectionState Type Approved")
  Approved,

  @doc("InternalConnectionState Type Active")
  Active,

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("InternalConnectionState Type Failed")
  Failed,
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
