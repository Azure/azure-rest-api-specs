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

@doc("Specifies the state of the externalConnection.")
enum ExternalConnectionState {
  @doc("ExternalConnectionState Type Pending")
  Pending,

  @doc("ExternalConnectionState Type Approved")
  Approved,

  @doc("ExternalConnectionState Type Active")
  Active,
}

@doc("Describes the properties of an External Connection.")
model ExternalConnectionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The state of the externalConnection.")
  state?: ExternalConnectionState;

  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("The enclaves' resource IDs.")
  enclaveIds: VirtualEnclaveResourceId[];

  @doc("The external CIDR IP addresses.")
  externalCidrs: string[];

  @doc("List of resource ids modified by externalConnections.")
  resourceCollection?: string[];
}
